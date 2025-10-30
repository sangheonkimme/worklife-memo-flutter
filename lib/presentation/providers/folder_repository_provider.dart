import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/folder_local_datasource.dart';
import '../../data/repositories/folder_repository_impl.dart';
import '../../domain/repositories/folder_repository.dart';

part 'folder_repository_provider.g.dart';

/// FolderLocalDataSource Provider
///
/// FolderLocalDataSource 싱글톤 인스턴스를 제공합니다.
@riverpod
FolderLocalDataSource folderLocalDataSource(FolderLocalDataSourceRef ref) {
  return FolderLocalDataSource();
}

/// FolderRepository Provider
///
/// FolderRepositoryImpl 싱글톤 인스턴스를 제공합니다.
@riverpod
FolderRepository folderRepository(FolderRepositoryRef ref) {
  final localDataSource = ref.watch(folderLocalDataSourceProvider);
  return FolderRepositoryImpl(localDataSource: localDataSource);
}
