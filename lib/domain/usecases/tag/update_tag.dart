import '../../entities/tag.dart';
import '../../repositories/tag_repository.dart';

/// 태그 업데이트 UseCase
class UpdateTag {
  final TagRepository repository;

  UpdateTag(this.repository);

  /// 태그를 업데이트합니다.
  Future<Tag> call(Tag tag) async {
    return await repository.updateTag(tag);
  }

  /// 태그 이름을 변경합니다.
  Future<void> renameTag(String id, String newName) async {
    return await repository.renameTag(id, newName);
  }

  /// 태그 색상을 변경합니다.
  Future<void> changeColor(String id, String newColor) async {
    return await repository.changeTagColor(id, newColor);
  }

  /// 태그를 병합합니다.
  ///
  /// fromTagId의 모든 메모를 toTagId로 이동하고 fromTagId를 삭제합니다.
  Future<void> mergeTags(String fromTagId, String toTagId) async {
    return await repository.mergeTags(fromTagId, toTagId);
  }
}
