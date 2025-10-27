import 'package:flutter/material.dart';

/// 앱 빈 상태 위젯
/// 리스트가 비어있을 때 표시
class AppEmptyWidget extends StatelessWidget {
  final String message;
  final String? title;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const AppEmptyWidget({
    super.key,
    required this.message,
    this.title,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
  });

  /// 메모 없음용 생성자
  factory AppEmptyWidget.noNotes({
    VoidCallback? onCreateNote,
  }) {
    return AppEmptyWidget(
      message: '메모를 작성하여 아이디어를 기록하세요',
      title: '메모가 없습니다',
      icon: Icons.note_add_outlined,
      onAction: onCreateNote,
      actionLabel: '새 메모 작성',
    );
  }

  /// 검색 결과 없음용 생성자
  factory AppEmptyWidget.noSearchResults({
    String? query,
  }) {
    return AppEmptyWidget(
      message: query != null
          ? '"$query"에 대한 검색 결과가 없습니다'
          : '검색 결과가 없습니다',
      title: '결과 없음',
      icon: Icons.search_off,
    );
  }

  /// 폴더 없음용 생성자
  factory AppEmptyWidget.noFolders({
    VoidCallback? onCreateFolder,
  }) {
    return AppEmptyWidget(
      message: '폴더를 만들어 메모를 정리하세요',
      title: '폴더가 없습니다',
      icon: Icons.folder_outlined,
      onAction: onCreateFolder,
      actionLabel: '폴더 만들기',
    );
  }

  /// 태그 없음용 생성자
  factory AppEmptyWidget.noTags({
    VoidCallback? onCreateTag,
  }) {
    return AppEmptyWidget(
      message: '태그를 만들어 메모를 분류하세요',
      title: '태그가 없습니다',
      icon: Icons.label_outlined,
      onAction: onCreateTag,
      actionLabel: '태그 만들기',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 80,
              color: theme.colorScheme.outline.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 20),
            if (title != null) ...[
              Text(
                title!,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onAction,
                icon: const Icon(Icons.add),
                label: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
