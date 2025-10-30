import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

/// 태그 생성 UseCase
class CreateTag {
  final TagRepository repository;

  CreateTag(this.repository);

  /// 태그를 생성합니다.
  ///
  /// 같은 이름의 태그가 이미 존재하면 기존 태그를 반환합니다.
  Future<Tag> call(Tag tag) async {
    // 이름으로 태그 조회 (중복 방지)
    final existingTag = await repository.getTagByName(tag.name);

    if (existingTag != null) {
      // 기존 태그가 있으면 사용 횟수만 증가
      final updatedTag = existingTag.incrementUseCount();
      return await repository.updateTag(updatedTag);
    }

    // 새 태그 생성
    return await repository.createTag(tag);
  }

  /// 태그 이름과 색상으로 태그 생성
  Future<Tag> createByNameAndColor({
    required String name,
    required String color,
  }) async {
    final tag = TagX.create(name: name, color: color);
    return await call(tag);
  }
}
