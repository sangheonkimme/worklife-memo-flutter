import 'package:uuid/uuid.dart';
import '../../../domain/entities/note.dart' as domain;
import '../../../domain/entities/folder.dart';
import '../../../domain/entities/tag.dart';
import 'isar_database.dart';
import 'entities/note_entity.dart' as entity;
import 'entities/folder_entity.dart';
import 'entities/tag_entity.dart';
import 'package:isar/isar.dart';

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
      await isar.noteEntitys.put(noteEntity);

      // 폴더 연결
      if (note.folder != null) {
        final folderEntity = await isar.folderEntitys
            .filter()
            .uuidEqualTo(note.folder!.id)
            .findFirst();
        if (folderEntity != null) {
          noteEntity.folder.value = folderEntity;
          await noteEntity.folder.save();
        }
      }

      // 태그 연결
      if (note.tags.isNotEmpty) {
        final tagEntities = await isar.tagEntitys
            .filter()
            .anyOf(note.tags, (q, tag) => q.uuidEqualTo(tag.id))
            .findAll();
        noteEntity.tags.addAll(tagEntities);
        await noteEntity.tags.save();

        // 태그 사용 횟수 증가
        for (final tagEntity in tagEntities) {
          tagEntity.useCount++;
          tagEntity.updatedAt = DateTime.now();
          await isar.tagEntitys.put(tagEntity);
        }
      }
    });

    return _mapToNote(noteEntity);
  }

  /// 메모 조회
  Future<domain.Note?> getNoteById(String id) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (noteEntity == null) return null;

    await noteEntity.folder.load();
    await noteEntity.tags.load();

    return _mapToNote(noteEntity);
  }

  /// 모든 메모 조회
  Future<List<domain.Note>> getAllNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys.where().findAll();

    final notes = <domain.Note>[];
    for (final noteEntity in entities) {
      await noteEntity.folder.load();
      await noteEntity.tags.load();
      notes.add(_mapToNote(noteEntity));
    }

    return notes;
  }

  /// 활성 메모 조회
  Future<List<domain.Note>> getActiveNotes() async {
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
  Future<List<domain.Note>> getPinnedNotes() async {
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
  Future<List<domain.Note>> getArchivedNotes() async {
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
  Future<List<domain.Note>> getDeletedNotes() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(true)
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 즐겨찾기 메모 조회
  Future<List<domain.Note>> getFavoriteNotes() async {
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
  Future<List<domain.Note>> getNotesByFolder(String folderId) async {
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
  Future<List<domain.Note>> getNotesByTag(String tagId) async {
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
  Future<List<domain.Note>> searchNotes(String query) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.noteEntitys
        .filter()
        .isDeletedEqualTo(false)
        .and()
        .group(
          (q) => q
              .titleContains(query, caseSensitive: false)
              .or()
              .contentContains(query, caseSensitive: false),
        )
        .sortByUpdatedAtDesc()
        .findAll();

    return _mapToNotes(entities);
  }

  /// 메모 업데이트
  Future<domain.Note> updateNote(domain.Note note) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(note.id)
        .findFirst();

    if (noteEntity == null) {
      throw Exception('Note not found: ${note.id}');
    }

    noteEntity.title = note.title;
    noteEntity.content = note.content;
    noteEntity.type = _mapNoteTypeToEntity(note.type);
    noteEntity.isPinned = note.isPinned;
    noteEntity.isArchived = note.isArchived;
    noteEntity.isDeleted = note.isDeleted;
    noteEntity.isFavorite = note.isFavorite;
    noteEntity.order = note.order;
    noteEntity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(noteEntity);

      // 폴더 업데이트
      if (note.folder != null) {
        final folderEntity = await isar.folderEntitys
            .filter()
            .uuidEqualTo(note.folder!.id)
            .findFirst();
        noteEntity.folder.value = folderEntity;
      } else {
        noteEntity.folder.value = null;
      }
      await noteEntity.folder.save();

      // 태그 업데이트
      await noteEntity.tags.load();
      final oldTags = noteEntity.tags.toList();
      noteEntity.tags.clear();

      if (note.tags.isNotEmpty) {
        final newTagEntities = await isar.tagEntitys
            .filter()
            .anyOf(note.tags, (q, tag) => q.uuidEqualTo(tag.id))
            .findAll();
        noteEntity.tags.addAll(newTagEntities);

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

      await noteEntity.tags.save();
    });

    await noteEntity.folder.load();
    await noteEntity.tags.load();

    return _mapToNote(noteEntity);
  }

  /// 메모 삭제 (휴지통으로 이동)
  Future<void> deleteNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (noteEntity == null) return;

    noteEntity.isDeleted = true;
    noteEntity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(noteEntity);
    });
  }

  /// 메모 영구 삭제
  Future<void> permanentlyDeleteNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (noteEntity == null) return;

    await isar.writeTxn(() async {
      // 태그 사용 횟수 감소
      await noteEntity.tags.load();
      for (final tag in noteEntity.tags) {
        tag.useCount = tag.useCount > 0 ? tag.useCount - 1 : 0;
        tag.updatedAt = DateTime.now();
        await isar.tagEntitys.put(tag);
      }

      await isar.noteEntitys.delete(noteEntity.id);
    });
  }

  /// 메모 복원
  Future<void> restoreNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (noteEntity == null) return;

    noteEntity.isDeleted = false;
    noteEntity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(noteEntity);
    });
  }

  /// 메모 고정/고정 해제
  Future<void> togglePinNote(String id) async {
    final isar = await IsarDatabase.getInstance();
    final noteEntity = await isar.noteEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (noteEntity == null) return;

    noteEntity.isPinned = !noteEntity.isPinned;
    noteEntity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.noteEntitys.put(noteEntity);
    });
  }

  /// 최근 메모 조회
  Future<List<domain.Note>> getRecentNotes({int limit = 10}) async {
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
  Future<List<domain.Note>> getTodayNotes() async {
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
  domain.Note _mapToNote(entity.NoteEntity noteEntity) {
    return domain.Note(
      id: noteEntity.uuid,
      title: noteEntity.title,
      content: noteEntity.content,
      type: _mapNoteTypeFromEntity(noteEntity.type),
      createdAt: noteEntity.createdAt,
      updatedAt: noteEntity.updatedAt,
      isPinned: noteEntity.isPinned,
      isArchived: noteEntity.isArchived,
      isDeleted: noteEntity.isDeleted,
      isFavorite: noteEntity.isFavorite,
      order: noteEntity.order,
      folder: noteEntity.folder.value != null
          ? _mapToFolder(noteEntity.folder.value!)
          : null,
      tags: noteEntity.tags.map(_mapToTag).toList(),
    );
  }

  /// 여러 Entity → Note 변환
  Future<List<domain.Note>> _mapToNotes(
    List<entity.NoteEntity> entities,
  ) async {
    final notes = <domain.Note>[];
    for (final noteEntity in entities) {
      await noteEntity.folder.load();
      await noteEntity.tags.load();
      notes.add(_mapToNote(noteEntity));
    }
    return notes;
  }

  /// NoteType 변환: Domain → Entity
  entity.NoteType _mapNoteTypeToEntity(domain.NoteType type) {
    switch (type) {
      case domain.NoteType.richText:
        return entity.NoteType.richText;
      case domain.NoteType.markdown:
        return entity.NoteType.markdown;
      case domain.NoteType.checklist:
        return entity.NoteType.checklist;
    }
  }

  /// NoteType 변환: Entity → Domain
  domain.NoteType _mapNoteTypeFromEntity(entity.NoteType type) {
    switch (type) {
      case entity.NoteType.richText:
        return domain.NoteType.richText;
      case entity.NoteType.markdown:
        return domain.NoteType.markdown;
      case entity.NoteType.checklist:
        return domain.NoteType.checklist;
    }
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
