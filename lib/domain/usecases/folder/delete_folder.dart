import '../../repositories/folder_repository.dart';

/// 폴더 삭제 UseCase
class DeleteFolder {
  final FolderRepository _repository;

  DeleteFolder(this._repository);

  /// 폴더 삭제
  ///
  /// [id] 삭제할 폴더 ID
  /// [deleteNotes] true인 경우 폴더 내 메모도 함께 삭제
  Future<void> call(String id, {bool deleteNotes = false}) async {
    return await _repository.deleteFolder(id, deleteNotes: deleteNotes);
  }
}
