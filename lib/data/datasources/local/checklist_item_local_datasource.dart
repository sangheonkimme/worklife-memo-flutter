import 'package:uuid/uuid.dart';
import '../../../domain/entities/checklist_item.dart';
import 'isar_database.dart';
import 'entities/checklist_item_entity.dart';
import 'package:isar/isar.dart';

/// 체크리스트 항목 Local Data Source
class ChecklistItemLocalDataSource {
  final Uuid _uuid = const Uuid();

  /// 체크리스트 항목 생성
  Future<ChecklistItem> createChecklistItem(ChecklistItem item) async {
    final isar = await IsarDatabase.getInstance();
    final uuid = _uuid.v4();

    final entity = ChecklistItemEntity.create(
      uuid: uuid,
      noteId: item.noteId,
      text: item.text,
      order: item.order,
    );

    await isar.writeTxn(() async {
      await isar.checklistItemEntitys.put(entity);
    });

    return _mapToChecklistItem(entity);
  }

  /// 체크리스트 항목 조회 (단일)
  Future<ChecklistItem?> getChecklistItemById(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.checklistItemEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    return entity != null ? _mapToChecklistItem(entity) : null;
  }

  /// 메모의 모든 체크리스트 항목 조회
  Future<List<ChecklistItem>> getChecklistItemsByNoteId(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .sortByOrder()
        .findAll();

    return entities.map(_mapToChecklistItem).toList();
  }

  /// 완료된 체크리스트 항목 조회
  Future<List<ChecklistItem>> getCompletedItems(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .and()
        .isCompletedEqualTo(true)
        .sortByOrder()
        .findAll();

    return entities.map(_mapToChecklistItem).toList();
  }

  /// 미완료 체크리스트 항목 조회
  Future<List<ChecklistItem>> getIncompleteItems(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .and()
        .isCompletedEqualTo(false)
        .sortByOrder()
        .findAll();

    return entities.map(_mapToChecklistItem).toList();
  }

  /// 체크리스트 항목 업데이트
  Future<ChecklistItem> updateChecklistItem(ChecklistItem item) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.checklistItemEntitys
        .filter()
        .uuidEqualTo(item.id)
        .findFirst();

    if (entity == null) {
      throw Exception('ChecklistItem not found: ${item.id}');
    }

    entity.text = item.text;
    entity.isCompleted = item.isCompleted;
    entity.order = item.order;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.checklistItemEntitys.put(entity);
    });

    return _mapToChecklistItem(entity);
  }

  /// 체크리스트 항목 삭제
  Future<void> deleteChecklistItem(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.checklistItemEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    await isar.writeTxn(() async {
      await isar.checklistItemEntitys.delete(entity.id);
    });
  }

  /// 메모의 모든 체크리스트 항목 삭제
  Future<void> deleteAllChecklistItems(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    final entities = await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .findAll();

    await isar.writeTxn(() async {
      for (final entity in entities) {
        await isar.checklistItemEntitys.delete(entity.id);
      }
    });
  }

  /// 체크리스트 항목 완료 토글
  Future<void> toggleChecklistItem(String id) async {
    final isar = await IsarDatabase.getInstance();
    final entity = await isar.checklistItemEntitys
        .filter()
        .uuidEqualTo(id)
        .findFirst();

    if (entity == null) return;

    entity.isCompleted = !entity.isCompleted;
    entity.updatedAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.checklistItemEntitys.put(entity);
    });
  }

  /// 체크리스트 항목 순서 변경
  Future<void> reorderChecklistItems(List<String> itemIds) async {
    final isar = await IsarDatabase.getInstance();

    await isar.writeTxn(() async {
      for (int i = 0; i < itemIds.length; i++) {
        final entity = await isar.checklistItemEntitys
            .filter()
            .uuidEqualTo(itemIds[i])
            .findFirst();

        if (entity != null) {
          entity.order = i;
          entity.updatedAt = DateTime.now();
          await isar.checklistItemEntitys.put(entity);
        }
      }
    });
  }

  /// 완료된 항목 개수 조회
  Future<int> getCompletedCount(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    return await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .and()
        .isCompletedEqualTo(true)
        .count();
  }

  /// 전체 항목 개수 조회
  Future<int> getTotalCount(String noteId) async {
    final isar = await IsarDatabase.getInstance();
    return await isar.checklistItemEntitys
        .filter()
        .noteIdEqualTo(noteId)
        .count();
  }

  /// 완료율 조회
  Future<double> getCompletionRate(String noteId) async {
    final total = await getTotalCount(noteId);
    if (total == 0) return 0.0;

    final completed = await getCompletedCount(noteId);
    return completed / total;
  }

  /// Entity → ChecklistItem 변환
  ChecklistItem _mapToChecklistItem(ChecklistItemEntity entity) {
    return ChecklistItem(
      id: entity.uuid,
      noteId: entity.noteId,
      text: entity.text,
      isCompleted: entity.isCompleted,
      order: entity.order,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
