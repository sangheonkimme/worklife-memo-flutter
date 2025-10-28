import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:markdown_widget/markdown_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/entities/note.dart';
import '../../providers/note_provider.dart';

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

/// Note Editor Screen
/// 메모 작성/편집 화면
class NoteEditorScreen extends ConsumerStatefulWidget {
  final String? noteId; // null이면 새 메모

  const NoteEditorScreen({
    super.key,
    this.noteId,
  });

  @override
  ConsumerState<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends ConsumerState<NoteEditorScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  late quill.QuillController _quillController;

  NoteType _selectedType = NoteType.richText;
  bool _isLoading = false;
  bool _hasChanges = false;
  bool _showMarkdownPreview = true; // 마크다운 미리보기 표시 여부
  List<ChecklistItem> _checklistItems = []; // 체크리스트 항목

  // 자동 저장
  Timer? _autoSaveTimer;
  bool _isSaving = false;
  DateTime? _lastSaved;

  @override
  void initState() {
    super.initState();

    // QuillController 초기화
    _quillController = quill.QuillController.basic();

    _loadNoteIfExists();

    // 변경 감지
    _titleController.addListener(_onContentChanged);
    _contentController.addListener(_onContentChanged);
    _quillController.addListener(_onContentChanged);
  }

  @override
  void dispose() {
    _autoSaveTimer?.cancel();
    _titleController.dispose();
    _contentController.dispose();
    _quillController.dispose();
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
        _selectedType = note.type;

        // 타입별로 다르게 로드
        if (note.type == NoteType.richText && note.content.isNotEmpty) {
          try {
            // JSON Delta 형식에서 Document 복원
            final jsonData = jsonDecode(note.content);
            _quillController.document = quill.Document.fromJson(jsonData);
          } catch (e) {
            // JSON 파싱 실패 시 일반 텍스트로 처리
            _quillController.document = quill.Document()..insert(0, note.content);
          }
        } else if (note.type == NoteType.checklist && note.content.isNotEmpty) {
          try {
            // JSON에서 체크리스트 복원
            final List<dynamic> jsonList = jsonDecode(note.content);
            _checklistItems = jsonList
                .map((item) => ChecklistItem.fromJson(item as Map<String, dynamic>))
                .toList();
          } catch (e) {
            // JSON 파싱 실패 시 빈 리스트
            _checklistItems = [];
          }
        } else {
          // Markdown은 일반 텍스트로 로드
          _contentController.text = note.content;
        }

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
    if (_isSaving || widget.noteId == null) return;

    setState(() => _isSaving = true);

    try {
      final title = _titleController.text.trim();
      if (title.isEmpty) return;

      // 타입별로 content 가져오기
      String content;
      if (_selectedType == NoteType.richText) {
        final delta = _quillController.document.toDelta();
        content = jsonEncode(delta.toJson());
      } else if (_selectedType == NoteType.checklist) {
        content = jsonEncode(_checklistItems.map((item) => item.toJson()).toList());
      } else {
        content = _contentController.text.trim();
      }

      // 기존 메모 업데이트
      final existingNote = await ref.read(noteProvider(widget.noteId!).future);
      if (existingNote != null && mounted) {
        final updatedNote = existingNote.copyWith(
          title: title,
          content: content,
          type: _selectedType,
          updatedAt: DateTime.now(),
        );
        await ref.read(noteListProvider.notifier).updateNote(updatedNote);

        if (mounted) {
          setState(() {
            _hasChanges = false;
            _lastSaved = DateTime.now();
          });
        }
      }
    } catch (e) {
      // 자동 저장 실패는 조용히 무시
      debugPrint('Auto-save failed: $e');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  /// 메모 저장
  Future<void> _saveNote() async {
    final title = _titleController.text.trim();

    // 타입별로 content 가져오기
    String content;
    if (_selectedType == NoteType.richText) {
      // QuillController에서 Delta JSON으로 저장
      final delta = _quillController.document.toDelta();
      content = jsonEncode(delta.toJson());
    } else if (_selectedType == NoteType.checklist) {
      // Checklist를 JSON으로 저장
      content = jsonEncode(_checklistItems.map((item) => item.toJson()).toList());
    } else {
      // Markdown은 일반 텍스트
      content = _contentController.text.trim();
    }

    if (title.isEmpty && content.isEmpty) {
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
          type: _selectedType,
        );
        await ref.read(noteListProvider.notifier).createNote(note);
      } else {
        // 기존 메모 업데이트
        final existingNote = await ref.read(noteProvider(widget.noteId!).future);
        if (existingNote != null) {
          final updatedNote = existingNote.copyWith(
            title: title,
            content: content,
            type: _selectedType,
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
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.noteId == null ? '새 메모' : '메모 편집'),
              if (_isSaving)
                const Text(
                  '저장 중...',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                )
              else if (_lastSaved != null)
                Text(
                  '저장됨',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
          actions: [
            // 타입 선택
            PopupMenuButton<NoteType>(
              icon: Icon(_getTypeIcon(_selectedType)),
              tooltip: '메모 타입',
              onSelected: (type) {
                setState(() => _selectedType = type);
                _onContentChanged();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: NoteType.richText,
                  child: Row(
                    children: [
                      Icon(_getTypeIcon(NoteType.richText)),
                      const SizedBox(width: 8),
                      const Text('리치 텍스트'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: NoteType.markdown,
                  child: Row(
                    children: [
                      Icon(_getTypeIcon(NoteType.markdown)),
                      const SizedBox(width: 8),
                      const Text('마크다운'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: NoteType.checklist,
                  child: Row(
                    children: [
                      Icon(_getTypeIcon(NoteType.checklist)),
                      const SizedBox(width: 8),
                      const Text('체크리스트'),
                    ],
                  ),
                ),
              ],
            ),
            // 저장 버튼
            if (_hasChanges)
              TextButton(
                onPressed: _isLoading ? null : _saveNote,
                child: const Text('저장'),
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
        // 제목 입력
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: '제목',
              border: InputBorder.none,
            ),
            style: Theme.of(context).textTheme.headlineSmall,
            maxLines: 2,
          ),
        ),
        const Divider(height: 1),
        // 내용 에디터 (타입별)
        Expanded(
          child: _buildContentEditor(),
        ),
      ],
    );
  }

  /// 타입별 내용 에디터
  Widget _buildContentEditor() {
    switch (_selectedType) {
      case NoteType.richText:
        return _buildRichTextEditor();
      case NoteType.markdown:
        return _buildMarkdownEditor();
      case NoteType.checklist:
        return _buildChecklistEditor();
    }
  }

  /// 리치 텍스트 에디터 (Flutter Quill)
  Widget _buildRichTextEditor() {
    return Column(
      children: [
        // Quill Toolbar
        quill.QuillSimpleToolbar(
          controller: _quillController,
          config: const quill.QuillSimpleToolbarConfig(
            showAlignmentButtons: true,
            showBackgroundColorButton: false,
            showClearFormat: true,
            showCodeBlock: true,
            showColorButton: true,
            showDividers: true,
            showFontFamily: false,
            showFontSize: false,
            showHeaderStyle: true,
            showIndent: true,
            showInlineCode: true,
            showLink: true,
            showListBullets: true,
            showListCheck: true,
            showListNumbers: true,
            showQuote: true,
            showRedo: true,
            showUndo: true,
            showSearchButton: false,
          ),
        ),
        const Divider(height: 1),
        // Quill Editor
        Expanded(
          child: quill.QuillEditor.basic(
            controller: _quillController,
            config: const quill.QuillEditorConfig(
              padding: EdgeInsets.all(16.0),
              placeholder: '내용을 입력하세요...',
            ),
          ),
        ),
      ],
    );
  }

  /// 마크다운 에디터 (Split View)
  Widget _buildMarkdownEditor() {
    return Column(
      children: [
        // 마크다운 툴바
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Row(
            children: [
              _buildMarkdownToolbarButton('# ', 'H1'),
              _buildMarkdownToolbarButton('## ', 'H2'),
              _buildMarkdownToolbarButton('### ', 'H3'),
              const VerticalDivider(width: 1),
              _buildMarkdownToolbarButton('**', 'B'),
              _buildMarkdownToolbarButton('*', 'I'),
              _buildMarkdownToolbarButton('~~', 'S'),
              const VerticalDivider(width: 1),
              _buildMarkdownToolbarButton('- ', 'List'),
              _buildMarkdownToolbarButton('1. ', 'OL'),
              _buildMarkdownToolbarButton('- [ ] ', 'TODO'),
              const VerticalDivider(width: 1),
              _buildMarkdownToolbarButton('`', 'Code'),
              _buildMarkdownToolbarButton('```\n', 'Block'),
              _buildMarkdownToolbarButton('[]()', 'Link'),
              const Spacer(),
              IconButton(
                icon: Icon(
                  _showMarkdownPreview ? Icons.visibility : Icons.visibility_off,
                  size: 20,
                ),
                tooltip: _showMarkdownPreview ? '미리보기 숨기기' : '미리보기 표시',
                onPressed: () {
                  setState(() => _showMarkdownPreview = !_showMarkdownPreview);
                },
              ),
            ],
          ),
        ),
        // 에디터 + 미리보기
        Expanded(
          child: _showMarkdownPreview
              ? Row(
                  children: [
                    // 마크다운 입력
                    Expanded(
                      child: TextField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          hintText: '마크다운으로 작성하세요...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.0),
                        ),
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style: const TextStyle(fontFamily: 'monospace'),
                      ),
                    ),
                    // 세로 구분선
                    VerticalDivider(
                      width: 1,
                      color: Theme.of(context).dividerColor,
                    ),
                    // 미리보기
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: _contentController.text.isEmpty
                            ? Center(
                                child: Text(
                                  '미리보기',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                              )
                            : SingleChildScrollView(
                                child: MarkdownWidget(
                                  data: _contentController.text,
                                  shrinkWrap: true,
                                  selectable: true,
                                ),
                              ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: '마크다운으로 작성하세요...',
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    expands: true,
                    textAlignVertical: TextAlignVertical.top,
                    style: const TextStyle(fontFamily: 'monospace'),
                  ),
                ),
        ),
      ],
    );
  }

  /// 마크다운 툴바 버튼
  Widget _buildMarkdownToolbarButton(String syntax, String label) {
    return TextButton(
      onPressed: () {
        final text = _contentController.text;
        final selection = _contentController.selection;
        final start = selection.start;
        final end = selection.end;

        String newText;
        int newCursorPos;

        if (syntax.contains('()')) {
          // 링크 문법
          final selectedText = text.substring(start, end);
          newText = text.substring(0, start) +
              '[${selectedText.isNotEmpty ? selectedText : 'text'}](url)' +
              text.substring(end);
          newCursorPos = start + (selectedText.isNotEmpty ? selectedText.length + 3 : 6);
        } else if (syntax.length == 1 || syntax == '**' || syntax == '~~') {
          // 감싸는 문법 (Bold, Italic, Strikethrough)
          final selectedText = text.substring(start, end);
          newText = text.substring(0, start) +
              syntax +
              selectedText +
              syntax +
              text.substring(end);
          newCursorPos = start + syntax.length + selectedText.length + syntax.length;
        } else {
          // 라인 시작 문법 (Header, List, etc.)
          newText = text.substring(0, start) + syntax + text.substring(start);
          newCursorPos = start + syntax.length;
        }

        _contentController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newCursorPos),
        );
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        minimumSize: const Size(40, 32),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// 체크리스트 에디터
  Widget _buildChecklistEditor() {
    final completedCount = _checklistItems.where((item) => item.isCompleted).length;
    final totalCount = _checklistItems.length;
    final progress = totalCount > 0 ? completedCount / totalCount : 0.0;

    return Column(
      children: [
        // 진행률 표시
        if (totalCount > 0)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      '$completedCount / $totalCount',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}% 완료',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        // 체크리스트 항목
        Expanded(
          child: _checklistItems.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.checklist,
                        size: 64,
                        color: Theme.of(context).hintColor,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '체크리스트가 비어있습니다',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton.icon(
                        onPressed: _addChecklistItem,
                        icon: const Icon(Icons.add),
                        label: const Text('항목 추가'),
                      ),
                    ],
                  ),
                )
              : ReorderableListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _checklistItems.length,
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final item = _checklistItems.removeAt(oldIndex);
                      _checklistItems.insert(newIndex, item);
                      _onContentChanged();
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _checklistItems[index];
                    return Card(
                      key: ValueKey(item.id),
                      margin: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        leading: Checkbox(
                          value: item.isCompleted,
                          onChanged: (value) {
                            setState(() {
                              item.isCompleted = value ?? false;
                              _onContentChanged();
                            });
                          },
                        ),
                        title: TextField(
                          controller: TextEditingController(text: item.text),
                          decoration: InputDecoration(
                            hintText: '항목 입력...',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.delete_outline, size: 20),
                              onPressed: () {
                                setState(() {
                                  _checklistItems.removeAt(index);
                                  _onContentChanged();
                                });
                              },
                            ),
                          ),
                          style: TextStyle(
                            decoration: item.isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                          onChanged: (value) {
                            item.text = value;
                            _onContentChanged();
                          },
                        ),
                        trailing: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_handle),
                        ),
                      ),
                    );
                  },
                ),
        ),
        // 새 항목 추가 버튼
        if (_checklistItems.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _addChecklistItem,
                icon: const Icon(Icons.add),
                label: const Text('새 항목 추가'),
              ),
            ),
          ),
      ],
    );
  }

  /// 체크리스트 항목 추가
  void _addChecklistItem() {
    setState(() {
      _checklistItems.add(ChecklistItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: '',
      ));
      _onContentChanged();
    });
  }

  /// 타입별 아이콘
  IconData _getTypeIcon(NoteType type) {
    switch (type) {
      case NoteType.richText:
        return Icons.text_fields;
      case NoteType.markdown:
        return Icons.code;
      case NoteType.checklist:
        return Icons.checklist;
    }
  }
}
