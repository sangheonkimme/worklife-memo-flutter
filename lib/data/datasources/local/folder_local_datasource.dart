import 'package:uuid/uuid.dart';
import '../../../domain/entities/folder.dart';
import 'isar_database.dart';
import 'entities/folder_entity.dart';

/// 폴더 Local Data Source
class FolderLocalDataSource {
  final Uuid _uuid = const Uuid();

  /// 폴더 생성
  Future<Folder> createFolder(Folder folder) async {
    final isar = await IsarDatabase.getInstance();
    final uuid = _uuid.v4();

    final entity = FolderEntity.create(
      uuid: uuid,
      name: folder.name,
      color: folder.color,
      icon: folder.icon,
      parentId: folder.parentId,
      order: folder.order,
    );

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(entity);
    });

    return _mapToFolder(entity);
  }

  /// 폴더 조회 (단일)
  Future<Folder?> getFolderById(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return null;

    await entity.notes.load();
    return _mapToFolder(entity);
  }

  /// 모든 폴더 조회
  Future<List<Folder>> getAllFolders() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.folderEntitys
        .where()
        .sortByOrder()
        .findAll();

    return entities.map(_mapToFolder).toList();
  }

  /// 루트 폴더 조회
  Future<List<Folder>> getRootFolders() async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.folderEntitys
        .filter()
        .parentIdIsNull()
        .sortByOrder()
        .findAll();

    return entities.map(_mapToFolder).toList();
  }

  /// 하위 폴더 조회
  Future<List<Folder>> getSubFolders(String parentId) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.folderEntitys
        .filter()
        .parentIdEqualTo(parentId)
        .sortByOrder()
        .findAll();

    return entities.map(_mapToFolder).toList();
  }

  /// 폴더 트리 조회 (계층 구조)
  Future<Map<String, List<Folder>>> getFolderTree() async {
    final isar = await IsarDatabase.getInstance();
    final allFolders = await isar.folderEntitys
        .where()
        .sortByOrder()
        .findAll();

    final tree = <String, List<Folder>>{};

    for (final entity in allFolders) {
      final folder = _mapToFolder(entity);
      final parentKey = entity.parentId ?? 'root';

      if (!tree.containsKey(parentKey)) {
        tree[parentKey] = [];
      }
      tree[parentKey]!.add(folder);
    }

    return tree;
  }

  /// 폴더 업데이트
  Future<Folder> updateFolder(Folder folder) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(folder.id)
        .findFirst();

    if (entity == null) {
      throw Exception('Folder not found: ${folder.id}');
    }

    entity.name = folder.name;
    entity.color = folder.color;
    entity.icon = folder.icon;
    entity.parentId = folder.parentId;
    entity.order = folder.order;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(entity);
    });

    return _mapToFolder(entity);
  }

  /// 폴더 삭제
  Future<void> deleteFolder(String id, {bool deleteNotes = false}) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    await isar.writeTxn(() async {
      if (deleteNotes) {
        // 폴더 내 모든 메모 삭제
        await entity.notes.load();
        for (final note in entity.notes) {
          await isar.noteEntitys.delete(note.id);
        }
      } else {
        // 폴더 내 메모들의 폴더 연결 해제
        await entity.notes.load();
        for (final note in entity.notes) {
          note.folder.value = null;
          await note.folder.save();
        }
      }

      // 하위 폴더들의 부모 ID를 현재 폴더의 부모로 변경 (한 레벨 위로 이동)
      final subFolders = await isar.folderEntitys
          .filter()
          .parentIdEqualTo(id)
          .findAll();

      for (final subFolder in subFolders) {
        subFolder.parentId = entity.parentId;
        await isar.folderEntitys.put(subFolder);
      }

      await isar.folderEntitys.delete(entity.id);
    });
  }

  /// 폴더 이동 (부모 폴더 변경)
  Future<void> moveFolder(String folderId, String? newParentId) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(folderId)
        .findFirst();

    if (entity == null) return;

    // 순환 참조 방지: newParentId가 현재 폴더의 하위 폴더인지 확인
    if (newParentId != null) {
      final isDescendant = await _isDescendant(isar, folderId, newParentId);
      if (isDescendant) {
        throw Exception('Cannot move folder to its own descendant');
      }

      // 깊이 제한 확인 (최대 3레벨)
      final depth = await _getFolderDepth(isar, newParentId);
      if (depth >= 2) {
        throw Exception('Maximum folder depth (3 levels) exceeded');
      }
    }

    entity.parentId = newParentId;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(entity);
    });
  }

  /// 폴더 이름 변경
  Future<void> renameFolder(String id, String newName) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.name = newName;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(entity);
    });
  }

  /// 폴더 순서 변경
  Future<void> reorderFolders(List<String> folderIds) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      for (int i = 0; i < folderIds.length; i++) {
        final entity = await isar.folderEntitys
            .filter()
            .uuidEqualTo(folderIds[i])
            .findFirst();

        if (entity != null) {
          entity.order = i;
          entity.updatedAt = DateTime.now();
          await isar.folderEntitys.put(entity);
        }
      }
    });
  }

  /// 폴더 내 메모 개수 조회
  Future<int> getNoteCountInFolder(String folderId) async {
    final isar = await IsarDatabase.getInstance();
    final folderEntity = await isar.folderEntitys
        .filter()
        .uuidEqualTo(folderId)
        .findFirst();

    if (folderEntity == null) return 0;

    await folderEntity.notes.load();

    // 삭제되지 않은 메모만 카운트
    return folderEntity.notes.where((note) => !note.isDeleted).length;
  }

  /// 폴더 경로 조회 (부모 폴더들의 체인)
  Future<List<Folder>> getFolderPath(String folderId) async {
    final isar = await IsarDatabase.getInstance();
    final path = <Folder>[];

    String? currentId = folderId;
    while (currentId != null) {
      final entity = await isar.folderEntitys
          .filter()
          .uuidEqualTo(currentId)
          .findFirst();

      if (entity == null) break;

      path.insert(0, _mapToFolder(entity));
      currentId = entity.parentId;
    }

    return path;
  }

  /// 폴더 개수 조회
  Future<int> getFolderCount() async {
    final isar = await IsarDatabase.getInstance();
    return await isar.folderEntitys.count();
  }

  /// 하위 폴더 여부 확인 (순환 참조 방지용)
  Future<bool> _isDescendant(
    Isar isar,
    String ancestorId,
    String descendantId,
  ) async {
    String? currentId = descendantId;

    while (currentId != null) {
      if (currentId == ancestorId) return true;

      final entity = await isar.folderEntitys
          .filter()
          .uuidEqualTo(currentId)
          .findFirst();

      if (entity == null) break;
      currentId = entity.parentId;
    }

    return false;
  }

  /// 폴더 깊이 계산
  Future<int> _getFolderDepth(Isar isar, String folderId) async {
    int depth = 0;
    String? currentId = folderId;

    while (currentId != null) {
      final entity = await isar.folderEntitys
          .filter()
          .uuidEqualTo(currentId)
          .findFirst();

      if (entity == null) break;

      depth++;
      currentId = entity.parentId;
    }

    return depth;
  }

  /// Entity → Folder 변환
  Folder _mapToFolder(FolderEntity entity) {
    return Folder(
      id: entity.uuid,
      name: entity.name,
      color: entity.color,
      icon: entity.icon,
      parentId: entity.parentId,
      order: entity.order,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
