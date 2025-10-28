import '../../repositories/note_repository.dart';

/// 메모 삭제 UseCase (휴지통으로 이동)
class DeleteNote {
  final NoteRepository _repository;

  DeleteNote(this._repository);

  /// 메모를 휴지통으로 이동
  ///
  /// [noteId] 삭제할 메모 ID
  Future<void> call(String noteId) async {
    return await _repository.deleteNote(noteId);
  }
}

/// 메모 영구 삭제 UseCase
class PermanentlyDeleteNote {
  final NoteRepository _repository;

  PermanentlyDeleteNote(this._repository);

  /// 메모를 영구 삭제
  ///
  /// [noteId] 영구 삭제할 메모 ID
  Future<void> call(String noteId) async {
    return await _repository.permanentlyDeleteNote(noteId);
  }
}

/// 메모 복원 UseCase
class RestoreNote {
  final NoteRepository _repository;

  RestoreNote(this._repository);

  /// 휴지통에서 메모 복원
  ///
  /// [noteId] 복원할 메모 ID
  Future<void> call(String noteId) async {
    return await _repository.restoreNote(noteId);
  }
}
