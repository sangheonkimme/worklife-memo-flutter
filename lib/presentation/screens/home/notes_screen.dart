import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/note_provider.dart';
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesAsync = ref.watch(noteListProvider);

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
                        // 모든 메모 보기 (현재 기본 동작)
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('모든 메모'),
                    ),
                  ),
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
