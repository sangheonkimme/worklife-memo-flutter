import '../entities/note.dart';
import '../entities/folder.dart';
import '../entities/tag.dart';

/// 메모 Repository Interface
abstract class NoteRepository {
  /// 메모 생성
  Future<Note> createNote(Note note);

  /// 메모 조회 (단일)
  Future<Note?> getNoteById(String id);

  /// 모든 메모 조회
  Future<List<Note>> getAllNotes();

  /// 활성 메모 조회 (삭제되지 않고 보관되지 않은 메모)
  Future<List<Note>> getActiveNotes();

  /// 고정된 메모 조회
  Future<List<Note>> getPinnedNotes();

  /// 보관된 메모 조회
  Future<List<Note>> getArchivedNotes();

  /// 삭제된 메모 조회 (휴지통)
  Future<List<Note>> getDeletedNotes();

  /// 즐겨찾기 메모 조회
  Future<List<Note>> getFavoriteNotes();

  /// 폴더별 메모 조회
  Future<List<Note>> getNotesByFolder(String folderId);

  /// 태그별 메모 조회
  Future<List<Note>> getNotesByTag(String tagId);

  /// 메모 검색 (제목 + 내용)
  Future<List<Note>> searchNotes(String query);

  /// 메모 업데이트
  Future<Note> updateNote(Note note);

  /// 메모 삭제 (휴지통으로 이동)
  Future<void> deleteNote(String id);

  /// 메모 영구 삭제
  Future<void> permanentlyDeleteNote(String id);

  /// 메모 복원
  Future<void> restoreNote(String id);

  /// 메모 고정/고정 해제
  Future<void> togglePinNote(String id);

  /// 메모 보관/보관 해제
  Future<void> toggleArchiveNote(String id);

  /// 메모 즐겨찾기 토글
  Future<void> toggleFavoriteNote(String id);

  /// 메모에 폴더 설정
  Future<void> setNoteFolder(String noteId, String? folderId);

  /// 메모에 태그 추가
  Future<void> addTagToNote(String noteId, String tagId);

  /// 메모에서 태그 제거
  Future<void> removeTagFromNote(String noteId, String tagId);

  /// 메모의 모든 태그 설정
  Future<void> setNoteTags(String noteId, List<String> tagIds);

  /// 최근 메모 조회 (N개)
  Future<List<Note>> getRecentNotes({int limit = 10});

  /// 메모 개수 조회
  Future<int> getNoteCount();

  /// 활성 메모 개수
  Future<int> getActiveNoteCount();

  /// 오늘 생성된 메모 조회
  Future<List<Note>> getTodayNotes();

  /// 이번 주 생성된 메모 조회
  Future<List<Note>> getThisWeekNotes();

  /// 이번 달 생성된 메모 조회
  Future<List<Note>> getThisMonthNotes();
}
