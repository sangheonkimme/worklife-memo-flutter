import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/tag.dart';
import '../../domain/usecases/tag/create_tag.dart';
import '../../domain/usecases/tag/update_tag.dart';
import '../../domain/usecases/tag/delete_tag.dart';
import '../../domain/usecases/tag/get_tags.dart';
import '../../domain/usecases/tag/get_tag_by_id.dart';
import '../../domain/usecases/tag/search_tags.dart';
import 'tag_repository_provider.dart';

part 'tag_provider.g.dart';

/// 태그 목록 상태 Provider (AsyncNotifier)
///
/// 모든 태그 목록을 관리하고 CRUD 작업을 수행합니다.
@riverpod
class TagList extends _$TagList {
  late GetTags _getTags;
  late CreateTag _createTag;
  late UpdateTag _updateTag;
  late DeleteTag _deleteTag;

  @override
  Future<List<Tag>> build() async {
    // UseCase 초기화
    final repository = ref.watch(tagRepositoryProvider);
    _getTags = GetTags(repository);
    _createTag = CreateTag(repository);
    _updateTag = UpdateTag(repository);
    _deleteTag = DeleteTag(repository);

    // 모든 태그 목록 로드
    return await _getTags();
  }

  /// 태그 목록 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getTags();
    });
  }

  /// 태그 생성
  Future<Tag> createTag(Tag tag) async {
    try {
      final createdTag = await _createTag(tag);
      await refresh();
      return createdTag;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  /// 태그 이름과 색상으로 생성
  Future<Tag> createTagByNameAndColor({
    required String name,
    required String color,
  }) async {
    try {
      final createdTag = await _createTag.createByNameAndColor(
        name: name,
        color: color,
      );
      await refresh();
      return createdTag;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  /// 태그 업데이트
  Future<void> updateTag(Tag tag) async {
    try {
      await _updateTag(tag);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 태그 이름 변경
  Future<void> renameTag(String id, String newName) async {
    try {
      await _updateTag.renameTag(id, newName);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 태그 색상 변경
  Future<void> changeTagColor(String id, String newColor) async {
    try {
      await _updateTag.changeColor(id, newColor);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 태그 삭제
  Future<void> deleteTag(String id) async {
    try {
      await _deleteTag(id);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 사용되지 않는 태그 삭제
  Future<void> deleteUnusedTags() async {
    try {
      await _deleteTag.deleteUnusedTags();
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 태그 병합
  Future<void> mergeTags(String fromTagId, String toTagId) async {
    try {
      await _updateTag.mergeTags(fromTagId, toTagId);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 인기 태그 목록 Provider
@riverpod
Future<List<Tag>> popularTags(PopularTagsRef ref, {int limit = 10}) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTags = GetTags(repository);
  return await getTags.getPopularTags(limit: limit);
}

/// 최근 사용한 태그 목록 Provider
@riverpod
Future<List<Tag>> recentTags(RecentTagsRef ref, {int limit = 10}) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTags = GetTags(repository);
  return await getTags.getRecentTags(limit: limit);
}

/// 사용되지 않는 태그 목록 Provider
@riverpod
Future<List<Tag>> unusedTags(UnusedTagsRef ref) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTags = GetTags(repository);
  return await getTags.getUnusedTags();
}

/// 태그 검색 Provider (자동완성용)
@riverpod
Future<List<Tag>> searchTags(SearchTagsRef ref, String query) async {
  final repository = ref.watch(tagRepositoryProvider);
  final searchTagsUseCase = SearchTags(repository);
  return await searchTagsUseCase(query);
}

/// 단일 태그 조회 Provider
@riverpod
Future<Tag?> tag(TagRef ref, String tagId) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTagById = GetTagById(repository);
  return await getTagById(tagId);
}

/// 태그 개수 Provider
@riverpod
Future<int> tagCount(TagCountRef ref) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTags = GetTags(repository);
  return await getTags.getTagCount();
}

/// 태그가 사용된 메모 개수 Provider
@riverpod
Future<int> noteCountWithTag(NoteCountWithTagRef ref, String tagId) async {
  final repository = ref.watch(tagRepositoryProvider);
  final getTagById = GetTagById(repository);
  return await getTagById.getNoteCountWithTag(tagId);
}
