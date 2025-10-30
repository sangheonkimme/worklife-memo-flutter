import '../../repositories/folder_repository.dart';

/// 폴더 이름 변경 UseCase
class RenameFolder {
  final FolderRepository _repository;

  RenameFolder(this._repository);

  /// 폴더 이름 변경
  ///
  /// [id] 폴더 ID
  /// [newName] 새 이름
  Future<void> call(String id, String newName) async {
    return await _repository.renameFolder(id, newName);
  }
}
