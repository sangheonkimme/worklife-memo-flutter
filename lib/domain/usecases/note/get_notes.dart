import '../../entities/note.dart';
import '../../repositories/note_repository.dart';

/// 메모 목록 조회 UseCase
class GetNotes {
  final NoteRepository _repository;

  GetNotes(this._repository);

  /// 모든 메모 조회
  Future<List<Note>> call() async {
    return await _repository.getAllNotes();
  }
}

/// 활성 메모 조회 UseCase
class GetActiveNotes {
  final NoteRepository _repository;

  GetActiveNotes(this._repository);

  /// 활성 메모 조회 (삭제되지 않고 보관되지 않은 메모)
  Future<List<Note>> call() async {
    return await _repository.getActiveNotes();
  }
}

/// 고정된 메모 조회 UseCase
class GetPinnedNotes {
  final NoteRepository _repository;

  GetPinnedNotes(this._repository);

  /// 고정된 메모 조회
  Future<List<Note>> call() async {
    return await _repository.getPinnedNotes();
  }
}

/// 즐겨찾기 메모 조회 UseCase
class GetFavoriteNotes {
  final NoteRepository _repository;

  GetFavoriteNotes(this._repository);

  /// 즐겨찾기 메모 조회
  Future<List<Note>> call() async {
    return await _repository.getFavoriteNotes();
  }
}

/// 보관된 메모 조회 UseCase
class GetArchivedNotes {
  final NoteRepository _repository;

  GetArchivedNotes(this._repository);

  /// 보관된 메모 조회
  Future<List<Note>> call() async {
    return await _repository.getArchivedNotes();
  }
}

/// 삭제된 메모 조회 UseCase (휴지통)
class GetDeletedNotes {
  final NoteRepository _repository;

  GetDeletedNotes(this._repository);

  /// 삭제된 메모 조회 (휴지통)
  Future<List<Note>> call() async {
    return await _repository.getDeletedNotes();
  }
}

/// 최근 메모 조회 UseCase
class GetRecentNotes {
  final NoteRepository _repository;

  GetRecentNotes(this._repository);

  /// 최근 메모 조회
  ///
  /// [limit] 조회할 메모 개수 (기본 10개)
  Future<List<Note>> call({int limit = 10}) async {
    return await _repository.getRecentNotes(limit: limit);
  }
}

/// 폴더별 메모 조회 UseCase
class GetNotesByFolder {
  final NoteRepository _repository;

  GetNotesByFolder(this._repository);

  /// 폴더별 메모 조회
  ///
  /// [folderId] 폴더 ID
  Future<List<Note>> call(String folderId) async {
    return await _repository.getNotesByFolder(folderId);
  }
}

/// 태그별 메모 조회 UseCase
class GetNotesByTag {
  final NoteRepository _repository;

  GetNotesByTag(this._repository);

  /// 태그별 메모 조회
  ///
  /// [tagId] 태그 ID
  Future<List<Note>> call(String tagId) async {
    return await _repository.getNotesByTag(tagId);
  }
}

/// 메모 검색 UseCase
class SearchNotes {
  final NoteRepository _repository;

  SearchNotes(this._repository);

  /// 메모 검색 (제목 + 내용)
  ///
  /// [query] 검색 쿼리
  Future<List<Note>> call(String query) async {
    return await _repository.searchNotes(query);
  }
}
