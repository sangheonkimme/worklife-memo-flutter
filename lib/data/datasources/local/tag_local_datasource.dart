import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../domain/entities/tag.dart' as domain;
import 'drift/app_database.dart';

/// 태그 Local Data Source
class TagLocalDataSource {
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  TagLocalDataSource(this._database);

  /// 태그 생성
  Future<domain.Tag> createTag(domain.Tag tag) async {
    final uuid = _uuid.v4();
    final now = DateTime.now();

    final id = await _database.insertTag(
      TagsCompanion.insert(
        uuid: uuid,
        name: tag.name,
        color: tag.color,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final created = await (_database.select(_database.tags)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _mapToTag(created);
  }

  /// 태그 조회 (단일)
  Future<domain.Tag?> getTagById(String id) async {
    final entity = await _database.getTagByUuid(id);
    if (entity == null) return null;
    return _mapToTag(entity);
  }

  /// 이름으로 태그 조회
  Future<domain.Tag?> getTagByName(String name) async {
    final entity = await _database.getTagByName(name);
    if (entity == null) return null;
    return _mapToTag(entity);
  }

  /// 모든 태그 조회
  Future<List<domain.Tag>> getAllTags() async {
    final entities = await (_database.select(_database.tags)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return entities.map(_mapToTag).toList();
  }

  /// 태그 검색 (자동완성용)
  Future<List<domain.Tag>> searchTags(String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    final entities = await (_database.select(_database.tags)
          ..where((t) => t.name.lower().like(lowerQuery))
          ..orderBy([(t) => OrderingTerm.desc(t.useCount)]))
        .get();
    return entities.map(_mapToTag).toList();
  }

  /// 인기 태그 조회 (사용 횟수 기준)
  Future<List<domain.Tag>> getPopularTags({int limit = 10}) async {
    final entities = await (_database.select(_database.tags)
          ..orderBy([(t) => OrderingTerm.desc(t.useCount)])
          ..limit(limit))
        .get();
    return entities.map(_mapToTag).toList();
  }

  /// 최근 사용한 태그 조회
  Future<List<domain.Tag>> getRecentTags({int limit = 10}) async {
    final entities = await (_database.select(_database.tags)
          ..where((t) => t.useCount.isBiggerThanValue(0))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)])
          ..limit(limit))
        .get();
    return entities.map(_mapToTag).toList();
  }

  /// 태그 업데이트
  Future<domain.Tag> updateTag(domain.Tag tag) async {
    final entity = await _database.getTagByUuid(tag.id);
    if (entity == null) {
      throw Exception('Tag not found: ${tag.id}');
    }

    await _database.updateTag(entity.copyWith(
      name: tag.name,
      color: tag.color,
      useCount: tag.useCount,
      updatedAt: DateTime.now(),
    ));

    final updated = await _database.getTagByUuid(tag.id);
    return _mapToTag(updated!);
  }

  /// 태그 삭제
  Future<void> deleteTag(String id) async {
    final entity = await _database.getTagByUuid(id);
    if (entity == null) return;

    await _database.transaction(() async {
      // NoteTags 연결 제거 (cascade delete가 자동으로 처리함)
      await _database.deleteTag(entity.id);
    });
  }

  /// 태그 이름 변경
  Future<void> renameTag(String id, String newName) async {
    final entity = await _database.getTagByUuid(id);
    if (entity == null) return;

    await _database.updateTag(entity.copyWith(
      name: newName,
      updatedAt: DateTime.now(),
    ));
  }

  /// 태그 색상 변경
  Future<void> changeTagColor(String id, String newColor) async {
    final entity = await _database.getTagByUuid(id);
    if (entity == null) return;

    await _database.updateTag(entity.copyWith(
      color: newColor,
      updatedAt: DateTime.now(),
    ));
  }

  /// 태그 병합 (fromTagId의 메모들을 toTagId로 이동 후 fromTagId 삭제)
  Future<void> mergeTags(String fromTagId, String toTagId) async {
    final fromEntity = await _database.getTagByUuid(fromTagId);
    final toEntity = await _database.getTagByUuid(toTagId);

    if (fromEntity == null || toEntity == null) {
      throw Exception('Tag not found');
    }

    await _database.transaction(() async {
      // fromTag의 모든 메모 조회
      final fromNotes = await _database.getNotesForTag(fromEntity.id);

      for (final note in fromNotes) {
        // toTag가 이미 연결되어 있는지 확인
        final toNotes = await _database.getNotesForTag(toEntity.id);
        final hasToTag = toNotes.any((n) => n.id == note.id);

        if (!hasToTag) {
          // toTag를 메모에 연결
          await _database.linkNoteToTag(note.id, toEntity.id);
        }

        // fromTag 연결 제거
        await _database.unlinkNoteFromTag(note.id, fromEntity.id);
      }

      // toTag 사용 횟수 업데이트
      await _database.updateTag(toEntity.copyWith(
        useCount: toEntity.useCount + fromNotes.length,
        updatedAt: DateTime.now(),
      ));

      // fromTag 삭제
      await _database.deleteTag(fromEntity.id);
    });
  }

  /// 사용되지 않는 태그 조회
  Future<List<domain.Tag>> getUnusedTags() async {
    final entities = await (_database.select(_database.tags)
          ..where((t) => t.useCount.equals(0))
          ..orderBy([(t) => OrderingTerm.desc(t.name)]))
        .get();
    return entities.map(_mapToTag).toList();
  }

  /// 사용되지 않는 태그 삭제
  Future<void> deleteUnusedTags() async {
    final entities = await (_database.select(_database.tags)
          ..where((t) => t.useCount.equals(0)))
        .get();

    await _database.transaction(() async {
      for (final entity in entities) {
        await _database.deleteTag(entity.id);
      }
    });
  }

  /// 태그 개수 조회
  Future<int> getTagCount() async {
    final count = await (_database.selectOnly(_database.tags)
          ..addColumns([_database.tags.id.count()]))
        .getSingle();
    return count.read(_database.tags.id.count()) ?? 0;
  }

  /// 태그가 사용된 메모 개수 조회
  Future<int> getNoteCountWithTag(String tagId) async {
    final tagEntity = await _database.getTagByUuid(tagId);
    if (tagEntity == null) return 0;

    final notes = await _database.getNotesForTag(tagEntity.id);
    // 삭제되지 않은 메모만 카운트
    return notes.where((note) => !note.isDeleted).length;
  }

  /// Entity → Tag 변환
  domain.Tag _mapToTag(Tag entity) {
    return domain.Tag(
      id: entity.uuid,
      name: entity.name,
      color: entity.color,
      useCount: entity.useCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
