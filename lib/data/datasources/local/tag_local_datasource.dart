import 'package:uuid/uuid.dart';
import '../../../domain/entities/tag.dart';
import 'isar_database.dart';
import 'entities/tag_entity.dart';

/// 태그 Local Data Source
class TagLocalDataSource {
  final Uuid _uuid = const Uuid();

  /// 태그 생성
  Future<Tag> createTag(Tag tag) async {
    final isar = await IsarDatabase.getInstance();
    final uuid = _uuid.v4();

    final entity = TagEntity.create(
      uuid: uuid,
      name: tag.name,
      color: tag.color,
    );

    await isar.writeTxn(() async {
      await isar.tagEntitys.put(entity);
    });

    return _mapToTag(entity);
  }

  /// 태그 조회 (단일)
  Future<Tag?> getTagById(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return null;

    await entity.notes.load();
    return _mapToTag(entity);
  }

  /// 이름으로 태그 조회
  Future<Tag?> getTagByName(String name) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .nameEqualTo(name)
        .findFirst();

    if (entity == null) return null;

    await entity.notes.load();
    return _mapToTag(entity);
  }

  /// 모든 태그 조회
  Future<List<Tag>> getAllTags() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .where()
        .sortByName()
        .findAll();

    return entities.map(_mapToTag).toList();
  }

  /// 태그 검색 (자동완성용)
  Future<List<Tag>> searchTags(String query) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .filter()
        .nameContains(query, caseSensitive: false)
        .sortByUseCountDesc()
        .findAll();

    return entities.map(_mapToTag).toList();
  }

  /// 인기 태그 조회 (사용 횟수 기준)
  Future<List<Tag>> getPopularTags({int limit = 10}) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .where()
        .sortByUseCountDesc()
        .limit(limit)
        .findAll();

    return entities.map(_mapToTag).toList();
  }

  /// 최근 사용한 태그 조회
  Future<List<Tag>> getRecentTags({int limit = 10}) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .filter()
        .useCountGreaterThan(0)
        .sortByUpdatedAtDesc()
        .limit(limit)
        .findAll();

    return entities.map(_mapToTag).toList();
  }

  /// 태그 업데이트
  Future<Tag> updateTag(Tag tag) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(tag.id)
        .findFirst();

    if (entity == null) {
      throw Exception('Tag not found: ${tag.id}');
    }

    entity.name = tag.name;
    entity.color = tag.color;
    entity.useCount = tag.useCount;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.tagEntitys.put(entity);
    });

    return _mapToTag(entity);
  }

  /// 태그 삭제
  Future<void> deleteTag(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    await isar.writeTxn(() async {
      // 연결된 메모들에서 태그 제거
      await entity.notes.load();
      for (final note in entity.notes) {
        await note.tags.load();
        note.tags.remove(entity);
        await note.tags.save();
      }

      await isar.tagEntitys.delete(entity.id);
    });
  }

  /// 태그 이름 변경
  Future<void> renameTag(String id, String newName) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.name = newName;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.tagEntitys.put(entity);
    });
  }

  /// 태그 색상 변경
  Future<void> changeTagColor(String id, String newColor) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.color = newColor;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.tagEntitys.put(entity);
    });
  }

  /// 태그 병합 (fromTagId의 메모들을 toTagId로 이동 후 fromTagId 삭제)
  Future<void> mergeTags(String fromTagId, String toTagId) async {
    final isar = await IsarDatabase.getInstance();

    final fromEntity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(fromTagId)
        .findFirst();

    final toEntity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(toTagId)
        .findFirst();

    if (fromEntity == null || toEntity == null) {
      throw Exception('Tag not found');
    }

    await isar.writeTxn(() async {
      // fromTag의 모든 메모를 toTag로 연결
      await fromEntity.notes.load();
      await toEntity.notes.load();

      for (final note in fromEntity.notes) {
        await note.tags.load();

        // 이미 toTag가 있는지 확인
        final hasToTag = note.tags.any((t) => t.id == toEntity.id);

        if (!hasToTag) {
          note.tags.add(toEntity);
          toEntity.useCount++;
        }

        // fromTag 제거
        note.tags.remove(fromEntity);
        await note.tags.save();
      }

      toEntity.updatedAt = DateTime.now();
      await isar.tagEntitys.put(toEntity);

      // fromTag 삭제
      await isar.tagEntitys.delete(fromEntity.id);
    });
  }

  /// 사용되지 않는 태그 조회
  Future<List<Tag>> getUnusedTags() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .filter()
        .useCountEqualTo(0)
        .sortByNameDesc()
        .findAll();

    return entities.map(_mapToTag).toList();
  }

  /// 사용되지 않는 태그 삭제
  Future<void> deleteUnusedTags() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.tagEntitys
        .filter()
        .useCountEqualTo(0)
        .findAll();

    await isar.writeTxn(() async {
      for (final entity in entities) {
        await isar.tagEntitys.delete(entity.id);
      }
    });
  }

  /// 태그 개수 조회
  Future<int> getTagCount() async {
    final isar = await IsarDatabase.getInstance();
    return await isar.tagEntitys.count();
  }

  /// 태그가 사용된 메모 개수 조회
  Future<int> getNoteCountWithTag(String tagId) async {
    final isar = await IsarDatabase.getInstance();
    final tagEntity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(tagId)
        .findFirst();

    if (tagEntity == null) return 0;

    await tagEntity.notes.load();

    // 삭제되지 않은 메모만 카운트
    return tagEntity.notes.where((note) => !note.isDeleted).length;
  }

  /// Entity → Tag 변환
  Tag _mapToTag(TagEntity entity) {
    return Tag(
      id: entity.uuid,
      name: entity.name,
      color: entity.color,
      useCount: entity.useCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
