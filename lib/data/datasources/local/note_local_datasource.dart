import 'package:uuid/uuid.dart';
import '../../../domain/entities/note.dart' as domain;
import '../../../domain/entities/folder.dart';
import '../../../domain/entities/tag.dart';
import 'isar_database.dart';
import 'entities/note_entity.dart' as entity;
import 'entities/folder_entity.dart';
import 'entities/tag_entity.dart';

/// 메모 Local Data Source
class NoteLocalDataSource {
  final Uuid _uuid = const Uuid();

  /// 메모 생성
  Future<domain.Note> createNote(domain.Note note) async {
    final isar = await IsarDatabase.getInstance();
    final uuid = _uuid.v4();

    final noteEntity = entity.NoteEntity.create(
      uuid: uuid,
      title: note.title,
      content: note.content,
      type: _mapNoteTypeToEntity(note.type),
      isPinned: note.isPinned,
      isArchived: note.isArchived,
      isDeleted: note.isDeleted,
      isFavorite: note.isFavorite,
      order: note.order,
    );

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(entity);

      // 폴더 연결
      if (note.folder != null) {
        final folderEntity = await isar.folderEntitys
            .filter()
            .uuidEqualTo(note.folder!.id)
            .findFirst();
        if (folderEntity != null) {
          entity.folder.value = folderEntity;
          await entity.folder.save();
        }
      }

      // 태그 연결
      if (note.tags.isNotEmpty) {
        final tagEntities = await isar.tagEntitys
            .filter()
            .anyOf(note.tags, (q, tag) => q.uuidEqualTo(tag.id))
            .findAll();
        entity.tags.addAll(tagEntities);
        await entity.tags.save();

        // 태그 사용 횟수 증가
        for (final tagEntity in tagEntities) {
          tagEntity.useCount++;
          tagEntity.updatedAt = DateTime.now();
          await isar.tagEntitys.put(tagEntity);
        }
      }
    });

    return _mapToNote(entity);
  }

  /// 메모 조회
  Future<Note?> getNoteById(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return null;

    await entity.folder.load();
    await entity.tags.load();

    return _mapToNote(entity);
  }

  /// 모든 메모 조회
  Future<List<Note>> getAllNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys.where().findAll();

    final notes = <Note>[];
    for (final entity in entities) {
      await entity.folder.load();
      await entity.tags.load();
      notes.add(_mapToNote(entity));
    }

    return notes;
  }

  /// 활성 메모 조회
  Future<List<Note>> getActiveNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .isArchivedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 고정된 메모 조회
  Future<List<Note>> getPinnedNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isPinnedEqualTo(true)
        .and()
        .isDeletedEqualTo(false)
        .sortByOrderDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 보관된 메모 조회
  Future<List<Note>> getArchivedNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isArchivedEqualTo(true)
        .and()
        .isDeletedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 삭제된 메모 조회
  Future<List<Note>> getDeletedNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(true)
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 즐겨찾기 메모 조회
  Future<List<Note>> getFavoriteNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isFavoriteEqualTo(true)
        .and()
        .isDeletedEqualTo(false)
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 폴더별 메모 조회
  Future<List<Note>> getNotesByFolder(String folderId) async {
    final isar = await IsarDatabase.getInstance();
    final folderEntity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(folderId)
        .findFirst();

    if (folderEntity == null) return [];

    await folderEntity.notes.load();
    return _mapToNotes(folderEntity.notes.toList());
  }

  /// 태그별 메모 조회
  Future<List<Note>> getNotesByTag(String tagId) async {
    final isar = await IsarDatabase.getInstance();
    final tagEntity = await isar.tagEntitys
        .filter()
        .uuidEqualTo(tagId)
        .findFirst();

    if (tagEntity == null) return [];

    await tagEntity.notes.load();
    return _mapToNotes(tagEntity.notes.toList());
  }

  /// 메모 검색
  Future<List<Note>> searchNotes(String query) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .group((q) => q
            .titleContains(query, caseSensitive: false)
            .or()
            .contentContains(query, caseSensitive: false))
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 메모 업데이트
  Future<Note> updateNote(Note note) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(note.id)
        .findFirst();

    if (entity == null) {
      throw Exception('Note not found: ${note.id}');
    }

    entity.title = note.title;
    entity.content = note.content;
    entity.type = _mapNoteType(note.type);
    entity.isPinned = note.isPinned;
    entity.isArchived = note.isArchived;
    entity.isDeleted = note.isDeleted;
    entity.isFavorite = note.isFavorite;
    entity.order = note.order;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(entity);

      // 폴더 업데이트
      if (note.folder != null) {
        final folderEntity = await isar.folderEntitys
            .filter()
            .uuidEqualTo(note.folder!.id)
            .findFirst();
        entity.folder.value = folderEntity;
      } else {
        entity.folder.value = null;
      }
      await entity.folder.save();

      // 태그 업데이트
      await entity.tags.load();
      final oldTags = entity.tags.toList();
      entity.tags.clear();

      if (note.tags.isNotEmpty) {
        final newTagEntities = await isar.tagEntitys
            .filter()
            .anyOf(note.tags, (q, tag) => q.uuidEqualTo(tag.id))
            .findAll();
        entity.tags.addAll(newTagEntities);

        // 태그 사용 횟수 업데이트
        for (final oldTag in oldTags) {
          if (!newTagEntities.any((t) => t.id == oldTag.id)) {
            oldTag.useCount = oldTag.useCount > 0 ? oldTag.useCount - 1 : 0;
            oldTag.updatedAt = DateTime.now();
            await isar.tagEntitys.put(oldTag);
          }
        }

        for (final newTag in newTagEntities) {
          if (!oldTags.any((t) => t.id == newTag.id)) {
            newTag.useCount++;
            newTag.updatedAt = DateTime.now();
            await isar.tagEntitys.put(newTag);
          }
        }
      }

      await entity.tags.save();
    });

    await entity.folder.load();
    await entity.tags.load();

    return _mapToNote(entity);
  }

  /// 메모 삭제 (휴지통으로 이동)
  Future<void> deleteNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.isDeleted = true;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(entity);
    });
  }

  /// 메모 영구 삭제
  Future<void> permanentlyDeleteNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    await isar.writeTxn(() async {
      // 태그 사용 횟수 감소
      await entity.tags.load();
      for (final tag in entity.tags) {
        tag.useCount = tag.useCount > 0 ? tag.useCount - 1 : 0;
        tag.updatedAt = DateTime.now();
        await isar.tagEntitys.put(tag);
      }

      await isar.noteEntitys.delete(entity.id);
    });
  }

  /// 메모 복원
  Future<void> restoreNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.isDeleted = false;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(entity);
    });
  }

  /// 메모 고정/고정 해제
  Future<void> togglePinNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.isPinned = !entity.isPinned;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(entity);
    });
  }

  /// 최근 메모 조회
  Future<List<Note>> getRecentNotes({int limit = 10}) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(false)
        .sortByUpdatedAtDesc()
        .limit(limit)
        .findAll();

    return _mapToNotes(entities);
  }

  /// 오늘 생성된 메모 조회
  Future<List<Note>> getTodayNotes() async {
    final isar = await IsarDatabase.getInstance();
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final entities = await isar.noteEntitys
        .filter()
        .createdAtGreaterThan(startOfDay)
        .and()
        .isDeletedEqualTo(false)
        .sortByCreatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// Entity → Note 변환
  Note _mapToNote(NoteEntity entity) {
    return Note(
      id: entity.uuid,
      title: entity.title,
      content: entity.content,
      type: _mapNoteTypeFromEntity(entity.type),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      isPinned: entity.isPinned,
      isArchived: entity.isArchived,
      isDeleted: entity.isDeleted,
      isFavorite: entity.isFavorite,
      order: entity.order,
      folder: entity.folder.value != null
          ? _mapToFolder(entity.folder.value!)
          : null,
      tags: entity.tags.map(_mapToTag).toList(),
    );
  }

  /// 여러 Entity → Note 변환
  Future<List<Note>> _mapToNotes(List<NoteEntity> entities) async {
    final notes = <Note>[];
    for (final entity in entities) {
      await entity.folder.load();
      await entity.tags.load();
      notes.add(_mapToNote(entity));
    }
    return notes;
  }

  /// NoteType 변환
  NoteType _mapNoteType(NoteType type) {
    return type;
  }

  NoteType _mapNoteTypeFromEntity(NoteType type) {
    return type;
  }

  /// FolderEntity → Folder 변환 (helper)
  Folder _mapToFolder(FolderEntity entity) {
    return Folder(
      id: entity.uuid,
      name: entity.name,
      color: entity.color,
      icon: entity.icon,
      parentId: entity.parentId,
      order: entity.order,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// TagEntity → Tag 변환 (helper)
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
