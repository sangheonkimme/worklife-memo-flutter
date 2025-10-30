import '../../repositories/folder_repository.dart';

/// 폴더 이동 UseCase
class MoveFolder {
  final FolderRepository _repository;

  MoveFolder(this._repository);

  /// 폴더 이동 (부모 폴더 변경)
  ///
  /// [folderId] 이동할 폴더 ID
  /// [newParentId] 새 부모 폴더 ID (null이면 루트로 이동)
  Future<void> call(String folderId, String? newParentId) async {
    return await _repository.moveFolder(folderId, newParentId);
  }
}
