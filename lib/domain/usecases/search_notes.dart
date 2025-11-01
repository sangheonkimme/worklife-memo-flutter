import '../entities/note.dart';
import '../repositories/note_repository.dart';

/// 메모 검색 UseCase
class SearchNotes {
  final NoteRepository repository;

  SearchNotes(this.repository);

  /// 검색 쿼리로 메모 검색
  ///
  /// [query]: 검색어 (제목 및 내용에서 검색)
  Future<List<Note>> call(String query) async {
    if (query.trim().isEmpty) {
      return [];
    }
    return await repository.searchNotes(query);
  }
}
