import '../../entities/note.dart';
import '../../repositories/note_repository.dart';

/// 메모 단일 조회 UseCase
class GetNoteById {
  final NoteRepository _repository;

  GetNoteById(this._repository);

  /// ID로 메모 조회
  ///
  /// [noteId] 조회할 메모 ID
  /// Returns: 메모 (없으면 null)
  Future<Note?> call(String noteId) async {
    return await _repository.getNoteById(noteId);
  }
}
