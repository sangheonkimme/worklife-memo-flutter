import '../../entities/folder.dart';
import '../../repositories/folder_repository.dart';

/// 폴더 목록 조회 UseCase
class GetFolders {
  final FolderRepository _repository;

  GetFolders(this._repository);

  /// 모든 폴더 조회
  Future<List<Folder>> call() async {
    return await _repository.getAllFolders();
  }

  /// 루트 폴더 조회
  Future<List<Folder>> getRootFolders() async {
    return await _repository.getRootFolders();
  }

  /// 하위 폴더 조회
  Future<List<Folder>> getSubFolders(String parentId) async {
    return await _repository.getSubFolders(parentId);
  }

  /// 폴더 트리 조회
  Future<Map<String, List<Folder>>> getFolderTree() async {
    return await _repository.getFolderTree();
  }
}
