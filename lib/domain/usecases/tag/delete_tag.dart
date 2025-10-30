import '../../repositories/tag_repository.dart';

/// 태그 삭제 UseCase
class DeleteTag {
  final TagRepository repository;

  DeleteTag(this.repository);

  /// 태그를 삭제합니다.
  Future<void> call(String id) async {
    return await repository.deleteTag(id);
  }

  /// 사용되지 않는 태그를 모두 삭제합니다.
  Future<void> deleteUnusedTags() async {
    return await repository.deleteUnusedTags();
  }
}
