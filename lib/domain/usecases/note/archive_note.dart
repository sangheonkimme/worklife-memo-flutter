import '../../repositories/note_repository.dart';

/// 메모 보관/보관 해제 UseCase
class ArchiveNote {
  final NoteRepository _repository;

  ArchiveNote(this._repository);

  /// 메모 보관 상태 토글
  ///
  /// [noteId] 보관할 메모 ID
  Future<void> call(String noteId) async {
    return await _repository.toggleArchiveNote(noteId);
  }
}
