import '../../entities/note.dart';
import '../../repositories/note_repository.dart';

/// 메모 업데이트 UseCase
class UpdateNote {
  final NoteRepository _repository;

  UpdateNote(this._repository);

  /// 메모 업데이트
  ///
  /// [note] 업데이트할 메모 (id 필수)
  /// Returns: 업데이트된 메모
  Future<Note> call(Note note) async {
    return await _repository.updateNote(note);
  }
}
