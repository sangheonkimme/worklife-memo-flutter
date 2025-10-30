// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$folderLocalDataSourceHash() =>
    r'd87d092252219bd15cac04b84f6cca8ddf87171d';

/// FolderLocalDataSource Provider
///
/// FolderLocalDataSource 싱글톤 인스턴스를 제공합니다.
///
/// Copied from [folderLocalDataSource].
@ProviderFor(folderLocalDataSource)
final folderLocalDataSourceProvider =
    AutoDisposeProvider<FolderLocalDataSource>.internal(
  folderLocalDataSource,
  name: r'folderLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$folderLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FolderLocalDataSourceRef
    = AutoDisposeProviderRef<FolderLocalDataSource>;
String _$folderRepositoryHash() => r'c901a6f5fd9253910bfbc50df4c39492c852fb9d';

/// FolderRepository Provider
///
/// FolderRepositoryImpl 싱글톤 인스턴스를 제공합니다.
///
/// Copied from [folderRepository].
@ProviderFor(folderRepository)
final folderRepositoryProvider = AutoDisposeProvider<FolderRepository>.internal(
  folderRepository,
  name: r'folderRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$folderRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FolderRepositoryRef = AutoDisposeProviderRef<FolderRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
