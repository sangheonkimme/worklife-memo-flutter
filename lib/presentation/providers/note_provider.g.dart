// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pinnedNotesHash() => r'c8ea5a8afa270e15b51c6160652d03e0352ca727';

/// 고정된 메모 목록 Provider
///
/// Copied from [pinnedNotes].
@ProviderFor(pinnedNotes)
final pinnedNotesProvider = AutoDisposeFutureProvider<List<Note>>.internal(
  pinnedNotes,
  name: r'pinnedNotesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pinnedNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PinnedNotesRef = AutoDisposeFutureProviderRef<List<Note>>;
String _$favoriteNotesHash() => r'8e7cfce75c0d075d43a2ac00c683fd10d1b02376';

/// 즐겨찾기 메모 목록 Provider
///
/// Copied from [favoriteNotes].
@ProviderFor(favoriteNotes)
final favoriteNotesProvider = AutoDisposeFutureProvider<List<Note>>.internal(
  favoriteNotes,
  name: r'favoriteNotesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteNotesRef = AutoDisposeFutureProviderRef<List<Note>>;
String _$archivedNotesHash() => r'cace419ebe8811249b106c99275930abbbd3ef37';

/// 보관된 메모 목록 Provider
///
/// Copied from [archivedNotes].
@ProviderFor(archivedNotes)
final archivedNotesProvider = AutoDisposeFutureProvider<List<Note>>.internal(
  archivedNotes,
  name: r'archivedNotesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$archivedNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ArchivedNotesRef = AutoDisposeFutureProviderRef<List<Note>>;
String _$deletedNotesHash() => r'0c31a837d63846592a6229b25df9e9b29fa24ca9';

/// 삭제된 메모 목록 Provider (휴지통)
///
/// Copied from [deletedNotes].
@ProviderFor(deletedNotes)
final deletedNotesProvider = AutoDisposeFutureProvider<List<Note>>.internal(
  deletedNotes,
  name: r'deletedNotesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$deletedNotesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeletedNotesRef = AutoDisposeFutureProviderRef<List<Note>>;
String _$noteHash() => r'6a62ac0c1a120f91480fa4854992dd02a70f5a7e';

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

/// 단일 메모 조회 Provider
///
/// Copied from [note].
@ProviderFor(note)
const noteProvider = NoteFamily();

/// 단일 메모 조회 Provider
///
/// Copied from [note].
class NoteFamily extends Family<AsyncValue<Note?>> {
  /// 단일 메모 조회 Provider
  ///
  /// Copied from [note].
  const NoteFamily();

  /// 단일 메모 조회 Provider
  ///
  /// Copied from [note].
  NoteProvider call(
    String noteId,
  ) {
    return NoteProvider(
      noteId,
    );
  }

  @override
  NoteProvider getProviderOverride(
    covariant NoteProvider provider,
  ) {
    return call(
      provider.noteId,
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
  String? get name => r'noteProvider';
}

/// 단일 메모 조회 Provider
///
/// Copied from [note].
class NoteProvider extends AutoDisposeFutureProvider<Note?> {
  /// 단일 메모 조회 Provider
  ///
  /// Copied from [note].
  NoteProvider(
    String noteId,
  ) : this._internal(
          (ref) => note(
            ref as NoteRef,
            noteId,
          ),
          from: noteProvider,
          name: r'noteProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$noteHash,
          dependencies: NoteFamily._dependencies,
          allTransitiveDependencies: NoteFamily._allTransitiveDependencies,
          noteId: noteId,
        );

  NoteProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.noteId,
  }) : super.internal();

  final String noteId;

  @override
  Override overrideWith(
    FutureOr<Note?> Function(NoteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NoteProvider._internal(
        (ref) => create(ref as NoteRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        noteId: noteId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Note?> createElement() {
    return _NoteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteProvider && other.noteId == noteId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, noteId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NoteRef on AutoDisposeFutureProviderRef<Note?> {
  /// The parameter `noteId` of this provider.
  String get noteId;
}

class _NoteProviderElement extends AutoDisposeFutureProviderElement<Note?>
    with NoteRef {
  _NoteProviderElement(super.provider);

  @override
  String get noteId => (origin as NoteProvider).noteId;
}

String _$recentNotesHash() => r'2b5ff8ff31c1aa3f1819a990d903b176f592d2b9';

/// 최근 메모 목록 Provider
///
/// Copied from [recentNotes].
@ProviderFor(recentNotes)
const recentNotesProvider = RecentNotesFamily();

/// 최근 메모 목록 Provider
///
/// Copied from [recentNotes].
class RecentNotesFamily extends Family<AsyncValue<List<Note>>> {
  /// 최근 메모 목록 Provider
  ///
  /// Copied from [recentNotes].
  const RecentNotesFamily();

  /// 최근 메모 목록 Provider
  ///
  /// Copied from [recentNotes].
  RecentNotesProvider call({
    int limit = 10,
  }) {
    return RecentNotesProvider(
      limit: limit,
    );
  }

  @override
  RecentNotesProvider getProviderOverride(
    covariant RecentNotesProvider provider,
  ) {
    return call(
      limit: provider.limit,
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
  String? get name => r'recentNotesProvider';
}

/// 최근 메모 목록 Provider
///
/// Copied from [recentNotes].
class RecentNotesProvider extends AutoDisposeFutureProvider<List<Note>> {
  /// 최근 메모 목록 Provider
  ///
  /// Copied from [recentNotes].
  RecentNotesProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => recentNotes(
            ref as RecentNotesRef,
            limit: limit,
          ),
          from: recentNotesProvider,
          name: r'recentNotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentNotesHash,
          dependencies: RecentNotesFamily._dependencies,
          allTransitiveDependencies:
              RecentNotesFamily._allTransitiveDependencies,
          limit: limit,
        );

  RecentNotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
  }) : super.internal();

  final int limit;

  @override
  Override overrideWith(
    FutureOr<List<Note>> Function(RecentNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentNotesProvider._internal(
        (ref) => create(ref as RecentNotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Note>> createElement() {
    return _RecentNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentNotesProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecentNotesRef on AutoDisposeFutureProviderRef<List<Note>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _RecentNotesProviderElement
    extends AutoDisposeFutureProviderElement<List<Note>> with RecentNotesRef {
  _RecentNotesProviderElement(super.provider);

  @override
  int get limit => (origin as RecentNotesProvider).limit;
}

String _$notesByFolderHash() => r'fa184877c1a48908c3e9eb8c7f5ffcaf10a1390e';

/// 폴더별 메모 목록 Provider
///
/// Copied from [notesByFolder].
@ProviderFor(notesByFolder)
const notesByFolderProvider = NotesByFolderFamily();

/// 폴더별 메모 목록 Provider
///
/// Copied from [notesByFolder].
class NotesByFolderFamily extends Family<AsyncValue<List<Note>>> {
  /// 폴더별 메모 목록 Provider
  ///
  /// Copied from [notesByFolder].
  const NotesByFolderFamily();

  /// 폴더별 메모 목록 Provider
  ///
  /// Copied from [notesByFolder].
  NotesByFolderProvider call(
    String folderId,
  ) {
    return NotesByFolderProvider(
      folderId,
    );
  }

  @override
  NotesByFolderProvider getProviderOverride(
    covariant NotesByFolderProvider provider,
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
  String? get name => r'notesByFolderProvider';
}

/// 폴더별 메모 목록 Provider
///
/// Copied from [notesByFolder].
class NotesByFolderProvider extends AutoDisposeFutureProvider<List<Note>> {
  /// 폴더별 메모 목록 Provider
  ///
  /// Copied from [notesByFolder].
  NotesByFolderProvider(
    String folderId,
  ) : this._internal(
          (ref) => notesByFolder(
            ref as NotesByFolderRef,
            folderId,
          ),
          from: notesByFolderProvider,
          name: r'notesByFolderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notesByFolderHash,
          dependencies: NotesByFolderFamily._dependencies,
          allTransitiveDependencies:
              NotesByFolderFamily._allTransitiveDependencies,
          folderId: folderId,
        );

  NotesByFolderProvider._internal(
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
    FutureOr<List<Note>> Function(NotesByFolderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NotesByFolderProvider._internal(
        (ref) => create(ref as NotesByFolderRef),
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
  AutoDisposeFutureProviderElement<List<Note>> createElement() {
    return _NotesByFolderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotesByFolderProvider && other.folderId == folderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, folderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NotesByFolderRef on AutoDisposeFutureProviderRef<List<Note>> {
  /// The parameter `folderId` of this provider.
  String get folderId;
}

class _NotesByFolderProviderElement
    extends AutoDisposeFutureProviderElement<List<Note>> with NotesByFolderRef {
  _NotesByFolderProviderElement(super.provider);

  @override
  String get folderId => (origin as NotesByFolderProvider).folderId;
}

String _$notesByTagHash() => r'78dea08bd7cfbc5347fa887912b91dc2aa0ad89a';

/// 태그별 메모 목록 Provider
///
/// Copied from [notesByTag].
@ProviderFor(notesByTag)
const notesByTagProvider = NotesByTagFamily();

/// 태그별 메모 목록 Provider
///
/// Copied from [notesByTag].
class NotesByTagFamily extends Family<AsyncValue<List<Note>>> {
  /// 태그별 메모 목록 Provider
  ///
  /// Copied from [notesByTag].
  const NotesByTagFamily();

  /// 태그별 메모 목록 Provider
  ///
  /// Copied from [notesByTag].
  NotesByTagProvider call(
    String tagId,
  ) {
    return NotesByTagProvider(
      tagId,
    );
  }

  @override
  NotesByTagProvider getProviderOverride(
    covariant NotesByTagProvider provider,
  ) {
    return call(
      provider.tagId,
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
  String? get name => r'notesByTagProvider';
}

/// 태그별 메모 목록 Provider
///
/// Copied from [notesByTag].
class NotesByTagProvider extends AutoDisposeFutureProvider<List<Note>> {
  /// 태그별 메모 목록 Provider
  ///
  /// Copied from [notesByTag].
  NotesByTagProvider(
    String tagId,
  ) : this._internal(
          (ref) => notesByTag(
            ref as NotesByTagRef,
            tagId,
          ),
          from: notesByTagProvider,
          name: r'notesByTagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$notesByTagHash,
          dependencies: NotesByTagFamily._dependencies,
          allTransitiveDependencies:
              NotesByTagFamily._allTransitiveDependencies,
          tagId: tagId,
        );

  NotesByTagProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tagId,
  }) : super.internal();

  final String tagId;

  @override
  Override overrideWith(
    FutureOr<List<Note>> Function(NotesByTagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NotesByTagProvider._internal(
        (ref) => create(ref as NotesByTagRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tagId: tagId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Note>> createElement() {
    return _NotesByTagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotesByTagProvider && other.tagId == tagId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tagId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NotesByTagRef on AutoDisposeFutureProviderRef<List<Note>> {
  /// The parameter `tagId` of this provider.
  String get tagId;
}

class _NotesByTagProviderElement
    extends AutoDisposeFutureProviderElement<List<Note>> with NotesByTagRef {
  _NotesByTagProviderElement(super.provider);

  @override
  String get tagId => (origin as NotesByTagProvider).tagId;
}

String _$searchNotesHash() => r'13d5625950bf1efc5d158de7e491cb9fb7f59b93';

/// 메모 검색 Provider
///
/// Copied from [searchNotes].
@ProviderFor(searchNotes)
const searchNotesProvider = SearchNotesFamily();

/// 메모 검색 Provider
///
/// Copied from [searchNotes].
class SearchNotesFamily extends Family<AsyncValue<List<Note>>> {
  /// 메모 검색 Provider
  ///
  /// Copied from [searchNotes].
  const SearchNotesFamily();

  /// 메모 검색 Provider
  ///
  /// Copied from [searchNotes].
  SearchNotesProvider call(
    String query,
  ) {
    return SearchNotesProvider(
      query,
    );
  }

  @override
  SearchNotesProvider getProviderOverride(
    covariant SearchNotesProvider provider,
  ) {
    return call(
      provider.query,
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
  String? get name => r'searchNotesProvider';
}

/// 메모 검색 Provider
///
/// Copied from [searchNotes].
class SearchNotesProvider extends AutoDisposeFutureProvider<List<Note>> {
  /// 메모 검색 Provider
  ///
  /// Copied from [searchNotes].
  SearchNotesProvider(
    String query,
  ) : this._internal(
          (ref) => searchNotes(
            ref as SearchNotesRef,
            query,
          ),
          from: searchNotesProvider,
          name: r'searchNotesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchNotesHash,
          dependencies: SearchNotesFamily._dependencies,
          allTransitiveDependencies:
              SearchNotesFamily._allTransitiveDependencies,
          query: query,
        );

  SearchNotesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final String query;

  @override
  Override overrideWith(
    FutureOr<List<Note>> Function(SearchNotesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchNotesProvider._internal(
        (ref) => create(ref as SearchNotesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Note>> createElement() {
    return _SearchNotesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchNotesProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchNotesRef on AutoDisposeFutureProviderRef<List<Note>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchNotesProviderElement
    extends AutoDisposeFutureProviderElement<List<Note>> with SearchNotesRef {
  _SearchNotesProviderElement(super.provider);

  @override
  String get query => (origin as SearchNotesProvider).query;
}

String _$noteListHash() => r'd7fd7e702e74d709ef303311c1ea6fd6d454ddec';

/// 메모 목록 상태 Provider (AsyncNotifier)
///
/// 활성 메모 목록을 관리하고 CRUD 작업을 수행합니다.
///
/// Copied from [NoteList].
@ProviderFor(NoteList)
final noteListProvider =
    AutoDisposeAsyncNotifierProvider<NoteList, List<Note>>.internal(
  NoteList.new,
  name: r'noteListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$noteListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NoteList = AutoDisposeAsyncNotifier<List<Note>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
