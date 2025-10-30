// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$popularTagsHash() => r'8a71e00e3a85d27b5325eb7e450795be2aa986bd';

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

/// 인기 태그 목록 Provider
///
/// Copied from [popularTags].
@ProviderFor(popularTags)
const popularTagsProvider = PopularTagsFamily();

/// 인기 태그 목록 Provider
///
/// Copied from [popularTags].
class PopularTagsFamily extends Family<AsyncValue<List<Tag>>> {
  /// 인기 태그 목록 Provider
  ///
  /// Copied from [popularTags].
  const PopularTagsFamily();

  /// 인기 태그 목록 Provider
  ///
  /// Copied from [popularTags].
  PopularTagsProvider call({
    int limit = 10,
  }) {
    return PopularTagsProvider(
      limit: limit,
    );
  }

  @override
  PopularTagsProvider getProviderOverride(
    covariant PopularTagsProvider provider,
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
  String? get name => r'popularTagsProvider';
}

/// 인기 태그 목록 Provider
///
/// Copied from [popularTags].
class PopularTagsProvider extends AutoDisposeFutureProvider<List<Tag>> {
  /// 인기 태그 목록 Provider
  ///
  /// Copied from [popularTags].
  PopularTagsProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => popularTags(
            ref as PopularTagsRef,
            limit: limit,
          ),
          from: popularTagsProvider,
          name: r'popularTagsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$popularTagsHash,
          dependencies: PopularTagsFamily._dependencies,
          allTransitiveDependencies:
              PopularTagsFamily._allTransitiveDependencies,
          limit: limit,
        );

  PopularTagsProvider._internal(
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
    FutureOr<List<Tag>> Function(PopularTagsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PopularTagsProvider._internal(
        (ref) => create(ref as PopularTagsRef),
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
  AutoDisposeFutureProviderElement<List<Tag>> createElement() {
    return _PopularTagsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PopularTagsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PopularTagsRef on AutoDisposeFutureProviderRef<List<Tag>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _PopularTagsProviderElement
    extends AutoDisposeFutureProviderElement<List<Tag>> with PopularTagsRef {
  _PopularTagsProviderElement(super.provider);

  @override
  int get limit => (origin as PopularTagsProvider).limit;
}

String _$recentTagsHash() => r'c0541625430ac4b975786eb812f344ede8986698';

/// 최근 사용한 태그 목록 Provider
///
/// Copied from [recentTags].
@ProviderFor(recentTags)
const recentTagsProvider = RecentTagsFamily();

/// 최근 사용한 태그 목록 Provider
///
/// Copied from [recentTags].
class RecentTagsFamily extends Family<AsyncValue<List<Tag>>> {
  /// 최근 사용한 태그 목록 Provider
  ///
  /// Copied from [recentTags].
  const RecentTagsFamily();

  /// 최근 사용한 태그 목록 Provider
  ///
  /// Copied from [recentTags].
  RecentTagsProvider call({
    int limit = 10,
  }) {
    return RecentTagsProvider(
      limit: limit,
    );
  }

  @override
  RecentTagsProvider getProviderOverride(
    covariant RecentTagsProvider provider,
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
  String? get name => r'recentTagsProvider';
}

/// 최근 사용한 태그 목록 Provider
///
/// Copied from [recentTags].
class RecentTagsProvider extends AutoDisposeFutureProvider<List<Tag>> {
  /// 최근 사용한 태그 목록 Provider
  ///
  /// Copied from [recentTags].
  RecentTagsProvider({
    int limit = 10,
  }) : this._internal(
          (ref) => recentTags(
            ref as RecentTagsRef,
            limit: limit,
          ),
          from: recentTagsProvider,
          name: r'recentTagsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recentTagsHash,
          dependencies: RecentTagsFamily._dependencies,
          allTransitiveDependencies:
              RecentTagsFamily._allTransitiveDependencies,
          limit: limit,
        );

  RecentTagsProvider._internal(
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
    FutureOr<List<Tag>> Function(RecentTagsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecentTagsProvider._internal(
        (ref) => create(ref as RecentTagsRef),
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
  AutoDisposeFutureProviderElement<List<Tag>> createElement() {
    return _RecentTagsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecentTagsProvider && other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin RecentTagsRef on AutoDisposeFutureProviderRef<List<Tag>> {
  /// The parameter `limit` of this provider.
  int get limit;
}

class _RecentTagsProviderElement
    extends AutoDisposeFutureProviderElement<List<Tag>> with RecentTagsRef {
  _RecentTagsProviderElement(super.provider);

  @override
  int get limit => (origin as RecentTagsProvider).limit;
}

String _$unusedTagsHash() => r'0a559b9c3ab2d263b2be192a2333ff300bd21ae7';

/// 사용되지 않는 태그 목록 Provider
///
/// Copied from [unusedTags].
@ProviderFor(unusedTags)
final unusedTagsProvider = AutoDisposeFutureProvider<List<Tag>>.internal(
  unusedTags,
  name: r'unusedTagsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$unusedTagsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UnusedTagsRef = AutoDisposeFutureProviderRef<List<Tag>>;
String _$searchTagsHash() => r'a3449ed8ac91ea576b53a4d403c97e070bef094d';

/// 태그 검색 Provider (자동완성용)
///
/// Copied from [searchTags].
@ProviderFor(searchTags)
const searchTagsProvider = SearchTagsFamily();

/// 태그 검색 Provider (자동완성용)
///
/// Copied from [searchTags].
class SearchTagsFamily extends Family<AsyncValue<List<Tag>>> {
  /// 태그 검색 Provider (자동완성용)
  ///
  /// Copied from [searchTags].
  const SearchTagsFamily();

  /// 태그 검색 Provider (자동완성용)
  ///
  /// Copied from [searchTags].
  SearchTagsProvider call(
    String query,
  ) {
    return SearchTagsProvider(
      query,
    );
  }

  @override
  SearchTagsProvider getProviderOverride(
    covariant SearchTagsProvider provider,
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
  String? get name => r'searchTagsProvider';
}

/// 태그 검색 Provider (자동완성용)
///
/// Copied from [searchTags].
class SearchTagsProvider extends AutoDisposeFutureProvider<List<Tag>> {
  /// 태그 검색 Provider (자동완성용)
  ///
  /// Copied from [searchTags].
  SearchTagsProvider(
    String query,
  ) : this._internal(
          (ref) => searchTags(
            ref as SearchTagsRef,
            query,
          ),
          from: searchTagsProvider,
          name: r'searchTagsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$searchTagsHash,
          dependencies: SearchTagsFamily._dependencies,
          allTransitiveDependencies:
              SearchTagsFamily._allTransitiveDependencies,
          query: query,
        );

  SearchTagsProvider._internal(
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
    FutureOr<List<Tag>> Function(SearchTagsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SearchTagsProvider._internal(
        (ref) => create(ref as SearchTagsRef),
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
  AutoDisposeFutureProviderElement<List<Tag>> createElement() {
    return _SearchTagsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SearchTagsProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SearchTagsRef on AutoDisposeFutureProviderRef<List<Tag>> {
  /// The parameter `query` of this provider.
  String get query;
}

class _SearchTagsProviderElement
    extends AutoDisposeFutureProviderElement<List<Tag>> with SearchTagsRef {
  _SearchTagsProviderElement(super.provider);

  @override
  String get query => (origin as SearchTagsProvider).query;
}

String _$tagHash() => r'72186d3a1ec02635ad8940b41540c5d80d24c796';

/// 단일 태그 조회 Provider
///
/// Copied from [tag].
@ProviderFor(tag)
const tagProvider = TagFamily();

/// 단일 태그 조회 Provider
///
/// Copied from [tag].
class TagFamily extends Family<AsyncValue<Tag?>> {
  /// 단일 태그 조회 Provider
  ///
  /// Copied from [tag].
  const TagFamily();

  /// 단일 태그 조회 Provider
  ///
  /// Copied from [tag].
  TagProvider call(
    String tagId,
  ) {
    return TagProvider(
      tagId,
    );
  }

  @override
  TagProvider getProviderOverride(
    covariant TagProvider provider,
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
  String? get name => r'tagProvider';
}

/// 단일 태그 조회 Provider
///
/// Copied from [tag].
class TagProvider extends AutoDisposeFutureProvider<Tag?> {
  /// 단일 태그 조회 Provider
  ///
  /// Copied from [tag].
  TagProvider(
    String tagId,
  ) : this._internal(
          (ref) => tag(
            ref as TagRef,
            tagId,
          ),
          from: tagProvider,
          name: r'tagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$tagHash,
          dependencies: TagFamily._dependencies,
          allTransitiveDependencies: TagFamily._allTransitiveDependencies,
          tagId: tagId,
        );

  TagProvider._internal(
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
    FutureOr<Tag?> Function(TagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TagProvider._internal(
        (ref) => create(ref as TagRef),
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
  AutoDisposeFutureProviderElement<Tag?> createElement() {
    return _TagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TagProvider && other.tagId == tagId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tagId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TagRef on AutoDisposeFutureProviderRef<Tag?> {
  /// The parameter `tagId` of this provider.
  String get tagId;
}

class _TagProviderElement extends AutoDisposeFutureProviderElement<Tag?>
    with TagRef {
  _TagProviderElement(super.provider);

  @override
  String get tagId => (origin as TagProvider).tagId;
}

String _$tagCountHash() => r'7fadb673699da71279627251bff10748aee6ec75';

/// 태그 개수 Provider
///
/// Copied from [tagCount].
@ProviderFor(tagCount)
final tagCountProvider = AutoDisposeFutureProvider<int>.internal(
  tagCount,
  name: r'tagCountProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tagCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TagCountRef = AutoDisposeFutureProviderRef<int>;
String _$noteCountWithTagHash() => r'0019be3cfa0fb7162f5587b03caff5769e994a6d';

/// 태그가 사용된 메모 개수 Provider
///
/// Copied from [noteCountWithTag].
@ProviderFor(noteCountWithTag)
const noteCountWithTagProvider = NoteCountWithTagFamily();

/// 태그가 사용된 메모 개수 Provider
///
/// Copied from [noteCountWithTag].
class NoteCountWithTagFamily extends Family<AsyncValue<int>> {
  /// 태그가 사용된 메모 개수 Provider
  ///
  /// Copied from [noteCountWithTag].
  const NoteCountWithTagFamily();

  /// 태그가 사용된 메모 개수 Provider
  ///
  /// Copied from [noteCountWithTag].
  NoteCountWithTagProvider call(
    String tagId,
  ) {
    return NoteCountWithTagProvider(
      tagId,
    );
  }

  @override
  NoteCountWithTagProvider getProviderOverride(
    covariant NoteCountWithTagProvider provider,
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
  String? get name => r'noteCountWithTagProvider';
}

/// 태그가 사용된 메모 개수 Provider
///
/// Copied from [noteCountWithTag].
class NoteCountWithTagProvider extends AutoDisposeFutureProvider<int> {
  /// 태그가 사용된 메모 개수 Provider
  ///
  /// Copied from [noteCountWithTag].
  NoteCountWithTagProvider(
    String tagId,
  ) : this._internal(
          (ref) => noteCountWithTag(
            ref as NoteCountWithTagRef,
            tagId,
          ),
          from: noteCountWithTagProvider,
          name: r'noteCountWithTagProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$noteCountWithTagHash,
          dependencies: NoteCountWithTagFamily._dependencies,
          allTransitiveDependencies:
              NoteCountWithTagFamily._allTransitiveDependencies,
          tagId: tagId,
        );

  NoteCountWithTagProvider._internal(
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
    FutureOr<int> Function(NoteCountWithTagRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: NoteCountWithTagProvider._internal(
        (ref) => create(ref as NoteCountWithTagRef),
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
  AutoDisposeFutureProviderElement<int> createElement() {
    return _NoteCountWithTagProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NoteCountWithTagProvider && other.tagId == tagId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tagId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin NoteCountWithTagRef on AutoDisposeFutureProviderRef<int> {
  /// The parameter `tagId` of this provider.
  String get tagId;
}

class _NoteCountWithTagProviderElement
    extends AutoDisposeFutureProviderElement<int> with NoteCountWithTagRef {
  _NoteCountWithTagProviderElement(super.provider);

  @override
  String get tagId => (origin as NoteCountWithTagProvider).tagId;
}

String _$tagListHash() => r'9fc1fef25aa52c96d5c9df674b5b115bf76d7f45';

/// 태그 목록 상태 Provider (AsyncNotifier)
///
/// 모든 태그 목록을 관리하고 CRUD 작업을 수행합니다.
///
/// Copied from [TagList].
@ProviderFor(TagList)
final tagListProvider =
    AutoDisposeAsyncNotifierProvider<TagList, List<Tag>>.internal(
  TagList.new,
  name: r'tagListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tagListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TagList = AutoDisposeAsyncNotifier<List<Tag>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
