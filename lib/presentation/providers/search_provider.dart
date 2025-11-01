import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/search_notes.dart';
import 'note_repository_provider.dart';

part 'search_provider.g.dart';

/// 검색 쿼리 상태
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

/// 검색 결과 (디바운스 적용)
@riverpod
class SearchResults extends _$SearchResults {
  @override
  Future<List<Note>> build() async {
    final query = ref.watch(searchQueryProvider);

    if (query.trim().isEmpty) {
      return [];
    }

    // 디바운스를 위한 딜레이
    await Future.delayed(const Duration(milliseconds: 300));

    // 디바운스 후 query가 변경되었으면 취소
    final currentQuery = ref.read(searchQueryProvider);
    if (currentQuery != query) {
      return state.value ?? [];
    }

    final repository = ref.watch(noteRepositoryProvider);
    final searchUseCase = SearchNotes(repository);

    return await searchUseCase(query);
  }

  /// 검색 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final query = ref.read(searchQueryProvider);
      if (query.trim().isEmpty) {
        return [];
      }

      final repository = ref.read(noteRepositoryProvider);
      final searchUseCase = SearchNotes(repository);
      return await searchUseCase(query);
    });
  }
}

/// 검색 필터 모델
class SearchFilters {
  final List<String> folderIds;
  final List<String> tagIds;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<NoteType> noteTypes;
  final bool? isPinned;
  final bool? isFavorite;

  const SearchFilters({
    this.folderIds = const [],
    this.tagIds = const [],
    this.startDate,
    this.endDate,
    this.noteTypes = const [],
    this.isPinned,
    this.isFavorite,
  });

  SearchFilters copyWith({
    List<String>? folderIds,
    List<String>? tagIds,
    DateTime? startDate,
    DateTime? endDate,
    List<NoteType>? noteTypes,
    bool? isPinned,
    bool? isFavorite,
    bool clearStartDate = false,
    bool clearEndDate = false,
  }) {
    return SearchFilters(
      folderIds: folderIds ?? this.folderIds,
      tagIds: tagIds ?? this.tagIds,
      startDate: clearStartDate ? null : (startDate ?? this.startDate),
      endDate: clearEndDate ? null : (endDate ?? this.endDate),
      noteTypes: noteTypes ?? this.noteTypes,
      isPinned: isPinned ?? this.isPinned,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  bool get hasFilters =>
      folderIds.isNotEmpty ||
      tagIds.isNotEmpty ||
      startDate != null ||
      endDate != null ||
      noteTypes.isNotEmpty ||
      isPinned != null ||
      isFavorite != null;
}

/// 검색 필터 상태
@riverpod
class SearchFiltersState extends _$SearchFiltersState {
  @override
  SearchFilters build() => const SearchFilters();

  void setFolderFilter(List<String> folderIds) {
    state = state.copyWith(folderIds: folderIds);
  }

  void setTagFilter(List<String> tagIds) {
    state = state.copyWith(tagIds: tagIds);
  }

  void setDateRange(DateTime? start, DateTime? end) {
    state = state.copyWith(
      startDate: start,
      endDate: end,
      clearStartDate: start == null,
      clearEndDate: end == null,
    );
  }

  void setNoteTypeFilter(List<NoteType> types) {
    state = state.copyWith(noteTypes: types);
  }

  void setPinnedFilter(bool? isPinned) {
    state = state.copyWith(isPinned: isPinned);
  }

  void setFavoriteFilter(bool? isFavorite) {
    state = state.copyWith(isFavorite: isFavorite);
  }

  void clearFilters() {
    state = const SearchFilters();
  }
}

/// 정렬 옵션
enum SortOption {
  latest,
  oldest,
  titleAsc,
  titleDesc,
  createdDesc,
  createdAsc;

  String get label {
    switch (this) {
      case SortOption.latest:
        return '최신순';
      case SortOption.oldest:
        return '오래된순';
      case SortOption.titleAsc:
        return '제목순 (가나다)';
      case SortOption.titleDesc:
        return '제목순 (가나다 역순)';
      case SortOption.createdDesc:
        return '생성일순 (최신)';
      case SortOption.createdAsc:
        return '생성일순 (오래된)';
    }
  }

  int Function(Note, Note) get comparator {
    switch (this) {
      case SortOption.latest:
        return (a, b) => b.updatedAt.compareTo(a.updatedAt);
      case SortOption.oldest:
        return (a, b) => a.updatedAt.compareTo(b.updatedAt);
      case SortOption.titleAsc:
        return (a, b) => a.title.compareTo(b.title);
      case SortOption.titleDesc:
        return (a, b) => b.title.compareTo(a.title);
      case SortOption.createdDesc:
        return (a, b) => b.createdAt.compareTo(a.createdAt);
      case SortOption.createdAsc:
        return (a, b) => a.createdAt.compareTo(b.createdAt);
    }
  }
}

/// 정렬 옵션 상태
@riverpod
class SortOptionState extends _$SortOptionState {
  @override
  SortOption build() => SortOption.latest;

  void setSortOption(SortOption option) {
    state = option;
  }
}

/// 필터링 및 정렬된 검색 결과
@riverpod
class FilteredSearchResults extends _$FilteredSearchResults {
  @override
  Future<List<Note>> build() async {
    final results = await ref.watch(searchResultsProvider.future);
    final filters = ref.watch(searchFiltersStateProvider);
    final sortOption = ref.watch(sortOptionStateProvider);

    // 필터링
    var filteredResults = results.where((note) {
      // 폴더 필터
      if (filters.folderIds.isNotEmpty) {
        if (note.folder == null ||
            !filters.folderIds.contains(note.folder!.id)) {
          return false;
        }
      }

      // 태그 필터
      if (filters.tagIds.isNotEmpty) {
        final noteTagIds = note.tags.map((t) => t.id).toSet();
        if (!filters.tagIds.any((id) => noteTagIds.contains(id))) {
          return false;
        }
      }

      // 날짜 필터
      if (filters.startDate != null &&
          note.createdAt.isBefore(filters.startDate!)) {
        return false;
      }
      if (filters.endDate != null && note.createdAt.isAfter(filters.endDate!)) {
        return false;
      }

      // 노트 타입 필터
      if (filters.noteTypes.isNotEmpty &&
          !filters.noteTypes.contains(note.type)) {
        return false;
      }

      // 고정 필터
      if (filters.isPinned != null && note.isPinned != filters.isPinned) {
        return false;
      }

      // 즐겨찾기 필터
      if (filters.isFavorite != null &&
          note.isFavorite != filters.isFavorite) {
        return false;
      }

      return true;
    }).toList();

    // 정렬
    filteredResults.sort(sortOption.comparator);

    return filteredResults;
  }
}

/// 검색 기록 (최근 검색어 저장)
@riverpod
class SearchHistory extends _$SearchHistory {
  static const int maxHistorySize = 10;

  @override
  List<String> build() {
    // TODO: SharedPreferences에서 로드
    return [];
  }

  void addSearchQuery(String query) {
    if (query.trim().isEmpty) return;

    final newHistory = [query, ...state.where((q) => q != query)];
    if (newHistory.length > maxHistorySize) {
      newHistory.removeRange(maxHistorySize, newHistory.length);
    }

    state = newHistory;
    // TODO: SharedPreferences에 저장
  }

  void removeSearchQuery(String query) {
    state = state.where((q) => q != query).toList();
    // TODO: SharedPreferences에 저장
  }

  void clearHistory() {
    state = [];
    // TODO: SharedPreferences에서 삭제
  }
}
