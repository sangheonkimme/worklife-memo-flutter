import 'package:drift/drift.dart';

/// 메모 타입 enum
enum NoteType {
  richText,  // 리치 텍스트
  markdown,  // 마크다운
  checklist, // 체크리스트
}

/// 폴더 테이블
class Folders extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().unique()();

  TextColumn get name => text()();

  // 부모 폴더 ID (null이면 루트 폴더)
  TextColumn get parentId => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  // 정렬 순서
  IntColumn get order => integer().withDefault(const Constant(0))();

  // 폴더 색상 (옵션)
  TextColumn get color => text().nullable()();

  // 아이콘 (옵션)
  TextColumn get icon => text().nullable()();
}

/// 태그 테이블
class Tags extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().unique()();

  TextColumn get name => text()();

  // 태그 색상 (HEX 코드)
  TextColumn get color => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  // 사용 횟수 (인기 태그 표시용)
  IntColumn get useCount => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {name}, // name을 unique constraint로 설정
  ];
}

/// 메모 테이블
class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().unique()();

  TextColumn get title => text()();

  TextColumn get content => text()();

  // NoteType enum을 int로 저장
  IntColumn get type => intEnum<NoteType>()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  BoolColumn get isPinned => boolean().withDefault(const Constant(false))();

  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();

  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();

  // 정렬 순서 (고정된 메모의 경우 사용)
  IntColumn get order => integer().nullable()();

  // 관계: 폴더 (N:1)
  IntColumn get folderId => integer().nullable().references(Folders, #id)();
}

/// 체크리스트 항목 테이블
class ChecklistItems extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get uuid => text().unique()();

  // 소속 메모 ID
  IntColumn get noteId => integer().references(Notes, #id, onDelete: KeyAction.cascade)();

  // 항목 텍스트
  TextColumn get itemText => text()();

  // 완료 여부
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();

  // 정렬 순서
  IntColumn get order => integer()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}

/// 메모-태그 연결 테이블 (N:N 관계)
@DataClassName('NoteTagLink')
class NoteTags extends Table {
  IntColumn get noteId => integer().references(Notes, #id, onDelete: KeyAction.cascade)();

  IntColumn get tagId => integer().references(Tags, #id, onDelete: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {noteId, tagId};
}
