import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/note.dart';

/// 메모 카드 위젯
///
/// 메모 목록에서 개별 메모를 표시하는 카드
class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onPin;
  final VoidCallback? onFavorite;
  final VoidCallback? onDelete;

  const NoteCard({
    super.key,
    required this.note,
    this.onTap,
    this.onLongPress,
    this.onPin,
    this.onFavorite,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('yyyy-MM-dd HH:mm');

    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 상단: 제목 + 아이콘
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 제목
                  Expanded(
                    child: Text(
                      note.title.isEmpty ? '(제목 없음)' : note.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 고정/즐겨찾기 아이콘
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (note.isPinned)
                        Icon(
                          Icons.push_pin,
                          size: 16,
                          color: theme.colorScheme.primary,
                        ),
                      if (note.isFavorite) ...[
                        if (note.isPinned) const SizedBox(width: 4),
                        Icon(
                          Icons.star,
                          size: 16,
                          color: theme.colorScheme.secondary,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 내용 미리보기
              if (note.content.isNotEmpty) ...[
                Text(
                  note.preview,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
              ],
              // 하단: 타입 + 날짜 + 태그
              Row(
                children: [
                  // 메모 타입 아이콘
                  _buildTypeIcon(theme),
                  const SizedBox(width: 8),
                  // 날짜
                  Text(
                    dateFormat.format(note.updatedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                  const Spacer(),
                  // 태그 개수
                  if (note.tags.isNotEmpty) ...[
                    Icon(
                      Icons.label_outline,
                      size: 14,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${note.tags.length}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 메모 타입별 아이콘
  Widget _buildTypeIcon(ThemeData theme) {
    IconData iconData;
    switch (note.type) {
      case NoteType.richText:
        iconData = Icons.text_fields;
        break;
      case NoteType.markdown:
        iconData = Icons.code;
        break;
      case NoteType.checklist:
        iconData = Icons.checklist;
        break;
    }

    return Icon(
      iconData,
      size: 16,
      color: theme.colorScheme.primary.withValues(alpha: 0.7),
    );
  }
}
