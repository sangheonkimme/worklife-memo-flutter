import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../domain/entities/checklist_item.dart' as domain;
import 'drift/app_database.dart';

/// 체크리스트 항목 Local Data Source
class ChecklistItemLocalDataSource {
  final AppDatabase _database;
  final Uuid _uuid = const Uuid();

  ChecklistItemLocalDataSource(this._database);

  /// 체크리스트 항목 생성
  Future<domain.ChecklistItem> createChecklistItem(
      domain.ChecklistItem item) async {
    final uuid = _uuid.v4();
    final now = DateTime.now();

    // noteId(uuid)로 Note의 DB ID 조회
    final note = await _database.getNoteByUuid(item.noteId);
    if (note == null) {
      throw Exception('Note not found: ${item.noteId}');
    }

    final id = await _database.insertChecklistItem(
      ChecklistItemsCompanion.insert(
        uuid: uuid,
        noteId: note.id,
        itemText: item.text,
        order: item.order,
        createdAt: now,
        updatedAt: now,
      ),
    );

    final created = await (_database.select(_database.checklistItems)
          ..where((c) => c.id.equals(id)))
        .getSingle();
    return _mapToChecklistItem(created, item.noteId);
  }

  /// 체크리스트 항목 조회 (단일)
  Future<domain.ChecklistItem?> getChecklistItemById(String id) async {
    final entity = await (_database.select(_database.checklistItems)
          ..where((c) => c.uuid.equals(id)))
        .getSingleOrNull();

    if (entity == null) return null;

    // noteId 조회
    final note = await (_database.select(_database.notes)
          ..where((n) => n.id.equals(entity.noteId)))
        .getSingleOrNull();

    return note != null ? _mapToChecklistItem(entity, note.uuid) : null;
  }

  /// 메모의 모든 체크리스트 항목 조회
  Future<List<domain.ChecklistItem>> getChecklistItemsByNoteId(
      String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return [];

    final entities = await _database.getChecklistItemsByNoteId(note.id);
    return entities.map((e) => _mapToChecklistItem(e, noteUuid)).toList();
  }

  /// 완료된 체크리스트 항목 조회
  Future<List<domain.ChecklistItem>> getCompletedItems(String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return [];

    final entities = await (_database.select(_database.checklistItems)
          ..where((c) => c.noteId.equals(note.id) & c.isCompleted.equals(true))
          ..orderBy([(c) => OrderingTerm.asc(c.order)]))
        .get();

    return entities.map((e) => _mapToChecklistItem(e, noteUuid)).toList();
  }

  /// 미완료 체크리스트 항목 조회
  Future<List<domain.ChecklistItem>> getIncompleteItems(
      String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return [];

    final entities = await (_database.select(_database.checklistItems)
          ..where((c) =>
              c.noteId.equals(note.id) & c.isCompleted.equals(false))
          ..orderBy([(c) => OrderingTerm.asc(c.order)]))
        .get();

    return entities.map((e) => _mapToChecklistItem(e, noteUuid)).toList();
  }

  /// 체크리스트 항목 업데이트
  Future<domain.ChecklistItem> updateChecklistItem(
      domain.ChecklistItem item) async {
    final entity = await (_database.select(_database.checklistItems)
          ..where((c) => c.uuid.equals(item.id)))
        .getSingleOrNull();

    if (entity == null) {
      throw Exception('ChecklistItem not found: ${item.id}');
    }

    await _database.updateChecklistItem(entity.copyWith(
      itemText: item.text,
      isCompleted: item.isCompleted,
      order: item.order,
      updatedAt: DateTime.now(),
    ));

    final updated = await (_database.select(_database.checklistItems)
          ..where((c) => c.uuid.equals(item.id)))
        .getSingle();

    return _mapToChecklistItem(updated, item.noteId);
  }

  /// 체크리스트 항목 삭제
  Future<void> deleteChecklistItem(String id) async {
    final entity = await (_database.select(_database.checklistItems)
          ..where((c) => c.uuid.equals(id)))
        .getSingleOrNull();

    if (entity == null) return;

    await _database.deleteChecklistItem(entity.id);
  }

  /// 메모의 모든 체크리스트 항목 삭제
  Future<void> deleteAllChecklistItems(String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return;

    final entities = await (_database.select(_database.checklistItems)
          ..where((c) => c.noteId.equals(note.id)))
        .get();

    await _database.transaction(() async {
      for (final entity in entities) {
        await _database.deleteChecklistItem(entity.id);
      }
    });
  }

  /// 체크리스트 항목 완료 토글
  Future<void> toggleChecklistItem(String id) async {
    final entity = await (_database.select(_database.checklistItems)
          ..where((c) => c.uuid.equals(id)))
        .getSingleOrNull();

    if (entity == null) return;

    await _database.updateChecklistItem(entity.copyWith(
      isCompleted: !entity.isCompleted,
      updatedAt: DateTime.now(),
    ));
  }

  /// 체크리스트 항목 순서 변경
  Future<void> reorderChecklistItems(List<String> itemIds) async {
    await _database.transaction(() async {
      for (int i = 0; i < itemIds.length; i++) {
        final entity = await (_database.select(_database.checklistItems)
              ..where((c) => c.uuid.equals(itemIds[i])))
            .getSingleOrNull();

        if (entity != null) {
          await _database.updateChecklistItem(entity.copyWith(
            order: i,
            updatedAt: DateTime.now(),
          ));
        }
      }
    });
  }

  /// 완료된 항목 개수 조회
  Future<int> getCompletedCount(String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return 0;

    final count = await (_database.selectOnly(_database.checklistItems)
          ..addColumns([_database.checklistItems.id.count()])
          ..where(_database.checklistItems.noteId.equals(note.id) &
              _database.checklistItems.isCompleted.equals(true)))
        .getSingle();

    return count.read(_database.checklistItems.id.count()) ?? 0;
  }

  /// 전체 항목 개수 조회
  Future<int> getTotalCount(String noteUuid) async {
    final note = await _database.getNoteByUuid(noteUuid);
    if (note == null) return 0;

    final count = await (_database.selectOnly(_database.checklistItems)
          ..addColumns([_database.checklistItems.id.count()])
          ..where(_database.checklistItems.noteId.equals(note.id)))
        .getSingle();

    return count.read(_database.checklistItems.id.count()) ?? 0;
  }

  /// 완료율 조회
  Future<double> getCompletionRate(String noteUuid) async {
    final total = await getTotalCount(noteUuid);
    if (total == 0) return 0.0;

    final completed = await getCompletedCount(noteUuid);
    return completed / total;
  }

  /// Entity → ChecklistItem 변환
  domain.ChecklistItem _mapToChecklistItem(
      ChecklistItem entity, String noteUuid) {
    return domain.ChecklistItem(
      id: entity.uuid,
      noteId: noteUuid,
      text: entity.itemText,
      isCompleted: entity.isCompleted,
      order: entity.order,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
