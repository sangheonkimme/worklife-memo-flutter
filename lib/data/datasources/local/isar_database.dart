import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'entities/note_entity.dart';
import 'entities/folder_entity.dart';
import 'entities/tag_entity.dart';
import 'entities/checklist_item_entity.dart';

/// Isar 데이터베이스 관리 클래스
class IsarDatabase {
  static Isar? _instance;

  /// 데이터베이스 인스턴스 가져오기 (싱글톤)
  static Future<Isar> getInstance() async {
    if (_instance != null) {
      return _instance!;
    }

    final dir = await getApplicationDocumentsDirectory();

    _instance = await Isar.open(
      [
        NoteEntitySchema,
        FolderEntitySchema,
        TagEntitySchema,
        ChecklistItemEntitySchema,
      ],
      directory: dir.path,
      name: 'worklife_memo_db',
      inspector: true, // Isar Inspector 활성화 (개발용)
    );

    return _instance!;
  }

  /// 데이터베이스 닫기
  static Future<void> close() async {
    await _instance?.close();
    _instance = null;
  }

  /// 데이터베이스 초기화 (모든 데이터 삭제)
  static Future<void> clear() async {
    final isar = await getInstance();
    await isar.writeTxn(() async {
      await isar.clear();
    });
  }

  /// 특정 컬렉션 삭제
  static Future<void> clearCollection<T>() async {
    final isar = await getInstance();
    await isar.writeTxn(() async {
      await isar.collection<T>().clear();
    });
  }
}
