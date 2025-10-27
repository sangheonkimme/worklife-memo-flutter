import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/folder.dart';
import '../../domain/repositories/folder_repository.dart';
import '../datasources/local/folder_local_datasource.dart';

/// 폴더 Repository 구현
class FolderRepositoryImpl implements FolderRepository {
  final FolderLocalDataSource localDataSource;

  FolderRepositoryImpl({required this.localDataSource});

  /// 에러 핸들러 - Exception을 Failure로 변환
  Never _handleError(dynamic error) {
    if (error is DatabaseException) {
      throw DatabaseFailure(message: error.message);
    } else if (error is CacheException) {
      throw CacheFailure(message: error.message);
    } else {
      throw CacheFailure(message: error.toString());
    }
  }

  @override
  Future<Folder> createFolder(Folder folder) async {
    try {
      return await localDataSource.createFolder(folder);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Folder?> getFolderById(String id) async {
    try {
      return await localDataSource.getFolderById(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Folder>> getAllFolders() async {
    try {
      return await localDataSource.getAllFolders();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Folder>> getRootFolders() async {
    try {
      return await localDataSource.getRootFolders();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Folder>> getSubFolders(String parentId) async {
    try {
      return await localDataSource.getSubFolders(parentId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Map<String, List<Folder>>> getFolderTree() async {
    try {
      return await localDataSource.getFolderTree();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Folder> updateFolder(Folder folder) async {
    try {
      return await localDataSource.updateFolder(folder);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> deleteFolder(String id, {bool deleteNotes = false}) async {
    try {
      await localDataSource.deleteFolder(id, deleteNotes: deleteNotes);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> moveFolder(String folderId, String? newParentId) async {
    try {
      await localDataSource.moveFolder(folderId, newParentId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> renameFolder(String id, String newName) async {
    try {
      await localDataSource.renameFolder(id, newName);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> reorderFolders(List<String> folderIds) async {
    try {
      await localDataSource.reorderFolders(folderIds);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getNoteCountInFolder(String folderId) async {
    try {
      return await localDataSource.getNoteCountInFolder(folderId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Folder>> getFolderPath(String folderId) async {
    try {
      return await localDataSource.getFolderPath(folderId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getFolderCount() async {
    try {
      return await localDataSource.getFolderCount();
    } catch (e) {
      _handleError(e);
    }
  }
}
