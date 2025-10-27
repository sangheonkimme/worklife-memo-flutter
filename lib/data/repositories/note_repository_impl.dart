import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/local/note_local_datasource.dart';

/// 메모 Repository 구현
class NoteRepositoryImpl implements NoteRepository {
  final NoteLocalDataSource localDataSource;

  NoteRepositoryImpl({required this.localDataSource});

  /// 에러 핸들러 - Exception을 Failure로 변환
  Never _handleError(dynamic error) {
    if (error is DatabaseException) {
      throw DatabaseFailure(message: error.message);
    } else if (error is CacheException) {
      throw CacheFailure(message: error.message);
    } else {
      throw CacheFailure(message: error.toString());
    }
  }

  @override
  Future<Note> createNote(Note note) async {
    try {
      return await localDataSource.createNote(note);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Note?> getNoteById(String id) async {
    try {
      return await localDataSource.getNoteById(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getAllNotes() async {
    try {
      return await localDataSource.getAllNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getActiveNotes() async {
    try {
      return await localDataSource.getActiveNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getPinnedNotes() async {
    try {
      return await localDataSource.getPinnedNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getArchivedNotes() async {
    try {
      return await localDataSource.getArchivedNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getDeletedNotes() async {
    try {
      return await localDataSource.getDeletedNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getFavoriteNotes() async {
    try {
      return await localDataSource.getFavoriteNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getNotesByFolder(String folderId) async {
    try {
      return await localDataSource.getNotesByFolder(folderId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getNotesByTag(String tagId) async {
    try {
      return await localDataSource.getNotesByTag(tagId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> searchNotes(String query) async {
    try {
      return await localDataSource.searchNotes(query);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Note> updateNote(Note note) async {
    try {
      return await localDataSource.updateNote(note);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    try {
      await localDataSource.deleteNote(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> permanentlyDeleteNote(String id) async {
    try {
      await localDataSource.permanentlyDeleteNote(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> restoreNote(String id) async {
    try {
      await localDataSource.restoreNote(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> togglePinNote(String id) async {
    try {
      await localDataSource.togglePinNote(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> toggleArchiveNote(String id) async {
    try {
      final note = await localDataSource.getNoteById(id);
      if (note != null) {
        final updatedNote = note.copyWith(isArchived: !note.isArchived);
        await localDataSource.updateNote(updatedNote);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> toggleFavoriteNote(String id) async {
    try {
      final note = await localDataSource.getNoteById(id);
      if (note != null) {
        final updatedNote = note.copyWith(isFavorite: !note.isFavorite);
        await localDataSource.updateNote(updatedNote);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> setNoteFolder(String noteId, String? folderId) async {
    try {
      final note = await localDataSource.getNoteById(noteId);
      if (note != null) {
        // folderId를 사용하여 Folder 객체를 조회해야 하지만,
        // 현재는 null로 설정 (추후 FolderRepository를 주입받아 처리)
        final updatedNote = note.copyWith(folder: null);
        await localDataSource.updateNote(updatedNote);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> addTagToNote(String noteId, String tagId) async {
    try {
      final note = await localDataSource.getNoteById(noteId);
      if (note != null) {
        // tagId를 사용하여 Tag 객체를 조회하고 추가해야 함
        // 현재는 구현 보류 (추후 TagRepository를 주입받아 처리)
        await localDataSource.updateNote(note);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> removeTagFromNote(String noteId, String tagId) async {
    try {
      final note = await localDataSource.getNoteById(noteId);
      if (note != null) {
        final updatedTags = note.tags.where((tag) => tag.id != tagId).toList();
        final updatedNote = note.copyWith(tags: updatedTags);
        await localDataSource.updateNote(updatedNote);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> setNoteTags(String noteId, List<String> tagIds) async {
    try {
      final note = await localDataSource.getNoteById(noteId);
      if (note != null) {
        // tagIds를 사용하여 Tag 객체들을 조회해야 함
        // 현재는 구현 보류 (추후 TagRepository를 주입받아 처리)
        await localDataSource.updateNote(note);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getRecentNotes({int limit = 10}) async {
    try {
      return await localDataSource.getRecentNotes(limit: limit);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getNoteCount() async {
    try {
      final notes = await localDataSource.getAllNotes();
      return notes.length;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getActiveNoteCount() async {
    try {
      final notes = await localDataSource.getActiveNotes();
      return notes.length;
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getTodayNotes() async {
    try {
      return await localDataSource.getTodayNotes();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getThisWeekNotes() async {
    try {
      final now = DateTime.now();
      final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday + 1);

      final allNotes = await localDataSource.getAllNotes();
      return allNotes
          .where((note) =>
              note.createdAt.isAfter(startOfWeek) &&
              !note.isDeleted)
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Note>> getThisMonthNotes() async {
    try {
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);

      final allNotes = await localDataSource.getAllNotes();
      return allNotes
          .where((note) =>
              note.createdAt.isAfter(startOfMonth) &&
              !note.isDeleted)
          .toList();
    } catch (e) {
      _handleError(e);
    }
  }
}
