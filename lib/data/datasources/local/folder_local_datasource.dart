import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../domain/entities/folder.dart' as domain;
import 'drift/app_database.dart';

/// 폴더 Local Data Source
class FolderLocalDataSource {
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  FolderLocalDataSource(this._database);

  /// 폴더 생성
  Future<domain.Folder> createFolder(domain.Folder folder) async {
    final uuid = _uuid.v4();
    final now = DateTime.now();

    final id = await _database.insertFolder(
      FoldersCompanion.insert(
        uuid: uuid,
        name: folder.name,
        createdAt: now,
        updatedAt: now,
        parentId: Value(folder.parentId),
        order: Value(folder.order),
        color: Value(folder.color),
        icon: Value(folder.icon),
      ),
    );

    final created = await (_database.select(_database.folders)
          ..where((f) => f.id.equals(id)))
        .getSingle();
    return _mapToFolder(created);
  }

  /// 폴더 조회 (단일)
  Future<domain.Folder?> getFolderById(String id) async {
    final entity = await _database.getFolderByUuid(id);
    if (entity == null) return null;
    return _mapToFolder(entity);
  }

  /// 모든 폴더 조회
  Future<List<domain.Folder>> getAllFolders() async {
    final entities = await (_database.select(_database.folders)
          ..orderBy([(f) => OrderingTerm.asc(f.order)]))
        .get();
    return entities.map(_mapToFolder).toList();
  }

  /// 루트 폴더 조회
  Future<List<domain.Folder>> getRootFolders() async {
    final entities = await (_database.select(_database.folders)
          ..where((f) => f.parentId.isNull())
          ..orderBy([(f) => OrderingTerm.asc(f.order)]))
        .get();
    return entities.map(_mapToFolder).toList();
  }

  /// 하위 폴더 조회
  Future<List<domain.Folder>> getSubFolders(String parentId) async {
    final entities = await (_database.select(_database.folders)
          ..where((f) => f.parentId.equals(parentId))
          ..orderBy([(f) => OrderingTerm.asc(f.order)]))
        .get();
    return entities.map(_mapToFolder).toList();
  }

  /// 폴더 트리 조회 (계층 구조)
  Future<Map<String, List<domain.Folder>>> getFolderTree() async {
    final allFolders = await (_database.select(_database.folders)
          ..orderBy([(f) => OrderingTerm.asc(f.order)]))
        .get();

    final tree = <String, List<domain.Folder>>{};

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
  Future<domain.Folder> updateFolder(domain.Folder folder) async {
    final entity = await _database.getFolderByUuid(folder.id);
    if (entity == null) {
      throw Exception('Folder not found: ${folder.id}');
    }

    await _database.updateFolder(entity.copyWith(
      name: folder.name,
      color: Value(folder.color),
      icon: Value(folder.icon),
      parentId: Value(folder.parentId),
      order: folder.order,
      updatedAt: DateTime.now(),
    ));

    final updated = await _database.getFolderByUuid(folder.id);
    return _mapToFolder(updated!);
  }

  /// 폴더 삭제
  Future<void> deleteFolder(String id, {bool deleteNotes = false}) async {
    final entity = await _database.getFolderByUuid(id);
    if (entity == null) return;

    await _database.transaction(() async {
      if (deleteNotes) {
        // 폴더 내 모든 메모 삭제
        final notes = await (_database.select(_database.notes)
              ..where((n) => n.folderId.equals(entity.id)))
            .get();
        for (final note in notes) {
          await _database.deleteNote(note.id);
        }
      } else {
        // 폴더 내 메모들의 폴더 연결 해제
        final notes = await (_database.select(_database.notes)
              ..where((n) => n.folderId.equals(entity.id)))
            .get();
        for (final note in notes) {
          await _database.updateNote(note.copyWith(
            folderId: const Value(null),
          ));
        }
      }

      // 하위 폴더들의 부모 ID를 현재 폴더의 부모로 변경 (한 레벨 위로 이동)
      final subFolders = await (_database.select(_database.folders)
            ..where((f) => f.parentId.equals(entity.uuid)))
          .get();

      for (final subFolder in subFolders) {
        await _database.updateFolder(subFolder.copyWith(
          parentId: Value(entity.parentId),
        ));
      }

      await _database.deleteFolder(entity.id);
    });
  }

  /// 폴더 이동 (부모 폴더 변경)
  Future<void> moveFolder(String folderId, String? newParentId) async {
    final entity = await _database.getFolderByUuid(folderId);
    if (entity == null) return;

    // 순환 참조 방지: newParentId가 현재 폴더의 하위 폴더인지 확인
    if (newParentId != null) {
      final isDescendant = await _isDescendant(folderId, newParentId);
      if (isDescendant) {
        throw Exception('Cannot move folder to its own descendant');
      }

      // 깊이 제한 확인 (최대 3레벨)
      final depth = await _getFolderDepth(newParentId);
      if (depth >= 2) {
        throw Exception('Maximum folder depth (3 levels) exceeded');
      }
    }

    await _database.updateFolder(entity.copyWith(
      parentId: Value(newParentId),
      updatedAt: DateTime.now(),
    ));
  }

  /// 폴더 이름 변경
  Future<void> renameFolder(String id, String newName) async {
    final entity = await _database.getFolderByUuid(id);
    if (entity == null) return;

    await _database.updateFolder(entity.copyWith(
      name: newName,
      updatedAt: DateTime.now(),
    ));
  }

  /// 폴더 순서 변경
  Future<void> reorderFolders(List<String> folderIds) async {
    await _database.transaction(() async {
      for (int i = 0; i < folderIds.length; i++) {
        final entity = await _database.getFolderByUuid(folderIds[i]);
        if (entity != null) {
          await _database.updateFolder(entity.copyWith(
            order: i,
            updatedAt: DateTime.now(),
          ));
        }
      }
    });
  }

  /// 폴더 내 메모 개수 조회
  Future<int> getNoteCountInFolder(String folderId) async {
    final folderEntity = await _database.getFolderByUuid(folderId);
    if (folderEntity == null) return 0;

    final count = await (_database.selectOnly(_database.notes)
          ..addColumns([_database.notes.id.count()])
          ..where(_database.notes.folderId.equals(folderEntity.id) &
              _database.notes.isDeleted.equals(false)))
        .getSingle();

    return count.read(_database.notes.id.count()) ?? 0;
  }

  /// 폴더 경로 조회 (부모 폴더들의 체인)
  Future<List<domain.Folder>> getFolderPath(String folderId) async {
    final path = <domain.Folder>[];
    String? currentId = folderId;

    while (currentId != null) {
      final entity = await _database.getFolderByUuid(currentId);
      if (entity == null) break;

      path.insert(0, _mapToFolder(entity));
      currentId = entity.parentId;
    }

    return path;
  }

  /// 폴더 개수 조회
  Future<int> getFolderCount() async {
    final count = await (_database.selectOnly(_database.folders)
          ..addColumns([_database.folders.id.count()]))
        .getSingle();
    return count.read(_database.folders.id.count()) ?? 0;
  }

  /// 하위 폴더 여부 확인 (순환 참조 방지용)
  Future<bool> _isDescendant(String ancestorId, String descendantId) async {
    String? currentId = descendantId;

    while (currentId != null) {
      if (currentId == ancestorId) return true;

      final entity = await _database.getFolderByUuid(currentId);
      if (entity == null) break;
      currentId = entity.parentId;
    }

    return false;
  }

  /// 폴더 깊이 계산
  Future<int> _getFolderDepth(String folderId) async {
    int depth = 0;
    String? currentId = folderId;

    while (currentId != null) {
      final entity = await _database.getFolderByUuid(currentId);
      if (entity == null) break;

      depth++;
      currentId = entity.parentId;
    }

    return depth;
  }

  /// Entity → Folder 변환
  domain.Folder _mapToFolder(Folder entity) {
    return domain.Folder(
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
