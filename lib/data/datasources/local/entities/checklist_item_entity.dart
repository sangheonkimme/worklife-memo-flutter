import 'package:isar/isar.dart';

part 'checklist_item_entity.g.dart';

/// 체크리스트 항목 Entity (Isar Collection)
@collection
class ChecklistItemEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  // 소속 메모 ID
  @Index()
  late String noteId;

  // 항목 텍스트
  late String text;

  // 완료 여부
  late bool isCompleted;

  // 정렬 순서
  @Index()
  late int order;

  @Index()
  late DateTime createdAt;

  late DateTime updatedAt;

  ChecklistItemEntity();

  /// 생성자 헬퍼
  ChecklistItemEntity.create({
    required this.uuid,
    required this.noteId,
    required this.text,
    this.isCompleted = false,
    required this.order,
    DateTime? createdAt,
    DateTime? updatedAt,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 복사 메서드
  ChecklistItemEntity copyWith({
    String? uuid,
    String? noteId,
    String? text,
    bool? isCompleted,
    int? order,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChecklistItemEntity.create(
      uuid: uuid ?? this.uuid,
      noteId: noteId ?? this.noteId,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    )..id = id;
  }
}
