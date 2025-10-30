import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

/// 태그 검색 UseCase (자동완성용)
class SearchTags {
  final TagRepository repository;

  SearchTags(this.repository);

  /// 쿼리로 태그를 검색합니다.
  ///
  /// 자동완성에 사용됩니다.
  Future<List<Tag>> call(String query) async {
    if (query.trim().isEmpty) {
      // 빈 쿼리면 인기 태그 반환
      return await repository.getPopularTags(limit: 10);
    }

    return await repository.searchTags(query);
  }
}
