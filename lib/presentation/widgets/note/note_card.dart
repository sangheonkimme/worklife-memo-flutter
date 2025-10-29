import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
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

  /// 체크리스트 완료도 가져오기
  (int completed, int total) _getChecklistProgress() {
    if (note.type != NoteType.checklist || note.content.isEmpty) {
      return (0, 0);
    }

    try {
      final List<dynamic> items = jsonDecode(note.content);
      final completed = items.where((item) => item['isCompleted'] == true).length;
      return (completed, items.length);
    } catch (e) {
      return (0, 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final (completedCount, totalCount) = _getChecklistProgress();

    // timeago 한국어 설정
    timeago.setLocaleMessages('ko', timeago.KoMessages());

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
              // 상단: 제목 + 핀/삭제 아이콘
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
                  // 핀 아이콘 버튼
                  InkWell(
                    onTap: onPin,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        note.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                        size: 20,
                        color: note.isPinned
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurface.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  // 삭제 아이콘 버튼
                  InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: theme.colorScheme.error,
                      ),
                    ),
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
              // 체크리스트 완료도
              if (note.type == NoteType.checklist && totalCount > 0) ...[
                Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$completedCount/$totalCount 완료',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              // 태그 표시
              if (note.tags.isNotEmpty) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: note.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '#${tag.name}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
              ],
              // 하단: 날짜
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    timeago.format(note.updatedAt, locale: 'ko'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
