import 'package:worklife_memo_flutter/data/datasources/local/drift_service.dart';

abstract class NoteLocalDataSource {
  Future<void> addNote(NotesCompanion note);

  Future<List<Note>> getAllNotes();

  Future<void> deleteNote(int id);

  Future<void> updateNote(Note note);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final AppDatabase database;

  NoteLocalDataSourceImpl({required this.database});

  @override
  Future<void> addNote(NotesCompanion note) {
    return database.into(database.notes).insert(note);
  }

  @override
  Future<List<Note>> getAllNotes() {
    return database.select(database.notes).get();
  }

  @override
  Future<void> deleteNote(int id) {
    return (database.delete(
      database.notes,
    )..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> updateNote(Note note) {
    return database.update(database.notes).replace(note);
  }
}
