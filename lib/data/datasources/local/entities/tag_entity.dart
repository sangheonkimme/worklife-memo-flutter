import 'package:isar/isar.dart';
import 'note_entity.dart';

part 'tag_entity.g.dart';

/// 태그 Entity (Isar Collection)
@collection
class TagEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String uuid;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  // 태그 색상 (HEX 코드)
  late String color;

  @Index()
  late DateTime createdAt;

  late DateTime updatedAt;

  // 사용 횟수 (인기 태그 표시용)
  int useCount;

  // 역관계: 이 태그를 사용하는 메모들
  @Backlink(to: 'tags')
  final notes = IsarLinks<NoteEntity>();

  TagEntity({
    this.useCount = 0,
  });

  /// 생성자 헬퍼
  TagEntity.create({
    required this.uuid,
    required this.name,
    required this.color,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.useCount = 0,
  })  : createdAt = createdAt ?? DateTime.now(),
        updatedAt = updatedAt ?? DateTime.now();

  /// 복사 메서드
  TagEntity copyWith({
    String? uuid,
    String? name,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? useCount,
  }) {
    return TagEntity.create(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      useCount: useCount ?? this.useCount,
    )..id = id;
  }
}
