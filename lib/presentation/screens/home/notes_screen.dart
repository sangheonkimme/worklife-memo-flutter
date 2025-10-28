import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/note.dart';
import '../../providers/note_provider.dart';
import '../../widgets/common/app_empty_widget.dart';
import '../../widgets/common/app_loading_indicator.dart';
import '../../widgets/common/app_error_widget.dart';
import '../../widgets/note/note_card.dart';

/// Notes Screen
/// 메모 목록 화면
class NotesScreen extends ConsumerWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesAsync = ref.watch(noteListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('메모'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색 화면으로 이동 (Week 7)
            },
            tooltip: '검색',
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: 메뉴 표시
            },
            tooltip: '더보기',
          ),
        ],
      ),
      drawer: const _NotesDrawer(),
      body: notesAsync.when(
        data: (notes) {
          if (notes.isEmpty) {
            return AppEmptyWidget.noNotes(
              onCreateNote: () => _createNewNote(context),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              return ref.refresh(noteListProvider.future);
            },
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,
                  onTap: () {
                    context.push('/note/${note.id}');
                  },
                  onLongPress: () {
                    _showNoteMenu(context, ref, note);
                  },
                );
              },
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _createNewNote(context),
        icon: const Icon(Icons.add),
        label: const Text('새 메모'),
      ),
    );
  }

  /// 새 메모 작성
  void _createNewNote(BuildContext context) {
    context.push('/note/new');
  }

  /// 메모 메뉴 표시
  void _showNoteMenu(BuildContext context, WidgetRef ref, Note note) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                ),
                title: Text(note.isPinned ? '고정 해제' : '고정'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(noteListProvider.notifier).togglePin(note.id);
                },
              ),
              ListTile(
                leading: Icon(
                  note.isFavorite ? Icons.star : Icons.star_outline,
                ),
                title: Text(note.isFavorite ? '즐겨찾기 해제' : '즐겨찾기'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: toggleFavorite 구현 필요
                },
              ),
              ListTile(
                leading: const Icon(Icons.archive_outlined),
                title: const Text('보관'),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(noteListProvider.notifier).toggleArchive(note.id);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: const Text('삭제', style: TextStyle(color: Colors.red)),
                onTap: () {
                  Navigator.pop(context);
                  ref.read(noteListProvider.notifier).deleteNote(note.id);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Notes Drawer
/// 폴더 트리 표시용 드로어
class _NotesDrawer extends StatelessWidget {
  const _NotesDrawer();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.folder,
                  size: 48,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                const SizedBox(height: 8),
                Text(
                  '폴더',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.inbox),
            title: const Text('모든 메모'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.push_pin_outlined),
            title: const Text('고정된 메모'),
            onTap: () {
              Navigator.pop(context);
              // TODO: 고정 메모 필터
            },
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text('즐겨찾기'),
            onTap: () {
              Navigator.pop(context);
              // TODO: 즐겨찾기 필터
            },
          ),
          ListTile(
            leading: const Icon(Icons.archive_outlined),
            title: const Text('보관됨'),
            onTap: () {
              Navigator.pop(context);
              // TODO: 보관 메모 필터
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline),
            title: const Text('휴지통'),
            onTap: () {
              Navigator.pop(context);
              // TODO: 삭제된 메모 필터
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  '내 폴더',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add, size: 20),
                  onPressed: () {
                    // TODO: 폴더 생성
                  },
                  tooltip: '폴더 추가',
                ),
              ],
            ),
          ),
          // TODO: 실제 폴더 리스트 (Week 6에서 구현)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '폴더가 없습니다',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
