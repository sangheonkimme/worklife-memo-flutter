// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$noteLocalDataSourceHash() =>
    r'b3d9b73ffaa8213396a00f9e89d136bb2263c4f3';

/// NoteLocalDataSource Provider
///
/// NoteLocalDataSource 싱글톤 인스턴스를 제공합니다.
///
/// Copied from [noteLocalDataSource].
@ProviderFor(noteLocalDataSource)
final noteLocalDataSourceProvider =
    AutoDisposeProvider<NoteLocalDataSource>.internal(
  noteLocalDataSource,
  name: r'noteLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$noteLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NoteLocalDataSourceRef = AutoDisposeProviderRef<NoteLocalDataSource>;
String _$noteRepositoryHash() => r'312f31d98b6b54c6d32f529fe2cee2c8c247fcba';

/// NoteRepository Provider
///
/// NoteRepositoryImpl 싱글톤 인스턴스를 제공합니다.
///
/// Copied from [noteRepository].
@ProviderFor(noteRepository)
final noteRepositoryProvider = AutoDisposeProvider<NoteRepository>.internal(
  noteRepository,
  name: r'noteRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$noteRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NoteRepositoryRef = AutoDisposeProviderRef<NoteRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
