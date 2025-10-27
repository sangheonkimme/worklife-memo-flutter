import '../entities/folder.dart';

/// 폴더 Repository Interface
abstract class FolderRepository {
  /// 폴더 생성
  Future<Folder> createFolder(Folder folder);

  /// 폴더 조회 (단일)
  Future<Folder?> getFolderById(String id);

  /// 모든 폴더 조회
  Future<List<Folder>> getAllFolders();

  /// 루트 폴더 조회
  Future<List<Folder>> getRootFolders();

  /// 하위 폴더 조회
  Future<List<Folder>> getSubFolders(String parentId);

  /// 폴더 트리 조회 (계층 구조)
  Future<Map<String, List<Folder>>> getFolderTree();

  /// 폴더 업데이트
  Future<Folder> updateFolder(Folder folder);

  /// 폴더 삭제
  /// [deleteNotes]: true인 경우 폴더 내 메모도 함께 삭제
  Future<void> deleteFolder(String id, {bool deleteNotes = false});

  /// 폴더 이동 (부모 폴더 변경)
  Future<void> moveFolder(String folderId, String? newParentId);

  /// 폴더 이름 변경
  Future<void> renameFolder(String id, String newName);

  /// 폴더 순서 변경
  Future<void> reorderFolders(List<String> folderIds);

  /// 폴더 내 메모 개수 조회
  Future<int> getNoteCountInFolder(String folderId);

  /// 폴더 경로 조회 (부모 폴더들의 체인)
  Future<List<Folder>> getFolderPath(String folderId);

  /// 폴더 개수 조회
  Future<int> getFolderCount();
}
