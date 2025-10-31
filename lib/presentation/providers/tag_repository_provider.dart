import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/tag_local_datasource.dart';
import '../../data/repositories/tag_repository_impl.dart';
import '../../domain/repositories/tag_repository.dart';
import 'app_database_provider.dart';

part 'tag_repository_provider.g.dart';

/// TagLocalDataSource Provider
///
/// TagLocalDataSource 싱글톤 인스턴스를 제공합니다.
@riverpod
TagLocalDataSource tagLocalDataSource(TagLocalDataSourceRef ref) {
  final database = ref.watch(appDatabaseProvider);
  return TagLocalDataSource(database);
}

/// TagRepository Provider
///
/// TagRepositoryImpl 싱글톤 인스턴스를 제공합니다.
@riverpod
TagRepository tagRepository(TagRepositoryRef ref) {
  final localDataSource = ref.watch(tagLocalDataSourceProvider);
  return TagRepositoryImpl(localDataSource: localDataSource);
}
