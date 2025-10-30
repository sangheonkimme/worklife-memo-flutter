import '../../entities/folder.dart';
import '../../repositories/folder_repository.dart';

/// 폴더 업데이트 UseCase
class UpdateFolder {
  final FolderRepository _repository;

  UpdateFolder(this._repository);

  /// 폴더 업데이트
  ///
  /// [folder] 업데이트할 폴더 정보
  /// Returns: 업데이트된 폴더
  Future<Folder> call(Folder folder) async {
    return await _repository.updateFolder(folder);
  }
}
