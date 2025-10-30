import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

/// ID로 태그 조회 UseCase
class GetTagById {
  final TagRepository repository;

  GetTagById(this.repository);

  /// ID로 태그를 조회합니다.
  Future<Tag?> call(String id) async {
    return await repository.getTagById(id);
  }

  /// 이름으로 태그를 조회합니다.
  Future<Tag?> getByName(String name) async {
    return await repository.getTagByName(name);
  }

  /// 태그가 사용된 메모 개수 조회
  Future<int> getNoteCountWithTag(String tagId) async {
    return await repository.getNoteCountWithTag(tagId);
  }
}
