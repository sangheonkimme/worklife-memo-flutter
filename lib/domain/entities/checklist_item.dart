import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_item.freezed.dart';
part 'checklist_item.g.dart';

/// 체크리스트 항목 Domain Entity
@freezed
class ChecklistItem with _$ChecklistItem {
  const factory ChecklistItem({
    required String id,
    required String noteId,
    required String text,
    @Default(false) bool isCompleted,
    required int order,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChecklistItem;

  factory ChecklistItem.fromJson(Map<String, dynamic> json) =>
      _$ChecklistItemFromJson(json);
}

/// 체크리스트 항목 생성 헬퍼
extension ChecklistItemX on ChecklistItem {
  /// 새 체크리스트 항목 생성
  static ChecklistItem create({
    required String noteId,
    required String text,
    required int order,
  }) {
    final now = DateTime.now();
    return ChecklistItem(
      id: '', // Repository에서 UUID 생성
      noteId: noteId,
      text: text,
      order: order,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// 완료 상태 토글
  ChecklistItem toggle() => copyWith(
        isCompleted: !isCompleted,
        updatedAt: DateTime.now(),
      );

  /// 완료 상태 설정
  ChecklistItem setCompleted(bool completed) => copyWith(
        isCompleted: completed,
        updatedAt: DateTime.now(),
      );
}
