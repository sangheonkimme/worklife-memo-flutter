import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/note/create_note.dart';
import '../../domain/usecases/note/update_note.dart';
import '../../domain/usecases/note/delete_note.dart';
import '../../domain/usecases/note/get_notes.dart';
import '../../domain/usecases/note/get_note_by_id.dart';
import '../../domain/usecases/note/pin_note.dart';
import '../../domain/usecases/note/archive_note.dart';
import 'note_repository_provider.dart';

part 'note_provider.g.dart';

/// 메모 목록 상태 Provider (AsyncNotifier)
///
/// 활성 메모 목록을 관리하고 CRUD 작업을 수행합니다.
@riverpod
class NoteList extends _$NoteList {
  late final GetActiveNotes _getActiveNotes;
  late final CreateNote _createNote;
  late final UpdateNote _updateNote;
  late final DeleteNote _deleteNote;
  late final PinNote _pinNote;
  late final ArchiveNote _archiveNote;

  @override
  Future<List<Note>> build() async {
    // UseCase 초기화
    final repository = ref.watch(noteRepositoryProvider);
    _getActiveNotes = GetActiveNotes(repository);
    _createNote = CreateNote(repository);
    _updateNote = UpdateNote(repository);
    _deleteNote = DeleteNote(repository);
    _pinNote = PinNote(repository);
    _archiveNote = ArchiveNote(repository);

    // 활성 메모 목록 로드
    return await _getActiveNotes();
  }

  /// 메모 목록 새로고침
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _getActiveNotes();
    });
  }

  /// 메모 생성
  Future<void> createNote(Note note) async {
    try {
      await _createNote(note);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 메모 업데이트
  Future<void> updateNote(Note note) async {
    try {
      await _updateNote(note);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 메모 삭제 (휴지통으로 이동)
  Future<void> deleteNote(String noteId) async {
    try {
      await _deleteNote(noteId);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 메모 고정/고정 해제
  Future<void> togglePin(String noteId) async {
    try {
      await _pinNote(noteId);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  /// 메모 보관/보관 해제
  Future<void> toggleArchive(String noteId) async {
    try {
      await _archiveNote(noteId);
      await refresh();
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

/// 고정된 메모 목록 Provider
@riverpod
Future<List<Note>> pinnedNotes(PinnedNotesRef ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getPinnedNotes = GetPinnedNotes(repository);
  return await getPinnedNotes();
}

/// 즐겨찾기 메모 목록 Provider
@riverpod
Future<List<Note>> favoriteNotes(FavoriteNotesRef ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getFavoriteNotes = GetFavoriteNotes(repository);
  return await getFavoriteNotes();
}

/// 보관된 메모 목록 Provider
@riverpod
Future<List<Note>> archivedNotes(ArchivedNotesRef ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getArchivedNotes = GetArchivedNotes(repository);
  return await getArchivedNotes();
}

/// 삭제된 메모 목록 Provider (휴지통)
@riverpod
Future<List<Note>> deletedNotes(DeletedNotesRef ref) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getDeletedNotes = GetDeletedNotes(repository);
  return await getDeletedNotes();
}

/// 단일 메모 조회 Provider
@riverpod
Future<Note?> note(NoteRef ref, String noteId) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getNoteById = GetNoteById(repository);
  return await getNoteById(noteId);
}

/// 최근 메모 목록 Provider
@riverpod
Future<List<Note>> recentNotes(RecentNotesRef ref, {int limit = 10}) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getRecentNotes = GetRecentNotes(repository);
  return await getRecentNotes(limit: limit);
}

/// 폴더별 메모 목록 Provider
@riverpod
Future<List<Note>> notesByFolder(NotesByFolderRef ref, String folderId) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getNotesByFolder = GetNotesByFolder(repository);
  return await getNotesByFolder(folderId);
}

/// 태그별 메모 목록 Provider
@riverpod
Future<List<Note>> notesByTag(NotesByTagRef ref, String tagId) async {
  final repository = ref.watch(noteRepositoryProvider);
  final getNotesByTag = GetNotesByTag(repository);
  return await getNotesByTag(tagId);
}

/// 메모 검색 Provider
@riverpod
Future<List<Note>> searchNotes(SearchNotesRef ref, String query) async {
  final repository = ref.watch(noteRepositoryProvider);
  final searchNotesUseCase = SearchNotes(repository);
  return await searchNotesUseCase(query);
}
