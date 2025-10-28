import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'folder.dart';
import 'tag.dart';

part 'note.freezed.dart';
part 'note.g.dart';

/// 메모 타입
enum NoteType {
  richText,
  markdown,
  checklist,
}

/// 메모 Domain Entity
@freezed
class Note with _$Note {
  const factory Note({
    required String id,
    required String title,
    required String content,
    required NoteType type,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default(false) bool isPinned,
    @Default(false) bool isArchived,
    @Default(false) bool isDeleted,
    @Default(false) bool isFavorite,
    int? order,
    Folder? folder,
    @Default([]) List<Tag> tags,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}

/// 메모 생성 헬퍼
extension NoteX on Note {
  /// 새 메모 생성
  static Note create({
    required String title,
    required String content,
    required NoteType type,
    Folder? folder,
    List<Tag>? tags,
  }) {
    final now = DateTime.now();
    return Note(
      id: '', // Repository에서 UUID 생성
      title: title,
      content: content,
      type: type,
      createdAt: now,
      updatedAt: now,
      folder: folder,
      tags: tags ?? [],
    );
  }

  /// 메모가 비어있는지 확인
  bool get isEmpty => title.trim().isEmpty && content.trim().isEmpty;

  /// 메모가 비어있지 않은지 확인
  bool get isNotEmpty => !isEmpty;

  /// 활성 메모 여부 (삭제되거나 보관되지 않음)
  bool get isActive => !isDeleted && !isArchived;

  /// 메모 길이
  int get length => content.length;

  /// 메모 미리보기 텍스트 (최대 200자)
  String get preview {
    if (content.isEmpty) return '';

    String plainText;
    switch (type) {
      case NoteType.richText:
        // Delta JSON → Document → Plain Text
        try {
          final jsonData = jsonDecode(content);
          final document = quill.Document.fromJson(jsonData);
          plainText = document.toPlainText().trim();
        } catch (e) {
          plainText = content;
        }
        break;
      case NoteType.checklist:
        // JSON 파싱하여 텍스트 추출
        try {
          final List<dynamic> items = jsonDecode(content) as List;
          plainText = items
              .map((item) => item['text'] as String? ?? '')
              .where((text) => text.isNotEmpty)
              .join(', ');
        } catch (e) {
          plainText = content;
        }
        break;
      case NoteType.markdown:
        plainText = content;
        break;
    }

    return plainText.length > 200
        ? '${plainText.substring(0, 200)}...'
        : plainText;
  }
}
