import 'package:isar/isar.dart';
import 'note_entity.dart';

part 'folder_entity.g.dart';

/// 폴더 Entity (Isar Collection)
@collection
class FolderEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(type: IndexType.value)
  late String name;

  // 부모 폴더 ID (null이면 루트 폴더)
  String? parentId;

  @Index()
  late DateTime createdAt;

  late DateTime updatedAt;

  // 정렬 순서
  int order;

  // 폴더 색상 (옵션)
  String? color;

  // 아이콘 (옵션)
  String? icon;

  // 역관계: 이 폴더에 속한 메모들
  @Backlink(to: 'folder')
  final notes = IsarLinks<NoteEntity>();

  FolderEntity({
    this.order = 0,
  });

  /// 생성자 헬퍼
  FolderEntity.create({
    required this.uuid,
    required this.name,
    this.parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.order = 0,
    this.color,
    this.icon,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 루트 폴더 여부
  bool get isRoot => parentId == null;

  /// 복사 메서드
  FolderEntity copyWith({
    String? uuid,
    String? name,
    String? parentId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? order,
    String? color,
    String? icon,
  }) {
    return FolderEntity.create(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      order: order ?? this.order,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    )..id = id;
  }
}
