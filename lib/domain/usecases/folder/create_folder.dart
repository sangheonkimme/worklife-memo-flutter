import '../../entities/folder.dart';
import '../../repositories/folder_repository.dart';

/// 폴더 생성 UseCase
class CreateFolder {
  final FolderRepository _repository;

  CreateFolder(this._repository);

  /// 폴더 생성
  ///
  /// [folder] 생성할 폴더 (id는 Repository에서 자동 생성됨)
  /// Returns: 생성된 폴더 (UUID 포함)
  Future<Folder> call(Folder folder) async {
    return await _repository.createFolder(folder);
  }
}
