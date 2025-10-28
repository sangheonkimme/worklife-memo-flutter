import '../../entities/note.dart';
import '../../repositories/note_repository.dart';

/// 메모 생성 UseCase
class CreateNote {
  final NoteRepository _repository;

  CreateNote(this._repository);

  /// 메모 생성
  ///
  /// [note] 생성할 메모 (id는 Repository에서 자동 생성됨)
  /// Returns: 생성된 메모 (UUID 포함)
  Future<Note> call(Note note) async {
    return await _repository.createNote(note);
  }
}
