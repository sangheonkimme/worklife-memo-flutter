import '../entities/tag.dart';

/// 태그 Repository Interface
abstract class TagRepository {
  /// 태그 생성
  Future<Tag> createTag(Tag tag);

  /// 태그 조회 (단일)
  Future<Tag?> getTagById(String id);

  /// 이름으로 태그 조회
  Future<Tag?> getTagByName(String name);

  /// 모든 태그 조회
  Future<List<Tag>> getAllTags();

  /// 태그 검색 (자동완성용)
  Future<List<Tag>> searchTags(String query);

  /// 인기 태그 조회 (사용 횟수 기준)
  Future<List<Tag>> getPopularTags({int limit = 10});

  /// 최근 사용한 태그 조회
  Future<List<Tag>> getRecentTags({int limit = 10});

  /// 태그 업데이트
  Future<Tag> updateTag(Tag tag);

  /// 태그 삭제
  Future<void> deleteTag(String id);

  /// 태그 이름 변경
  Future<void> renameTag(String id, String newName);

  /// 태그 색상 변경
  Future<void> changeTagColor(String id, String newColor);

  /// 태그 병합 (fromTagId의 메모들을 toTagId로 이동 후 fromTagId 삭제)
  Future<void> mergeTags(String fromTagId, String toTagId);

  /// 사용되지 않는 태그 조회
  Future<List<Tag>> getUnusedTags();

  /// 사용되지 않는 태그 삭제
  Future<void> deleteUnusedTags();

  /// 태그 개수 조회
  Future<int> getTagCount();

  /// 태그가 사용된 메모 개수 조회
  Future<int> getNoteCountWithTag(String tagId);
}
