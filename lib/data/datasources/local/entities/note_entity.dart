import 'package:isar/isar.dart';
import 'folder_entity.dart';
import 'tag_entity.dart';

part 'note_entity.g.dart';

/// 메모 타입
enum NoteType {
  richText,  // 리치 텍스트
  markdown,  // 마크다운
  checklist, // 체크리스트
}

/// 메모 Entity (Isar Collection)
@collection
class NoteEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(type: IndexType.value)
  late String title;

  late String content;

  @Enumerated(EnumType.name)
  late NoteType type;

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  late bool isPinned;
  late bool isArchived;
  late bool isDeleted;
  late bool isFavorite;

  // 정렬 순서 (고정된 메모의 경우 사용)
  int? order;

  // 관계: 폴더 (N:1)
  final folder = IsarLink<FolderEntity>();

  // 관계: 태그 (N:N)
  final tags = IsarLinks<TagEntity>();

  NoteEntity();

  /// 생성자 헬퍼
  NoteEntity.create({
    required this.uuid,
    required this.title,
    required this.content,
    required this.type,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.isPinned = false,
    this.isArchived = false,
    this.isDeleted = false,
    this.isFavorite = false,
    this.order,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 복사 메서드
  NoteEntity copyWith({
    String? uuid,
    String? title,
    String? content,
    NoteType? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isPinned,
    bool? isArchived,
    bool? isDeleted,
    bool? isFavorite,
    int? order,
  }) {
    return NoteEntity.create(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      isFavorite: isFavorite ?? this.isFavorite,
      order: order ?? this.order,
    )..id = id;
  }
}
