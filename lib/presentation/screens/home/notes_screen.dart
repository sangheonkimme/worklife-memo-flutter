import 'package:flutter/material.dart';
import '../../widgets/common/app_empty_widget.dart';

/// Notes Screen
/// 메모 목록 화면
class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // TODO: 검색 화면으로 이동
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
      body: AppEmptyWidget.noNotes(
        onCreateNote: () {
          // TODO: 새 메모 작성 화면으로 이동
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: 새 메모 작성
        },
        icon: const Icon(Icons.add),
        label: const Text('새 메모'),
      ),
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
