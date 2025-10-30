import '../../entities/folder.dart';
import '../../repositories/folder_repository.dart';

/// 폴더 단일 조회 UseCase
class GetFolderById {
  final FolderRepository _repository;

  GetFolderById(this._repository);

  /// 폴더 조회
  ///
  /// [id] 조회할 폴더 ID
  /// Returns: 폴더 정보 (없으면 null)
  Future<Folder?> call(String id) async {
    return await _repository.getFolderById(id);
  }
}
