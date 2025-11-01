// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchQueryHash() => r'a2de29f344488b8b351fbfcf9c230f993798b9ea';

/// 검색 쿼리 상태
///
/// Copied from [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
  SearchQuery.new,
  name: r'searchQueryProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$searchQueryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$searchResultsHash() => r'c358aaf3ba0e55b3cda7251719ee778cce984064';

/// 검색 결과 (디바운스 적용)
///
/// Copied from [SearchResults].
@ProviderFor(SearchResults)
final searchResultsProvider =
    AutoDisposeAsyncNotifierProvider<SearchResults, List<Note>>.internal(
  SearchResults.new,
  name: r'searchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchResults = AutoDisposeAsyncNotifier<List<Note>>;
String _$searchFiltersStateHash() =>
    r'c5df8445daaa7f5c617c72502346155b0c9c1a51';

/// 검색 필터 상태
///
/// Copied from [SearchFiltersState].
@ProviderFor(SearchFiltersState)
final searchFiltersStateProvider =
    AutoDisposeNotifierProvider<SearchFiltersState, SearchFilters>.internal(
  SearchFiltersState.new,
  name: r'searchFiltersStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchFiltersStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchFiltersState = AutoDisposeNotifier<SearchFilters>;
String _$sortOptionStateHash() => r'2559166e70d5d163e8da8225fea2cfebb9e3ac13';

/// 정렬 옵션 상태
///
/// Copied from [SortOptionState].
@ProviderFor(SortOptionState)
final sortOptionStateProvider =
    AutoDisposeNotifierProvider<SortOptionState, SortOption>.internal(
  SortOptionState.new,
  name: r'sortOptionStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sortOptionStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SortOptionState = AutoDisposeNotifier<SortOption>;
String _$filteredSearchResultsHash() =>
    r'1d6b6a30961839bc8a0a032defd664f748fb8b38';

/// 필터링 및 정렬된 검색 결과
///
/// Copied from [FilteredSearchResults].
@ProviderFor(FilteredSearchResults)
final filteredSearchResultsProvider = AutoDisposeAsyncNotifierProvider<
    FilteredSearchResults, List<Note>>.internal(
  FilteredSearchResults.new,
  name: r'filteredSearchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredSearchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FilteredSearchResults = AutoDisposeAsyncNotifier<List<Note>>;
String _$searchHistoryHash() => r'561723b961bd342f13d55256d1e53b2f66e92c91';

/// 검색 기록 (최근 검색어 저장)
///
/// Copied from [SearchHistory].
@ProviderFor(SearchHistory)
final searchHistoryProvider =
    AutoDisposeNotifierProvider<SearchHistory, List<String>>.internal(
  SearchHistory.new,
  name: r'searchHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchHistory = AutoDisposeNotifier<List<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
