import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/entities/folder.dart';
import '../../../domain/entities/tag.dart';
import '../../providers/note_provider.dart';
import '../../widgets/dialogs/folder_selection_dialog.dart';

/// 체크리스트 아이템 모델
class ChecklistItem {
  final String id;
  String text;
  bool isCompleted;

  ChecklistItem({
    required this.id,
    required this.text,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'isCompleted': isCompleted,
      };

  factory ChecklistItem.fromJson(Map<String, dynamic> json) => ChecklistItem(
        id: json['id'] as String,
        text: json['text'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );
}

/// Note Editor Screen (간소화 버전)
/// 메모 작성/편집 화면
class NoteEditorScreenSimple extends ConsumerStatefulWidget {
  final String? noteId; // null이면 새 메모

  const NoteEditorScreenSimple({
    super.key,
    this.noteId,
  });

  @override
  ConsumerState<NoteEditorScreenSimple> createState() =>
      _NoteEditorScreenSimpleState();
}

class _NoteEditorScreenSimpleState
    extends ConsumerState<NoteEditorScreenSimple> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _tagInputController = TextEditingController();
  final _checklistInputController = TextEditingController();

  bool _isLoading = false;
  bool _hasChanges = false;
  List<ChecklistItem> _checklistItems = []; // 체크리스트 항목
  List<Tag> _selectedTags = []; // 선택된 태그 목록
  Folder? _selectedFolder; // 선택된 폴더

  // 자동 저장
  Timer? _autoSaveTimer;

  @override
  void initState() {
    super.initState();
    _loadNoteIfExists();

    // 변경 감지
    _titleController.addListener(_onContentChanged);
    _contentController.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    _tagInputController.dispose();
    _checklistInputController.dispose();
    super.dispose();
  }

  /// 기존 메모 로드
  Future<void> _loadNoteIfExists() async {
    if (widget.noteId == null) return;

    setState(() => _isLoading = true);

    try {
      final note = await ref.read(noteProvider(widget.noteId!).future);
      if (note != null && mounted) {
        _titleController.text = note.title;

        // 체크리스트 로드
        if (note.type == NoteType.checklist && note.content.isNotEmpty) {
          try {
            // JSON 파싱 시도
            final decoded = jsonDecode(note.content);

            // 새로운 형식: {"text": "...", "checklist": [...]}
            if (decoded is Map<String, dynamic>) {
              _contentController.text = decoded['text'] ?? '';
              final checklistData = decoded['checklist'] as List<dynamic>?;
              if (checklistData != null) {
                _checklistItems = checklistData
                    .map((item) =>
                        ChecklistItem.fromJson(item as Map<String, dynamic>))
                    .toList();
              }
            }
            // 기존 형식: [{"id": "...", "text": "...", "isCompleted": false}]
            else if (decoded is List<dynamic>) {
              _checklistItems = decoded
                  .map((item) =>
                      ChecklistItem.fromJson(item as Map<String, dynamic>))
                  .toList();
              _contentController.text = '';
            }
          } catch (e) {
            _checklistItems = [];
            _contentController.text = note.content;
          }
        } else {
          // 일반 노트인 경우 content 표시
          _contentController.text = note.content;
        }

        // 태그 로드
        _selectedTags = note.tags;

        // 폴더 로드
        _selectedFolder = note.folder;

        setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('메모를 불러오는데 실패했습니다: $e')),
        );
      }
    }
  }

  /// 변경 감지 및 자동 저장
  void _onContentChanged() {
    if (!_hasChanges) {
      setState(() => _hasChanges = true);
    }

    // 기존 타이머 취소
    _autoSaveTimer?.cancel();

    // 새 노트가 아니고, 제목이 있는 경우에만 자동 저장
    if (widget.noteId != null && _titleController.text.trim().isNotEmpty) {
      _autoSaveTimer = Timer(const Duration(seconds: 3), () {
        _autoSave();
      });
    }
  }

  /// 자동 저장
  Future<void> _autoSave() async {
    if (widget.noteId == null) return;

    try {
      final title = _titleController.text.trim();
      if (title.isEmpty) return;

      final contentText = _contentController.text.trim();

      // 체크리스트가 있으면 체크리스트 타입으로 저장
      final hasChecklist = _checklistItems.isNotEmpty;
      final noteType = hasChecklist ? NoteType.checklist : NoteType.richText;

      // content 생성: 체크리스트와 텍스트를 모두 포함
      String content;
      if (hasChecklist) {
        // 체크리스트와 텍스트를 함께 저장
        content = jsonEncode({
          'text': contentText,
          'checklist': _checklistItems.map((item) => item.toJson()).toList(),
        });
      } else {
        // 일반 텍스트만 저장
        content = contentText;
      }

      // 기존 메모 업데이트
      final existingNote = await ref.read(noteProvider(widget.noteId!).future);
      if (existingNote != null && mounted) {
        final updatedNote = existingNote.copyWith(
          title: title,
          content: content,
          type: noteType,
          folder: _selectedFolder,
          tags: _selectedTags,
          updatedAt: DateTime.now(),
        );
        await ref.read(noteListProvider.notifier).updateNote(updatedNote);

        if (mounted) {
          setState(() {
            _hasChanges = false;
          });
        }
      }
    } catch (e) {
      // 자동 저장 실패는 조용히 무시
      debugPrint('Auto-save failed: $e');
    }
  }

  /// 메모 저장
  Future<void> _saveNote() async {
    final title = _titleController.text.trim();
    final contentText = _contentController.text.trim();

    // 체크리스트가 있으면 체크리스트 타입으로 저장
    final hasChecklist = _checklistItems.isNotEmpty;
    final noteType = hasChecklist ? NoteType.checklist : NoteType.richText;

    // content 생성: 체크리스트와 텍스트를 모두 포함
    String content;
    if (hasChecklist) {
      // 체크리스트와 텍스트를 함께 저장
      content = jsonEncode({
        'text': contentText,
        'checklist': _checklistItems.map((item) => item.toJson()).toList(),
      });
    } else {
      // 일반 텍스트만 저장
      content = contentText;
    }

    if (title.isEmpty && contentText.isEmpty && !hasChecklist) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('제목 또는 내용을 입력하세요')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.noteId == null) {
        // 새 메모 생성
        final note = NoteX.create(
          title: title,
          content: content,
          type: noteType,
          folder: _selectedFolder,
          tags: _selectedTags,
        );
        await ref.read(noteListProvider.notifier).createNote(note);
      } else {
        // 기존 메모 업데이트
        final existingNote = await ref.read(noteProvider(widget.noteId!).future);
        if (existingNote != null) {
          final updatedNote = existingNote.copyWith(
            title: title,
            content: content,
            type: noteType,
            folder: _selectedFolder,
            tags: _selectedTags,
            updatedAt: DateTime.now(),
          );
          await ref.read(noteListProvider.notifier).updateNote(updatedNote);
        }
      }

      if (mounted) {
        setState(() {
          _hasChanges = false;
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('저장되었습니다')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('저장에 실패했습니다: $e')),
        );
      }
    }
  }

  /// 나가기 확인
  Future<bool> _onWillPop() async {
    if (!_hasChanges) return true;

    final shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('저장하지 않은 변경사항'),
        content: const Text('저장하지 않은 변경사항이 있습니다. 나가시겠습니까?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('나가기'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop && _hasChanges) {
          final shouldPop = await _onWillPop();
          if (shouldPop && context.mounted) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.noteId == null ? '새 메모' : '메모 수정'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              if (_hasChanges) {
                final shouldPop = await _onWillPop();
                if (shouldPop && context.mounted) {
                  context.pop();
                }
              } else {
                context.pop();
              }
            },
          ),
          actions: [
            // 저장 버튼 - 보라색 원형 배경
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF7C4DFF), // 보라색
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.white,
                  onPressed: _isLoading ? null : _saveNote,
                  tooltip: '저장',
                ),
              ),
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _buildEditor(),
      ),
    );
  }

  /// 에디터 위젯
  Widget _buildEditor() {
    return Column(
      children: [
        // 스크롤 가능한 영역
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 제목 입력
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: '제목',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // 내용 입력
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(
                    hintText: '내용을 입력하세요...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                  maxLines: null,
                  minLines: 5,
                ),
                const SizedBox(height: 32),
                // 폴더 섹션
                _buildFolderSection(),
                const SizedBox(height: 24),
                // 태그 섹션
                _buildTagSection(),
                const SizedBox(height: 24),
                // 체크리스트 헤더와 항목들만
                _buildChecklistItemsList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 폴더 섹션
  Widget _buildFolderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '폴더',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: () async {
            final result = await showDialog<Folder?>(
              context: context,
              builder: (context) => FolderSelectionDialog(
                selectedFolderId: _selectedFolder?.id,
              ),
            );
            // result can be null (if dialog was cancelled) or a Folder object
            // If user selected "모든 메모", result will be null
            setState(() {
              _selectedFolder = result;
              _onContentChanged();
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.folder_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  _selectedFolder?.name ?? '모든 메모',
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 태그 섹션
  Widget _buildTagSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '태그',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // 선택된 태그들 표시
        if (_selectedTags.isNotEmpty) ...[
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedTags.map((tag) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '#${tag.name}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                    const SizedBox(width: 4),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTags.remove(tag);
                          _onContentChanged();
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
        ],
        // 태그 입력 필드
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagInputController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: '태그 추가',
                  hintStyle: const TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (value) {
                  _addTag(value);
                  _tagInputController.clear();
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: () {
                  _addTag(_tagInputController.text);
                  _tagInputController.clear();
                },
                icon: const Icon(Icons.add, size: 20),
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 태그 추가
  void _addTag(String tagName) {
    final trimmed = tagName.trim();
    if (trimmed.isEmpty) return;

    // 이미 추가된 태그인지 확인
    final exists = _selectedTags.any((tag) => tag.name.toLowerCase() == trimmed.toLowerCase());
    if (exists) return;

    setState(() {
      _selectedTags.add(Tag(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: trimmed,
        color: '#9C27B0', // 기본 보라색
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
      _onContentChanged();
    });
  }

  /// 체크리스트 항목들 목록 (스크롤 영역)
  Widget _buildChecklistItemsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '체크리스트',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        // 체크리스트 항목들
        if (_checklistItems.isNotEmpty) ...[
          ..._checklistItems.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: item.isCompleted,
                      onChanged: (value) {
                        setState(() {
                          item.isCompleted = value ?? false;
                          _onContentChanged();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item.text.isEmpty ? '(항목 없음)' : item.text,
                      style: TextStyle(
                        fontSize: 15,
                        decoration: item.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: item.isCompleted
                            ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5)
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _checklistItems.removeAt(index);
                        _onContentChanged();
                      });
                    },
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            );
          }),
          const SizedBox(height: 8),
        ],
        // 체크리스트 입력 필드
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _checklistInputController,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: '항목 추가',
                  hintStyle: const TextStyle(fontSize: 15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (value) => _addChecklistItemFromInput(),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                onPressed: _addChecklistItemFromInput,
                icon: const Icon(Icons.add, size: 20),
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 체크리스트 항목 추가 (입력창에서)
  void _addChecklistItemFromInput() {
    final text = _checklistInputController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _checklistItems.add(ChecklistItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: text,
        ));
        _checklistInputController.clear();
        _onContentChanged();
      });
    }
  }
}
