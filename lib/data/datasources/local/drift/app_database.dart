import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tables.dart';

part 'app_database.g.dart';

/// Drift 데이터베이스
@DriftDatabase(tables: [
  Folders,
  Tags,
  Notes,
  ChecklistItems,
  NoteTags,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      beforeOpen: (details) async {
        // Foreign key 활성화
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// 폴더 관련 메서드
  Future<List<Folder>> getAllFolders() => select(folders).get();

  Future<Folder?> getFolderByUuid(String uuid) =>
      (select(folders)..where((f) => f.uuid.equals(uuid))).getSingleOrNull();

  Future<int> insertFolder(FoldersCompanion folder) => into(folders).insert(folder);

  Future<bool> updateFolder(Folder folder) => update(folders).replace(folder);

  Future<int> deleteFolder(int id) =>
      (delete(folders)..where((f) => f.id.equals(id))).go();

  /// 태그 관련 메서드
  Future<List<Tag>> getAllTags() => select(tags).get();

  Future<Tag?> getTagByUuid(String uuid) =>
      (select(tags)..where((t) => t.uuid.equals(uuid))).getSingleOrNull();

  Future<Tag?> getTagByName(String name) =>
      (select(tags)..where((t) => t.name.equals(name))).getSingleOrNull();

  Future<int> insertTag(TagsCompanion tag) => into(tags).insert(tag);

  Future<bool> updateTag(Tag tag) => update(tags).replace(tag);

  Future<int> deleteTag(int id) =>
      (delete(tags)..where((t) => t.id.equals(id))).go();

  /// 메모 관련 메서드
  Future<List<Note>> getAllNotes() => select(notes).get();

  Future<Note?> getNoteByUuid(String uuid) =>
      (select(notes)..where((n) => n.uuid.equals(uuid))).getSingleOrNull();

  Future<int> insertNote(NotesCompanion note) => into(notes).insert(note);

  Future<bool> updateNote(Note note) => update(notes).replace(note);

  Future<int> deleteNote(int id) =>
      (delete(notes)..where((n) => n.id.equals(id))).go();

  /// 체크리스트 항목 관련 메서드
  Future<List<ChecklistItem>> getChecklistItemsByNoteId(int noteId) =>
      (select(checklistItems)..where((c) => c.noteId.equals(noteId))).get();

  Future<int> insertChecklistItem(ChecklistItemsCompanion item) =>
      into(checklistItems).insert(item);

  Future<bool> updateChecklistItem(ChecklistItem item) =>
      update(checklistItems).replace(item);

  Future<int> deleteChecklistItem(int id) =>
      (delete(checklistItems)..where((c) => c.id.equals(id))).go();

  /// 메모-태그 관계 관련 메서드
  Future<void> linkNoteToTag(int noteId, int tagId) {
    return into(noteTags).insert(
      NoteTagsCompanion(
        noteId: Value(noteId),
        tagId: Value(tagId),
      ),
    );
  }

  Future<int> unlinkNoteFromTag(int noteId, int tagId) {
    return (delete(noteTags)
          ..where((nt) => nt.noteId.equals(noteId) & nt.tagId.equals(tagId)))
        .go();
  }

  Future<List<Tag>> getTagsForNote(int noteId) {
    final query = select(tags).join([
      innerJoin(noteTags, noteTags.tagId.equalsExp(tags.id)),
    ])
      ..where(noteTags.noteId.equals(noteId));

    return query.map((row) => row.readTable(tags)).get();
  }

  Future<List<Note>> getNotesForTag(int tagId) {
    final query = select(notes).join([
      innerJoin(noteTags, noteTags.noteId.equalsExp(notes.id)),
    ])
      ..where(noteTags.tagId.equals(tagId));

    return query.map((row) => row.readTable(notes)).get();
  }
}

/// 데이터베이스 연결 생성
QueryExecutor _openConnection() {
  return driftDatabase(name: 'worklife_memo_db');
}
