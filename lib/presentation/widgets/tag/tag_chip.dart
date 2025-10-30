import 'package:flutter/material.dart';
import '../../../domain/entities/tag.dart';

/// 태그 칩 위젯
///
/// 태그를 칩 형태로 표시하는 위젯입니다.
class TagChip extends StatelessWidget {
  /// 표시할 태그
  final Tag tag;

  /// 삭제 버튼 표시 여부
  final bool showDelete;

  /// 삭제 콜백
  final VoidCallback? onDeleted;

  /// 탭 콜백
  final VoidCallback? onTap;

  /// 크기 (small, medium, large)
  final TagChipSize size;

  const TagChip({
    super.key,
    required this.tag,
    this.showDelete = false,
    this.onDeleted,
    this.onTap,
    this.size = TagChipSize.medium,
  });

  @override
  Widget build(BuildContext context) {
    final color = Color(int.parse(tag.color, radix: 16));

    // 크기에 따른 스타일
    final fontSize = switch (size) {
      TagChipSize.small => 12.0,
      TagChipSize.medium => 14.0,
      TagChipSize.large => 16.0,
    };

    final padding = switch (size) {
      TagChipSize.small => const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      TagChipSize.medium => const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      TagChipSize.large => const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    };

    final widget = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 태그 이름
          Text(
            tag.name,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
            ),
          ),

          // 삭제 버튼
          if (showDelete && onDeleted != null) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: onDeleted,
              child: Icon(
                Icons.close,
                size: fontSize + 2,
                color: color,
              ),
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: widget,
      );
    }

    return widget;
  }
}

/// 태그 칩 크기
enum TagChipSize {
  small,
  medium,
  large,
}

/// 태그 목록을 Wrap으로 표시하는 위젯
class TagChipList extends StatelessWidget {
  /// 표시할 태그 목록
  final List<Tag> tags;

  /// 삭제 버튼 표시 여부
  final bool showDelete;

  /// 삭제 콜백
  final ValueChanged<Tag>? onDeleted;

  /// 탭 콜백
  final ValueChanged<Tag>? onTap;

  /// 크기
  final TagChipSize size;

  /// 최대 표시 개수 (null이면 모두 표시)
  final int? maxVisible;

  const TagChipList({
    super.key,
    required this.tags,
    this.showDelete = false,
    this.onDeleted,
    this.onTap,
    this.size = TagChipSize.medium,
    this.maxVisible,
  });

  @override
  Widget build(BuildContext context) {
    if (tags.isEmpty) return const SizedBox.shrink();

    final visibleTags = maxVisible != null && tags.length > maxVisible!
        ? tags.take(maxVisible!).toList()
        : tags;

    final hiddenCount = maxVisible != null && tags.length > maxVisible!
        ? tags.length - maxVisible!
        : 0;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ...visibleTags.map(
          (tag) => TagChip(
            tag: tag,
            showDelete: showDelete,
            onDeleted: onDeleted != null ? () => onDeleted!(tag) : null,
            onTap: onTap != null ? () => onTap!(tag) : null,
            size: size,
          ),
        ),
        if (hiddenCount > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              '+$hiddenCount',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
