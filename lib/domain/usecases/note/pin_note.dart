import '../../repositories/note_repository.dart';

/// 메모 고정/고정 해제 UseCase
class PinNote {
  final NoteRepository _repository;

  PinNote(this._repository);

  /// 메모 고정 상태 토글
  ///
  /// [noteId] 고정할 메모 ID
  Future<void> call(String noteId) async {
    return await _repository.togglePinNote(noteId);
  }
}
