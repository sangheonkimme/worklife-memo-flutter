// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'folder_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$rootFoldersHash() => r'911c72d0f1f30489e606ebd33d6fcafc0f142337';

/// 루트 폴더 목록 Provider
///
/// Copied from [rootFolders].
@ProviderFor(rootFolders)
final rootFoldersProvider = AutoDisposeFutureProvider<List<Folder>>.internal(
  rootFolders,
  name: r'rootFoldersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rootFoldersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RootFoldersRef = AutoDisposeFutureProviderRef<List<Folder>>;
String _$subFoldersHash() => r'a33d47bde3eb6e83338f736b50e873e1a01a1495';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 하위 폴더 목록 Provider
///
/// Copied from [subFolders].
@ProviderFor(subFolders)
const subFoldersProvider = SubFoldersFamily();

/// 하위 폴더 목록 Provider
///
/// Copied from [subFolders].
class SubFoldersFamily extends Family<AsyncValue<List<Folder>>> {
  /// 하위 폴더 목록 Provider
  ///
  /// Copied from [subFolders].
  const SubFoldersFamily();

  /// 하위 폴더 목록 Provider
  ///
  /// Copied from [subFolders].
  SubFoldersProvider call(
    String parentId,
  ) {
    return SubFoldersProvider(
      parentId,
    );
  }

  @override
  SubFoldersProvider getProviderOverride(
    covariant SubFoldersProvider provider,
  ) {
    return call(
      provider.parentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subFoldersProvider';
}

/// 하위 폴더 목록 Provider
///
/// Copied from [subFolders].
class SubFoldersProvider extends AutoDisposeFutureProvider<List<Folder>> {
  /// 하위 폴더 목록 Provider
  ///
  /// Copied from [subFolders].
  SubFoldersProvider(
    String parentId,
  ) : this._internal(
          (ref) => subFolders(
            ref as SubFoldersRef,
            parentId,
          ),
          from: subFoldersProvider,
          name: r'subFoldersProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subFoldersHash,
          dependencies: SubFoldersFamily._dependencies,
          allTransitiveDependencies:
              SubFoldersFamily._allTransitiveDependencies,
          parentId: parentId,
        );

  SubFoldersProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
  }) : super.internal();

  final String parentId;

  @override
  Override overrideWith(
    FutureOr<List<Folder>> Function(SubFoldersRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubFoldersProvider._internal(
        (ref) => create(ref as SubFoldersRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Folder>> createElement() {
    return _SubFoldersProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubFoldersProvider && other.parentId == parentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SubFoldersRef on AutoDisposeFutureProviderRef<List<Folder>> {
  /// The parameter `parentId` of this provider.
  String get parentId;
}

class _SubFoldersProviderElement
    extends AutoDisposeFutureProviderElement<List<Folder>> with SubFoldersRef {
  _SubFoldersProviderElement(super.provider);

  @override
  String get parentId => (origin as SubFoldersProvider).parentId;
}

String _$folderTreeHash() => r'c0f99b9b33a4afffe131d3bc95fba34a6defa0d6';

/// 폴더 트리 Provider
///
/// Copied from [folderTree].
@ProviderFor(folderTree)
final folderTreeProvider =
    AutoDisposeFutureProvider<Map<String, List<Folder>>>.internal(
  folderTree,
  name: r'folderTreeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$folderTreeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FolderTreeRef = AutoDisposeFutureProviderRef<Map<String, List<Folder>>>;
String _$folderHash() => r'787763f8f3745863729d701d7a65932aaf73b84d';

/// 단일 폴더 조회 Provider
///
/// Copied from [folder].
@ProviderFor(folder)
const folderProvider = FolderFamily();

/// 단일 폴더 조회 Provider
///
/// Copied from [folder].
class FolderFamily extends Family<AsyncValue<Folder?>> {
  /// 단일 폴더 조회 Provider
  ///
  /// Copied from [folder].
  const FolderFamily();

  /// 단일 폴더 조회 Provider
  ///
  /// Copied from [folder].
  FolderProvider call(
    String folderId,
  ) {
    return FolderProvider(
      folderId,
    );
  }

  @override
  FolderProvider getProviderOverride(
    covariant FolderProvider provider,
  ) {
    return call(
      provider.folderId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'folderProvider';
}

/// 단일 폴더 조회 Provider
///
/// Copied from [folder].
class FolderProvider extends AutoDisposeFutureProvider<Folder?> {
  /// 단일 폴더 조회 Provider
  ///
  /// Copied from [folder].
  FolderProvider(
    String folderId,
  ) : this._internal(
          (ref) => folder(
            ref as FolderRef,
            folderId,
          ),
          from: folderProvider,
          name: r'folderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$folderHash,
          dependencies: FolderFamily._dependencies,
          allTransitiveDependencies: FolderFamily._allTransitiveDependencies,
          folderId: folderId,
        );

  FolderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.folderId,
  }) : super.internal();

  final String folderId;

  @override
  Override overrideWith(
    FutureOr<Folder?> Function(FolderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FolderProvider._internal(
        (ref) => create(ref as FolderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        folderId: folderId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Folder?> createElement() {
    return _FolderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FolderProvider && other.folderId == folderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, folderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FolderRef on AutoDisposeFutureProviderRef<Folder?> {
  /// The parameter `folderId` of this provider.
  String get folderId;
}

class _FolderProviderElement extends AutoDisposeFutureProviderElement<Folder?>
    with FolderRef {
  _FolderProviderElement(super.provider);

  @override
  String get folderId => (origin as FolderProvider).folderId;
}

String _$folderListHash() => r'24a53d89a0435e3dd2ba2c77e6c887f7e54e0006';

/// 폴더 목록 상태 Provider (AsyncNotifier)
///
/// 모든 폴더 목록을 관리하고 CRUD 작업을 수행합니다.
///
/// Copied from [FolderList].
@ProviderFor(FolderList)
final folderListProvider =
    AutoDisposeAsyncNotifierProvider<FolderList, List<Folder>>.internal(
  FolderList.new,
  name: r'folderListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$folderListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FolderList = AutoDisposeAsyncNotifier<List<Folder>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
