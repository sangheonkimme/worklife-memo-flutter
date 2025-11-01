import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/note_provider.dart';
import '../../providers/folder_provider.dart';
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
  String? _selectedFolderId; // null means "all notes"

  @override
  Widget build(BuildContext context) {
    // Load folders for filter chips
    final foldersAsync = ref.watch(folderListProvider);

    // Load notes based on selected folder
    final notesAsync = _selectedFolderId == null
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Row(
                    children: [
                      const Text(
                        '메모',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF7C4DFF),
                        ),
                      ),
                    ],
                  ),
                ),
                // 검색 바
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: InkWell(
                    onTap: () {
                      context.push('/search');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      child: Row(
                        children: [
                          const Icon(Icons.search, size: 22, color: Colors.grey),
                          const SizedBox(width: 12),
                          Text(
                            '검색...',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Filter chips
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        // "모든 메모" 버튼
                        _buildFilterChip(
                          label: '모든 메모',
                          isSelected: _selectedFolderId == null,
                          onTap: () {
                            setState(() {
                              _selectedFolderId = null;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        // Folder chips
                        foldersAsync.when(
                          data: (folders) {
                            return Row(
                              children: folders.map((folder) {
                                final isSelected = _selectedFolderId == folder.id;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: _buildFilterChip(
                                    label: folder.name,
                                    icon: Icons.folder_outlined,
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        _selectedFolderId = isSelected ? null : folder.id;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            );
                          },
                          loading: () => const SizedBox.shrink(),
                          error: (_, __) => const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
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
                            padding: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
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
      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF7C4DFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: IconButton(
          onPressed: () => _createNewNote(context),
          icon: const Icon(Icons.add, color: Colors.white, size: 28),
          iconSize: 56,
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }

  /// Filter chip builder
  Widget _buildFilterChip({
    required String label,
    IconData? icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7C4DFF) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? const Color(0xFF7C4DFF) : Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 새 메모 작성
  void _createNewNote(BuildContext context) {
    context.push('/note/new');
  }
}
