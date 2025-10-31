import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../domain/entities/note.dart' as domain;
import '../../../domain/entities/folder.dart' as domain_folder;
import '../../../domain/entities/tag.dart' as domain_tag;
import 'drift/app_database.dart';
import 'drift/tables.dart';

/// 메모 Local Data Source
class NoteLocalDataSource {
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  NoteLocalDataSource(this._database);

  /// 메모 생성
  Future<domain.Note> createNote(domain.Note note) async {
    final uuid = _uuid.v4();
    final now = DateTime.now();

    return await _database.transaction(() async {
      // 폴더 ID 조회
      int? folderDbId;
      if (note.folder != null) {
        final folder = await _database.getFolderByUuid(note.folder!.id);
        folderDbId = folder?.id;
      }

      // 메모 삽입
      final noteId = await _database.insertNote(
        NotesCompanion.insert(
          uuid: uuid,
          title: note.title,
          content: note.content,
          type: _mapNoteTypeToTable(note.type),
          createdAt: now,
          updatedAt: now,
          isPinned: Value(note.isPinned),
          isArchived: Value(note.isArchived),
          isDeleted: Value(note.isDeleted),
          isFavorite: Value(note.isFavorite),
          order: Value(note.order),
          folderId: Value(folderDbId),
        ),
      );

      // 태그 연결
      if (note.tags.isNotEmpty) {
        for (final tag in note.tags) {
          final tagEntity = await _database.getTagByUuid(tag.id);
          if (tagEntity != null) {
            await _database.linkNoteToTag(noteId, tagEntity.id);

            // 태그 사용 횟수 증가
            await _database.updateTag(tagEntity.copyWith(
              useCount: tagEntity.useCount + 1,
              updatedAt: now,
            ));
          }
        }
      }

      final created = await getNoteById(uuid);
      if (created == null) throw Exception('Failed to create note');
      return created;
    });
  }

  /// 메모 조회
  Future<domain.Note?> getNoteById(String id) async {
    final noteEntity = await _database.getNoteByUuid(id);
    if (noteEntity == null) return null;

    final folder = noteEntity.folderId != null
        ? await (_database.select(_database.folders)
              ..where((f) => f.id.equals(noteEntity.folderId!)))
            .getSingleOrNull()
        : null;

    final tags = await _database.getTagsForNote(noteEntity.id);

    return _mapToNote(noteEntity, folder, tags);
  }

  /// 모든 메모 조회
  Future<List<domain.Note>> getAllNotes() async {
    final notesList = await _database.getAllNotes();
    return await _mapNotesWithRelations(notesList);
  }

  /// 활성 메모 조회
  Future<List<domain.Note>> getActiveNotes() async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isDeleted.equals(false) & n.isArchived.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 고정된 메모 조회
  Future<List<domain.Note>> getPinnedNotes() async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isPinned.equals(true) & n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.order)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 보관된 메모 조회
  Future<List<domain.Note>> getArchivedNotes() async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isArchived.equals(true) & n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 삭제된 메모 조회
  Future<List<domain.Note>> getDeletedNotes() async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isDeleted.equals(true))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 즐겨찾기 메모 조회
  Future<List<domain.Note>> getFavoriteNotes() async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isFavorite.equals(true) & n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 폴더별 메모 조회
  Future<List<domain.Note>> getNotesByFolder(String folderId) async {
    final folder = await _database.getFolderByUuid(folderId);
    if (folder == null) return [];

    final notes = await (_database.select(_database.notes)
          ..where((n) => n.folderId.equals(folder.id)))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 태그별 메모 조회
  Future<List<domain.Note>> getNotesByTag(String tagId) async {
    final tag = await _database.getTagByUuid(tagId);
    if (tag == null) return [];

    final notes = await _database.getNotesForTag(tag.id);
    return await _mapNotesWithRelations(notes);
  }

  /// 메모 검색
  Future<List<domain.Note>> searchNotes(String query) async {
    final lowerQuery = '%${query.toLowerCase()}%';
    final notes = await (_database.select(_database.notes)
          ..where((n) =>
              n.isDeleted.equals(false) &
              (n.title.lower().like(lowerQuery) |
                  n.content.lower().like(lowerQuery)))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 메모 업데이트
  Future<domain.Note> updateNote(domain.Note note) async {
    final noteEntity = await _database.getNoteByUuid(note.id);
    if (noteEntity == null) {
      throw Exception('Note not found: ${note.id}');
    }

    return await _database.transaction(() async {
      final now = DateTime.now();

      // 폴더 ID 조회
      int? folderDbId;
      if (note.folder != null) {
        final folder = await _database.getFolderByUuid(note.folder!.id);
        folderDbId = folder?.id;
      }

      // 메모 업데이트
      await _database.updateNote(noteEntity.copyWith(
        title: note.title,
        content: note.content,
        type: _mapNoteTypeToTable(note.type),
        isPinned: note.isPinned,
        isArchived: note.isArchived,
        isDeleted: note.isDeleted,
        isFavorite: note.isFavorite,
        order: Value(note.order),
        folderId: Value(folderDbId),
        updatedAt: now,
      ));

      // 기존 태그 연결 조회
      final oldTags = await _database.getTagsForNote(noteEntity.id);
      final oldTagIds = oldTags.map((t) => t.id).toSet();
      final newTagUuids = note.tags.map((t) => t.id).toSet();

      // 새로운 태그 처리
      for (final tagUuid in newTagUuids) {
        final tag = await _database.getTagByUuid(tagUuid);
        if (tag != null) {
          if (!oldTagIds.contains(tag.id)) {
            // 새로 추가된 태그
            await _database.linkNoteToTag(noteEntity.id, tag.id);
            await _database.updateTag(tag.copyWith(
              useCount: tag.useCount + 1,
              updatedAt: now,
            ));
          }
        }
      }

      // 제거된 태그 처리
      for (final oldTag in oldTags) {
        final oldTagUuid = oldTag.uuid;
        if (!newTagUuids.contains(oldTagUuid)) {
          await _database.unlinkNoteFromTag(noteEntity.id, oldTag.id);
          await _database.updateTag(oldTag.copyWith(
            useCount: oldTag.useCount > 0 ? oldTag.useCount - 1 : 0,
            updatedAt: now,
          ));
        }
      }

      final updated = await getNoteById(note.id);
      if (updated == null) throw Exception('Failed to update note');
      return updated;
    });
  }

  /// 메모 삭제 (휴지통으로 이동)
  Future<void> deleteNote(String id) async {
    final noteEntity = await _database.getNoteByUuid(id);
    if (noteEntity == null) return;

    await _database.updateNote(noteEntity.copyWith(
      isDeleted: true,
      updatedAt: DateTime.now(),
    ));
  }

  /// 메모 영구 삭제
  Future<void> permanentlyDeleteNote(String id) async {
    final noteEntity = await _database.getNoteByUuid(id);
    if (noteEntity == null) return;

    await _database.transaction(() async {
      // 태그 사용 횟수 감소
      final tags = await _database.getTagsForNote(noteEntity.id);
      final now = DateTime.now();
      for (final tag in tags) {
        await _database.updateTag(tag.copyWith(
          useCount: tag.useCount > 0 ? tag.useCount - 1 : 0,
          updatedAt: now,
        ));
      }

      await _database.deleteNote(noteEntity.id);
    });
  }

  /// 메모 복원
  Future<void> restoreNote(String id) async {
    final noteEntity = await _database.getNoteByUuid(id);
    if (noteEntity == null) return;

    await _database.updateNote(noteEntity.copyWith(
      isDeleted: false,
      updatedAt: DateTime.now(),
    ));
  }

  /// 메모 고정/고정 해제
  Future<void> togglePinNote(String id) async {
    final noteEntity = await _database.getNoteByUuid(id);
    if (noteEntity == null) return;

    await _database.updateNote(noteEntity.copyWith(
      isPinned: !noteEntity.isPinned,
      updatedAt: DateTime.now(),
    ));
  }

  /// 최근 메모 조회
  Future<List<domain.Note>> getRecentNotes({int limit = 10}) async {
    final notes = await (_database.select(_database.notes)
          ..where((n) => n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.updatedAt)])
          ..limit(limit))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 오늘 생성된 메모 조회
  Future<List<domain.Note>> getTodayNotes() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);

    final notes = await (_database.select(_database.notes)
          ..where((n) =>
              n.createdAt.isBiggerThanValue(startOfDay) &
              n.isDeleted.equals(false))
          ..orderBy([(n) => OrderingTerm.desc(n.createdAt)]))
        .get();
    return await _mapNotesWithRelations(notes);
  }

  /// 여러 메모를 관계와 함께 매핑
  Future<List<domain.Note>> _mapNotesWithRelations(List<Note> notes) async {
    final result = <domain.Note>[];
    for (final noteEntity in notes) {
      final folder = noteEntity.folderId != null
          ? await (_database.select(_database.folders)
                ..where((f) => f.id.equals(noteEntity.folderId!)))
              .getSingleOrNull()
          : null;

      final tags = await _database.getTagsForNote(noteEntity.id);
      result.add(_mapToNote(noteEntity, folder, tags));
    }
    return result;
  }

  /// Entity → Note 변환
  domain.Note _mapToNote(Note noteEntity, Folder? folder, List<Tag> tags) {
    return domain.Note(
      id: noteEntity.uuid,
      title: noteEntity.title,
      content: noteEntity.content,
      type: _mapNoteTypeFromTable(noteEntity.type),
      createdAt: noteEntity.createdAt,
      updatedAt: noteEntity.updatedAt,
      isPinned: noteEntity.isPinned,
      isArchived: noteEntity.isArchived,
      isDeleted: noteEntity.isDeleted,
      isFavorite: noteEntity.isFavorite,
      order: noteEntity.order,
      folder: folder != null ? _mapToFolder(folder) : null,
      tags: tags.map(_mapToTag).toList(),
    );
  }

  /// NoteType 변환: Domain → Table
  NoteType _mapNoteTypeToTable(domain.NoteType type) {
    switch (type) {
      case domain.NoteType.richText:
        return NoteType.richText;
      case domain.NoteType.markdown:
        return NoteType.markdown;
      case domain.NoteType.checklist:
        return NoteType.checklist;
    }
  }

  /// NoteType 변환: Table → Domain
  domain.NoteType _mapNoteTypeFromTable(NoteType type) {
    switch (type) {
      case NoteType.richText:
        return domain.NoteType.richText;
      case NoteType.markdown:
        return domain.NoteType.markdown;
      case NoteType.checklist:
        return domain.NoteType.checklist;
    }
  }

  /// Folder entity → Domain Folder 변환
  domain_folder.Folder _mapToFolder(Folder entity) {
    return domain_folder.Folder(
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

  /// Tag entity → Domain Tag 변환
  domain_tag.Tag _mapToTag(Tag entity) {
    return domain_tag.Tag(
      id: entity.uuid,
      name: entity.name,
      color: entity.color,
      useCount: entity.useCount,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
