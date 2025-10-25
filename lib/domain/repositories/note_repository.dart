import 'package:worklife_memo_flutter/data/datasources/local/drift_service.dart';
import 'package:worklife_memo_flutter/data/datasources/local/note_local_datasource.dart';

abstract class NoteRepository {
  Future<void> addNote(NotesCompanion note);
  Future<List<Note>> getAllNotes();
  Future<void> deleteNote(int id);
  Future<void> updateNote(Note note);
}

class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addNote(NotesCompanion note) {
    return localDataSource.addNote(note);
  }

  @override
  Future<List<Note>> getAllNotes() {
    return localDataSource.getAllNotes();
  }

  @override
  Future<void> deleteNote(int id) {
    return localDataSource.deleteNote(id);
  }

  @override
  Future<void> updateNote(Note note) {
    return localDataSource.updateNote(note);
  }
}
