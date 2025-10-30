import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/folder.dart';
import '../../domain/usecases/folder/create_folder.dart';
import '../../domain/usecases/folder/update_folder.dart';
import '../../domain/usecases/folder/delete_folder.dart';
import '../../domain/usecases/folder/get_folders.dart';
import '../../domain/usecases/folder/get_folder_by_id.dart';
import '../../domain/usecases/folder/move_folder.dart';
import '../../domain/usecases/folder/rename_folder.dart';
import 'folder_repository_provider.dart';

part 'folder_provider.g.dart';

/// 폴더 목록 상태 Provider (AsyncNotifier)
///
/// 모든 폴더 목록을 관리하고 CRUD 작업을 수행합니다.
@riverpod
class FolderList extends _$FolderList {
  late GetFolders _getFolders;
  late CreateFolder _createFolder;
  late UpdateFolder _updateFolder;
  late DeleteFolder _deleteFolder;
  late MoveFolder _moveFolder;
  late RenameFolder _renameFolder;

  @override
  Future<List<Folder>> build() async {
    // UseCase 초기화
    final repository = ref.watch(folderRepositoryProvider);
    _getFolders = GetFolders(repository);
    _createFolder = CreateFolder(repository);
    _updateFolder = UpdateFolder(repository);
    _deleteFolder = DeleteFolder(repository);
    _moveFolder = MoveFolder(repository);
    _renameFolder = RenameFolder(repository);

    // 모든 폴더 목록 로드
    return await _getFolders();
  }

  /// 폴더 목록 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getFolders();
    });
  }

  /// 폴더 생성
  Future<void> createFolder(Folder folder) async {
    try {
      await _createFolder(folder);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 폴더 업데이트
  Future<void> updateFolder(Folder folder) async {
    try {
      await _updateFolder(folder);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 폴더 삭제
  Future<void> deleteFolder(String id, {bool deleteNotes = false}) async {
    try {
      await _deleteFolder(id, deleteNotes: deleteNotes);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 폴더 이동
  Future<void> moveFolder(String folderId, String? newParentId) async {
    try {
      await _moveFolder(folderId, newParentId);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 폴더 이름 변경
  Future<void> renameFolder(String id, String newName) async {
    try {
      await _renameFolder(id, newName);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 루트 폴더 목록 Provider
@riverpod
Future<List<Folder>> rootFolders(RootFoldersRef ref) async {
  final repository = ref.watch(folderRepositoryProvider);
  final getFolders = GetFolders(repository);
  return await getFolders.getRootFolders();
}

/// 하위 폴더 목록 Provider
@riverpod
Future<List<Folder>> subFolders(SubFoldersRef ref, String parentId) async {
  final repository = ref.watch(folderRepositoryProvider);
  final getFolders = GetFolders(repository);
  return await getFolders.getSubFolders(parentId);
}

/// 폴더 트리 Provider
@riverpod
Future<Map<String, List<Folder>>> folderTree(FolderTreeRef ref) async {
  final repository = ref.watch(folderRepositoryProvider);
  final getFolders = GetFolders(repository);
  return await getFolders.getFolderTree();
}

/// 단일 폴더 조회 Provider
@riverpod
Future<Folder?> folder(FolderRef ref, String folderId) async {
  final repository = ref.watch(folderRepositoryProvider);
  final getFolderById = GetFolderById(repository);
  return await getFolderById(folderId);
}
