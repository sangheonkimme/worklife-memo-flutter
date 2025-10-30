import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

/// 태그 조회 UseCase
class GetTags {
  final TagRepository repository;

  GetTags(this.repository);

  /// 모든 태그 조회
  Future<List<Tag>> call() async {
    return await repository.getAllTags();
  }

  /// 인기 태그 조회 (사용 횟수 기준)
  Future<List<Tag>> getPopularTags({int limit = 10}) async {
    return await repository.getPopularTags(limit: limit);
  }

  /// 최근 사용한 태그 조회
  Future<List<Tag>> getRecentTags({int limit = 10}) async {
    return await repository.getRecentTags(limit: limit);
  }

  /// 사용되지 않는 태그 조회
  Future<List<Tag>> getUnusedTags() async {
    return await repository.getUnusedTags();
  }

  /// 태그 개수 조회
  Future<int> getTagCount() async {
    return await repository.getTagCount();
  }
}
