import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/tag.dart';
import '../../providers/tag_provider.dart';

/// 태그 입력 필드 위젯 (자동완성 기능 포함)
///
/// 태그 이름을 입력하면 자동완성 제안을 표시하고,
/// 선택된 태그를 칩으로 표시합니다.
class TagInputField extends ConsumerStatefulWidget {
  /// 선택된 태그 목록
  final List<Tag> selectedTags;

  /// 태그 선택 시 콜백
  final ValueChanged<List<Tag>> onTagsChanged;

  /// 사용 가능한 색상 목록
  final List<Color>? availableColors;

  const TagInputField({
    super.key,
    required this.selectedTags,
    required this.onTagsChanged,
    this.availableColors,
  });

  @override
  ConsumerState<TagInputField> createState() => _TagInputFieldState();
}

class _TagInputFieldState extends ConsumerState<TagInputField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  String _searchQuery = '';
  bool _isSearching = false;

  // 기본 색상 목록
  final List<Color> _defaultColors = [
    const Color(0xFF6366F1), // Indigo
    const Color(0xFFA855F7), // Purple
    const Color(0xFFEC4899), // Pink
    const Color(0xFFF97316), // Orange
    const Color(0xFF84CC16), // Lime
    const Color(0xFF06B6D4), // Cyan
    const Color(0xFFEF4444), // Red
    const Color(0xFF3B82F6), // Blue
  ];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// 검색어 변경 처리 (디바운스 적용)
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = value.trim();
        _isSearching = _searchQuery.isNotEmpty;
      });
    });
  }

  /// 태그 추가
  void _addTag(Tag tag) {
    if (!widget.selectedTags.any((t) => t.id == tag.id)) {
      widget.onTagsChanged([...widget.selectedTags, tag]);
    }
    _controller.clear();
    setState(() {
      _searchQuery = '';
      _isSearching = false;
    });
    _focusNode.unfocus();
  }

  /// 태그 제거
  void _removeTag(Tag tag) {
    widget.onTagsChanged(
      widget.selectedTags.where((t) => t.id != tag.id).toList(),
    );
  }

  /// 새 태그 생성
  Future<void> _createNewTag(String name) async {
    if (name.trim().isEmpty) return;

    // 랜덤 색상 선택
    final colors = widget.availableColors ?? _defaultColors;
    final randomColor = colors[DateTime.now().millisecond % colors.length];
    final colorHex = randomColor.toARGB32().toRadixString(16).padLeft(8, '0');

    try {
      final newTag = await ref.read(tagListProvider.notifier).createTagByNameAndColor(
            name: name.trim(),
            color: colorHex,
          );

      _addTag(newTag);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('태그 생성 실패: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 선택된 태그 칩 표시
        if (widget.selectedTags.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.selectedTags.map((tag) {
              return Chip(
                label: Text(tag.name),
                deleteIcon: const Icon(Icons.close, size: 18),
                onDeleted: () => _removeTag(tag),
                backgroundColor: Color(int.parse(tag.color, radix: 16)),
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],

        // 태그 입력 필드
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: '태그 입력...',
            prefixIcon: const Icon(Icons.label_outline),
            suffixIcon: _controller.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _searchQuery = '';
                        _isSearching = false;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          onChanged: _onSearchChanged,
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              _createNewTag(value.trim());
            }
          },
        ),

        // 자동완성 제안
        if (_isSearching) ...[
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final searchResults = ref.watch(searchTagsProvider(_searchQuery));

              return searchResults.when(
                data: (tags) {
                  // 이미 선택된 태그 제외
                  final availableTags = tags
                      .where((tag) => !widget.selectedTags.any((t) => t.id == tag.id))
                      .toList();

                  if (availableTags.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              '새 태그 "$_searchQuery" 생성하기 (Enter 키)',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Container(
                    constraints: const BoxConstraints(maxHeight: 200),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: availableTags.length + 1,
                      itemBuilder: (context, index) {
                        if (index == availableTags.length) {
                          // "새 태그 만들기" 옵션
                          return ListTile(
                            leading: Icon(
                              Icons.add_circle_outline,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            title: Text('새 태그 "$_searchQuery" 생성'),
                            onTap: () => _createNewTag(_searchQuery),
                          );
                        }

                        final tag = availableTags[index];
                        return ListTile(
                          leading: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: Color(int.parse(tag.color, radix: 16)),
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Text(tag.name),
                          subtitle: tag.useCount > 0
                              ? Text('사용: ${tag.useCount}회')
                              : null,
                          onTap: () => _addTag(tag),
                        );
                      },
                    ),
                  );
                },
                loading: () => const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                ),
                error: (error, _) => const SizedBox.shrink(),
              );
            },
          ),
        ],
      ],
    );
  }
}
