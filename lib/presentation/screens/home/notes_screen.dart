import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/note_provider.dart';
import '../../providers/folder_provider.dart';
import '../../providers/tag_provider.dart';
import '../../widgets/common/app_empty_widget.dart';
import '../../widgets/common/app_loading_indicator.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/note/note_card.dart';

/// Notes Screen
/// 메모 목록 화면
class NotesScreen extends ConsumerStatefulWidget {
  const NotesScreen({super.key});

  @override
  ConsumerState<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends ConsumerState<NotesScreen> {
  final _searchController = TextEditingController();
  String? _selectedFolderId; // null means "all notes"
  String? _selectedTagId; // null means "no tag filter"

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Load folders for filter chips
    final foldersAsync = ref.watch(folderListProvider);

    // Load tags for filter chips
    final tagsAsync = ref.watch(tagListProvider);

    // Load notes based on selected folder and tag
    final notesAsync = _selectedTagId != null
        ? ref.watch(notesByTagProvider(_selectedTagId!))
        : _selectedFolderId == null
            ? ref.watch(noteListProvider)
            : ref.watch(notesByFolderProvider(_selectedFolderId!));

    return Scaffold(
      body: notesAsync.when(
        data: (notes) {
          return SafeArea(
            child: Column(
              children: [
                // 상단 바: 제목
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                  child: Row(
                    children: [
                      Text(
                        '메모',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
                // 검색 바
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '검색...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                    onChanged: (value) {
                      // TODO: 검색 구현 (Week 7)
                    },
                  ),
                ),
                // "모든 메모" 버튼
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedFolderId = null;
                          _selectedTagId = null;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedFolderId == null && _selectedTagId == null
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.surfaceContainerHighest,
                        foregroundColor: _selectedFolderId == null && _selectedTagId == null
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('모든 메모'),
                    ),
                  ),
                ),
                // Folder filter chips
                foldersAsync.when(
                  data: (folders) {
                    if (folders.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '폴더',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.6),
                                ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: folders.map((folder) {
                                final isSelected = _selectedFolderId == folder.id &&
                                    _selectedTagId == null;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(folder.name),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedFolderId = selected ? folder.id : null;
                                        _selectedTagId = null; // Clear tag filter
                                      });
                                    },
                                    avatar: Icon(
                                      Icons.folder,
                                      size: 18,
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.onSecondaryContainer
                                          : Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                // Tag filter chips
                tagsAsync.when(
                  data: (tags) {
                    if (tags.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '태그',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.6),
                                ),
                          ),
                          const SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: tags.map((tag) {
                                final isSelected = _selectedTagId == tag.id;
                                final tagColor = Color(int.parse(tag.color, radix: 16));
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    label: Text(tag.name),
                                    selected: isSelected,
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedTagId = selected ? tag.id : null;
                                        _selectedFolderId = null; // Clear folder filter
                                      });
                                    },
                                    backgroundColor: tagColor.withValues(alpha: 0.2),
                                    selectedColor: tagColor.withValues(alpha: 0.4),
                                    labelStyle: TextStyle(
                                      color: isSelected ? tagColor : tagColor.withValues(alpha: 0.8),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    avatar: Icon(
                                      Icons.label,
                                      size: 18,
                                      color: tagColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
                // 메모 리스트
                Expanded(
                  child: notes.isEmpty
                      ? AppEmptyWidget.noNotes(
                          onCreateNote: () => _createNewNote(context),
                        )
                      : RefreshIndicator(
                          onRefresh: () async {
                            return ref.refresh(noteListProvider.future);
                          },
                          child: ListView.builder(
                            itemCount: notes.length,
                            padding: const EdgeInsets.only(bottom: 80),
                            itemBuilder: (context, index) {
                              final note = notes[index];
                              return NoteCard(
                                note: note,
                                onTap: () {
                                  context.push('/note/${note.id}');
                                },
                                onPin: () {
                                  ref.read(noteListProvider.notifier).togglePin(note.id);
                                },
                                onDelete: () {
                                  ref.read(noteListProvider.notifier).deleteNote(note.id);
                                },
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          );
        },
        loading: () => const AppLoadingIndicator(message: '메모 로딩 중...'),
        error: (error, stack) => AppErrorWidget.loadFailed(
          message: '메모를 불러오는데 실패했습니다',
          onRetry: () => ref.refresh(noteListProvider.future),
          isFullScreen: true,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewNote(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  /// 새 메모 작성
  void _createNewNote(BuildContext context) {
    context.push('/note/new');
  }
}
