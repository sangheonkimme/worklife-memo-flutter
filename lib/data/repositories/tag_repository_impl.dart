import '../../core/errors/exceptions.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/tag.dart';
import '../../domain/repositories/tag_repository.dart';
import '../datasources/local/tag_local_datasource.dart';

/// 태그 Repository 구현
class TagRepositoryImpl implements TagRepository {
  final TagLocalDataSource localDataSource;

  TagRepositoryImpl({required this.localDataSource});

  /// 에러 핸들러 - Exception을 Failure로 변환
  Never _handleError(dynamic error) {
    if (error is DatabaseException) {
      throw DatabaseFailure(message: error.message);
    } else if (error is CacheException) {
      throw CacheFailure(message: error.message);
    } else {
      throw CacheFailure(message: error.toString());
    }
  }

  @override
  Future<Tag> createTag(Tag tag) async {
    try {
      return await localDataSource.createTag(tag);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Tag?> getTagById(String id) async {
    try {
      return await localDataSource.getTagById(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Tag?> getTagByName(String name) async {
    try {
      return await localDataSource.getTagByName(name);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Tag>> getAllTags() async {
    try {
      return await localDataSource.getAllTags();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Tag>> searchTags(String query) async {
    try {
      return await localDataSource.searchTags(query);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Tag>> getPopularTags({int limit = 10}) async {
    try {
      return await localDataSource.getPopularTags(limit: limit);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Tag>> getRecentTags({int limit = 10}) async {
    try {
      return await localDataSource.getRecentTags(limit: limit);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<Tag> updateTag(Tag tag) async {
    try {
      return await localDataSource.updateTag(tag);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> deleteTag(String id) async {
    try {
      await localDataSource.deleteTag(id);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> renameTag(String id, String newName) async {
    try {
      await localDataSource.renameTag(id, newName);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> changeTagColor(String id, String newColor) async {
    try {
      await localDataSource.changeTagColor(id, newColor);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> mergeTags(String fromTagId, String toTagId) async {
    try {
      await localDataSource.mergeTags(fromTagId, toTagId);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<List<Tag>> getUnusedTags() async {
    try {
      return await localDataSource.getUnusedTags();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> deleteUnusedTags() async {
    try {
      await localDataSource.deleteUnusedTags();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getTagCount() async {
    try {
      return await localDataSource.getTagCount();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<int> getNoteCountWithTag(String tagId) async {
    try {
      return await localDataSource.getNoteCountWithTag(tagId);
    } catch (e) {
      _handleError(e);
    }
  }
}
