import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/search_provider.dart';
import '../../providers/folder_provider.dart';
import '../../widgets/common/app_loading_indicator.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/note/note_card.dart';
import '../../../domain/entities/note.dart';

/// 검색 화면
class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _showFilters = false;

  @override
  void initState() {
    super.initState();
    // 화면 진입 시 자동으로 검색창에 포커스
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(filteredSearchResultsProvider);
    final searchHistory = ref.watch(searchHistoryProvider);
    final sortOption = ref.watch(sortOptionStateProvider);
    final filters = ref.watch(searchFiltersStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
            hintText: '검색...',
            hintStyle: const TextStyle(fontSize: 16),
            border: InputBorder.none,
            suffixIcon: searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(searchQueryProvider.notifier).clear();
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            ref.read(searchQueryProvider.notifier).setQuery(value);
          },
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              ref.read(searchHistoryProvider.notifier).addSearchQuery(value);
            }
          },
        ),
        actions: [
          // 필터 버튼
          IconButton(
            icon: Icon(
              _showFilters ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: filters.hasFilters
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
          ),
          // 정렬 버튼
          PopupMenuButton<SortOption>(
            icon: const Icon(Icons.sort),
            onSelected: (option) {
              ref.read(sortOptionStateProvider.notifier).setSortOption(option);
            },
            itemBuilder: (context) {
              return SortOption.values.map((option) {
                return PopupMenuItem<SortOption>(
                  value: option,
                  child: Row(
                    children: [
                      if (option == sortOption)
                        const Icon(Icons.check, size: 20)
                      else
                        const SizedBox(width: 20),
                      const SizedBox(width: 8),
                      Text(option.label),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 필터 섹션
          if (_showFilters) _buildFilterSection(),

          // 검색 결과
          Expanded(
            child: _buildSearchContent(searchQuery, searchResults, searchHistory),
          ),
        ],
      ),
    );
  }

  /// 필터 섹션
  Widget _buildFilterSection() {
    final filters = ref.watch(searchFiltersStateProvider);
    final folders = ref.watch(folderListProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '필터',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (filters.hasFilters)
                TextButton(
                  onPressed: () {
                    ref.read(searchFiltersStateProvider.notifier).clearFilters();
                  },
                  child: const Text('초기화'),
                ),
            ],
          ),
          const SizedBox(height: 12),

          // 노트 타입 필터
          const Text(
            '노트 타입',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: NoteType.values.map((type) {
              final isSelected = filters.noteTypes.contains(type);
              return FilterChip(
                label: Text(_getNoteTypeLabel(type)),
                selected: isSelected,
                onSelected: (selected) {
                  final newTypes = List<NoteType>.from(filters.noteTypes);
                  if (selected) {
                    newTypes.add(type);
                  } else {
                    newTypes.remove(type);
                  }
                  ref
                      .read(searchFiltersStateProvider.notifier)
                      .setNoteTypeFilter(newTypes);
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // 폴더 필터
          folders.when(
            data: (folderList) {
              if (folderList.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '폴더',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: folderList.map((folder) {
                      final isSelected = filters.folderIds.contains(folder.id);
                      return FilterChip(
                        avatar: const Icon(Icons.folder, size: 16),
                        label: Text(folder.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          final newFolders =
                              List<String>.from(filters.folderIds);
                          if (selected) {
                            newFolders.add(folder.id);
                          } else {
                            newFolders.remove(folder.id);
                          }
                          ref
                              .read(searchFiltersStateProvider.notifier)
                              .setFolderFilter(newFolders);
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),

          // 기타 필터
          Row(
            children: [
              Expanded(
                child: CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('고정된 메모만'),
                  value: filters.isPinned ?? false,
                  tristate: true,
                  onChanged: (value) {
                    ref
                        .read(searchFiltersStateProvider.notifier)
                        .setPinnedFilter(value);
                  },
                ),
              ),
              Expanded(
                child: CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('즐겨찾기만'),
                  value: filters.isFavorite ?? false,
                  tristate: true,
                  onChanged: (value) {
                    ref
                        .read(searchFiltersStateProvider.notifier)
                        .setFavoriteFilter(value);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 검색 콘텐츠
  Widget _buildSearchContent(
    String searchQuery,
    AsyncValue<List<Note>> searchResults,
    List<String> searchHistory,
  ) {
    // 검색어가 없을 때 - 검색 기록 표시
    if (searchQuery.isEmpty) {
      return _buildSearchHistory(searchHistory);
    }

    // 검색 중
    return searchResults.when(
      data: (notes) {
        if (notes.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  '검색 결과가 없습니다',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    _searchController.clear();
                    ref.read(searchQueryProvider.notifier).clear();
                  },
                  child: const Text('검색어 지우기'),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            return ref.refresh(filteredSearchResultsProvider.future);
          },
          child: ListView.builder(
            itemCount: notes.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final note = notes[index];
              return NoteCard(
                note: note,
                onTap: () {
                  context.push('/note/${note.id}');
                },
                onPin: () {
                  ref.read(searchResultsProvider.notifier).refresh();
                },
                onDelete: () {
                  ref.read(searchResultsProvider.notifier).refresh();
                },
              );
            },
          ),
        );
      },
      loading: () => const AppLoadingIndicator(message: '검색 중...'),
      error: (error, stack) => AppErrorWidget.loadFailed(
        message: '검색에 실패했습니다',
        onRetry: () => ref.refresh(filteredSearchResultsProvider.future),
      ),
    );
  }

  /// 검색 기록
  Widget _buildSearchHistory(List<String> history) {
    if (history.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '검색어를 입력하세요',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '최근 검색',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {
                ref.read(searchHistoryProvider.notifier).clearHistory();
              },
              child: const Text('전체 삭제'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...history.map((query) {
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(query),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                ref.read(searchHistoryProvider.notifier).removeSearchQuery(query);
              },
            ),
            onTap: () {
              _searchController.text = query;
              ref.read(searchQueryProvider.notifier).setQuery(query);
            },
          );
        }),
      ],
    );
  }

  String _getNoteTypeLabel(NoteType type) {
    switch (type) {
      case NoteType.richText:
        return '리치 텍스트';
      case NoteType.markdown:
        return '마크다운';
      case NoteType.checklist:
        return '체크리스트';
    }
  }
}
