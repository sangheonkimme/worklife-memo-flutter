# WorkLife Dashboard 메모 앱 - Flutter 크로스 플랫폼 개발 PRD

**버전**: 1.0  
**날짜**: 2025-01-23  
**작성자**: 개발팀  
**상태**: 초안  
**프로젝트 단계**: Phase 2 - Flutter 모바일 앱 개발

---

## 1. 프로젝트 개요

### 1.1 배경

WorkLife Dashboard 메모 앱 확장 기능의 성공적인 웹 구현 이후, 모바일 사용자의 접근성을 높이기 위해 Flutter를 활용한 크로스 플랫폼 모바일 앱을 개발합니다.

### 1.2 핵심 목표

- **웹-모바일 완벽 동기화**: 기존 웹 API를 100% 활용한 실시간 동기화
- **네이티브 성능**: Flutter의 고성능 렌더링 엔진 활용
- **일관된 UI/UX**: Material Design 3 기반 통일된 경험
- **오프라인 우선**: 네트워크 없이도 완전한 기능 제공

### 1.3 대상 플랫폼

- **iOS**: 12.0 이상
- **Android**: API Level 21 (5.0 Lollipop) 이상
- **태블릿**: iPad, Android 태블릿 최적화
- **웹**: Flutter Web 지원 (Phase 3)

### 1.4 성공 지표

- [ ] 앱 다운로드 5,000건 (3개월)
- [ ] DAU 1,000명 이상
- [ ] 앱스토어 평점 4.7 이상
- [ ] 크래시율 0.5% 미만
- [ ] 콜드 스타트 1.5초 이내
- [ ] 프레임 렌더링 60fps 유지

---

## 2. 기술 스택

### 2.1 코어 기술

```yaml
Framework: Flutter 3.16.x
Language: Dart 3.2.x
State Management: Riverpod 2.4.x
Architecture: Clean Architecture + DDD
```

### 2.2 주요 패키지

```yaml
dependencies:
  # Core
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter

  # State Management & DI
  flutter_riverpod: ^2.4.0
  riverpod_annotation: ^2.3.0
  freezed_annotation: ^2.4.0
  get_it: ^7.6.0
  injectable: ^2.3.0

  # Navigation
  go_router: ^12.1.0

  # Networking
  dio: ^5.4.0
  retrofit: ^4.0.3
  pretty_dio_logger: ^1.3.1
  connectivity_plus: ^5.0.0

  # Local Database
  isar: ^3.1.0
  isar_flutter_libs: ^3.1.0
  hive_flutter: ^1.1.0
  sqflite: ^2.3.0

  # UI Components
  flutter_animate: ^4.3.0
  lottie: ^2.7.0
  shimmer: ^3.0.0
  flutter_slidable: ^3.0.0
  flutter_staggered_grid_view: ^0.7.0

  # Editor & Markdown
  flutter_quill: ^8.6.0
  markdown_widget: ^2.3.0
  flutter_markdown: ^0.6.0
  flutter_highlight: ^0.7.0

  # Media & Files
  image_picker: ^1.0.0
  file_picker: ^6.1.0
  cached_network_image: ^3.3.0
  flutter_cache_manager: ^3.3.0
  photo_view: ^0.14.0

  # Utils
  intl: ^0.18.0
  path_provider: ^2.1.0
  permission_handler: ^11.0.0
  url_launcher: ^6.2.0
  share_plus: ^7.2.0

  # Security
  flutter_secure_storage: ^9.0.0
  local_auth: ^2.1.0
  crypto: ^3.0.0

  # Background & Sync
  workmanager: ^0.5.2
  flutter_background_service: ^5.0.0

  # Notifications
  flutter_local_notifications: ^16.0.0
  firebase_messaging: ^14.7.0

  # Analytics & Monitoring
  firebase_core: ^2.24.0
  firebase_analytics: ^10.7.0
  firebase_crashlytics: ^3.4.0
  sentry_flutter: ^7.14.0

dev_dependencies:
  # Code Generation
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  retrofit_generator: ^8.0.0
  injectable_generator: ^2.4.0
  riverpod_generator: ^2.3.0
  isar_generator: ^3.1.0

  # Testing
  flutter_test:
    sdk: flutter
  mockito: ^5.4.0
  mocktail: ^1.0.0
  integration_test:
    sdk: flutter
```

### 2.3 API 통합 (메모 앱 PRD 기반)

```dart
// API 엔드포인트 - 기존 웹 API 100% 활용
class ApiEndpoints {
  static const String baseUrl = 'https://api.worklife-dashboard.com/v1';

  // 메모 CRUD
  static const String notes = '/api/notes';
  static const String noteDetail = '/api/notes/{id}';
  static const String pinNote = '/api/notes/{id}/pin';
  static const String favoriteNote = '/api/notes/{id}/favorite';
  static const String archiveNote = '/api/notes/{id}/archive';
  static const String trashNotes = '/api/notes/trash';
  static const String restoreNote = '/api/notes/{id}/restore';
  static const String permanentDelete = '/api/notes/{id}/permanent';

  // 폴더 & 태그
  static const String folders = '/api/folders';
  static const String folderDetail = '/api/folders/{id}';
  static const String moveFolder = '/api/folders/{id}/move';
  static const String tags = '/api/tags';
  static const String tagSuggest = '/api/tags/suggest';

  // 체크리스트
  static const String checklist = '/api/notes/{id}/checklist';
  static const String checklistItem = '/api/checklist/{id}';
  static const String toggleChecklistItem = '/api/checklist/{id}/toggle';

  // 검색 & 통계
  static const String searchNotes = '/api/notes/search';
  static const String recentNotes = '/api/notes/recent';
  static const String notesStats = '/api/notes/stats';

  // 템플릿
  static const String templates = '/api/templates';
  static const String templateDetail = '/api/templates/{id}';

  // 연동
  static const String linkTransaction = '/api/notes/{id}/link-transaction';
  static const String unlinkTransaction = '/api/notes/{id}/unlink/{tid}';
  static const String transactionNotes = '/api/transactions/{id}/notes';

  // 내보내기
  static const String exportPdf = '/api/notes/{id}/export/pdf';
  static const String exportMarkdown = '/api/notes/{id}/export/markdown';
  static const String shareNote = '/api/notes/{id}/share';
}
```

---

## 3. 앱 아키텍처

### 3.1 Clean Architecture 구조

```
lib/
├── core/
│   ├── constants/
│   │   ├── api_constants.dart
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── app_themes.dart
│   ├── errors/
│   │   ├── exceptions.dart
│   │   └── failures.dart
│   ├── network/
│   │   ├── dio_client.dart
│   │   ├── api_interceptor.dart
│   │   └── network_info.dart
│   ├── usecases/
│   │   └── usecase.dart
│   └── utils/
│       ├── formatters.dart
│       ├── validators.dart
│       └── extensions.dart
│
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── note_local_datasource.dart
│   │   │   ├── isar_database.dart
│   │   │   └── secure_storage.dart
│   │   └── remote/
│   │       ├── note_remote_datasource.dart
│   │       ├── auth_api_client.dart
│   │       └── note_api_client.dart
│   ├── models/
│   │   ├── note_model.dart
│   │   ├── folder_model.dart
│   │   ├── tag_model.dart
│   │   └── template_model.dart
│   └── repositories/
│       ├── note_repository_impl.dart
│       ├── folder_repository_impl.dart
│       └── tag_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   ├── note.dart
│   │   ├── folder.dart
│   │   ├── tag.dart
│   │   └── checklist_item.dart
│   ├── repositories/
│   │   ├── note_repository.dart
│   │   ├── folder_repository.dart
│   │   └── tag_repository.dart
│   └── usecases/
│       ├── notes/
│       │   ├── create_note.dart
│       │   ├── update_note.dart
│       │   ├── delete_note.dart
│       │   └── get_notes.dart
│       ├── folders/
│       └── tags/
│
├── presentation/
│   ├── providers/
│   │   ├── note_provider.dart
│   │   ├── folder_provider.dart
│   │   ├── tag_provider.dart
│   │   └── sync_provider.dart
│   ├── pages/
│   │   ├── splash/
│   │   ├── auth/
│   │   ├── home/
│   │   ├── notes/
│   │   │   ├── note_list_page.dart
│   │   │   ├── note_editor_page.dart
│   │   │   └── note_detail_page.dart
│   │   ├── folders/
│   │   ├── search/
│   │   └── settings/
│   ├── widgets/
│   │   ├── common/
│   │   ├── editor/
│   │   │   ├── text_editor.dart
│   │   │   ├── markdown_editor.dart
│   │   │   └── checklist_editor.dart
│   │   └── notes/
│   │       ├── note_card.dart
│   │       ├── note_list_item.dart
│   │       └── tag_chip.dart
│   └── router/
│       └── app_router.dart
│
└── main.dart
```

### 3.2 데이터 플로우

```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│        Presentation      │ ─▶│          Riverpod          │────▶│   Domain            │
│           Layer          │     │          Providers         │     │   Layer                  │
└─────────────┘     └──────────────┘     └─────────────┘
                                                │                               │
                                                ▼                               ▼
                               ┌──────────────┐      ┌─────────────┐
                               │            Data            │      │         Repository       │
                               │            Layer           │◀──│         Interface        │
                               └──────────────┘      └─────────────┘
                                              │
                              ┌───────┴────────┐
                              ▼                                ▼
                 ┌─────────────┐  ┌─────────────┐
                 │       Local Source       │  │       Remote Source      │
                 │          (Isar)          │  │          (API)           │
                 └─────────────┘  └─────────────┘
```

---

## 4. 핵심 기능 구현

### 4.1 메모 에디터

#### 4.1.1 Flutter Quill 에디터

```dart
class NoteEditorPage extends ConsumerStatefulWidget {
  final Note? note;
  final NoteType type;

  // Rich Text Editor with Flutter Quill
  QuillController _controller = QuillController.basic();

  // Features
  - 리치 텍스트 편집
  - 이미지 삽입
  - 코드 블록
  - 테이블 지원
  - 자동 저장 (3초 디바운스)
  - 실행 취소/재실행
}
```

#### 4.1.2 마크다운 에디터

```dart
class MarkdownEditorWidget extends StatefulWidget {
  // Split view: Editor + Preview
  - 실시간 미리보기
  - 문법 하이라이팅
  - 툴바 (Bold, Italic, Link, etc.)
  - GFM (GitHub Flavored Markdown) 지원
  - Mermaid 다이어그램
}
```

#### 4.1.3 체크리스트 에디터

```dart
class ChecklistEditorWidget extends StatefulWidget {
  // Reorderable checklist
  - ReorderableListView 활용
  - 드래그 앤 드롭
  - 진행률 인디케이터
  - 서브 태스크 지원
  - 완료 애니메이션
}
```

### 4.2 메모 목록 & 그리드

#### 4.2.1 고성능 리스트

```dart
class NoteListView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesProvider);

    return CustomScrollView(
      slivers: [
        // Sliver App Bar with Search
        SliverAppBar(
          floating: true,
          snap: true,
          title: SearchBar(),
        ),

        // Filter Chips
        SliverToBoxAdapter(
          child: FilterChipsRow(),
        ),

        // Note List/Grid
        SliverLayoutBuilder(
          builder: (context, constraints) {
            if (constraints.crossAxisExtent > 600) {
              // Tablet: Grid View
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => NoteCard(notes[index]),
                ),
              );
            } else {
              // Phone: List View
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Slidable(
                    child: NoteListItem(notes[index]),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
```

#### 4.2.2 스와이프 액션

```dart
class SlidableNoteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _pinNote(),
            backgroundColor: Colors.blue,
            icon: Icons.push_pin,
            label: '고정',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: (_) => _archiveNote(),
            backgroundColor: Colors.orange,
            icon: Icons.archive,
            label: '보관',
          ),
          SlidableAction(
            onPressed: (_) => _deleteNote(),
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: '삭제',
          ),
        ],
      ),
      child: NoteListTile(),
    );
  }
}
```

### 4.3 폴더 & 태그 시스템

#### 4.3.1 폴더 트리

```dart
class FolderTreeWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folders = ref.watch(foldersProvider);

    return TreeView(
      controller: _treeController,
      allowParentSelect: true,
      supportParentDoubleTap: true,
      onExpansionChanged: (key, expanded) {
        // 폴더 확장/축소 애니메이션
      },
      onNodeTap: (key) {
        // 폴더 선택 시 필터링
      },
      theme: TreeViewTheme(
        expanderTheme: ExpanderThemeData(
          type: ExpanderType.chevron,
          modifier: ExpanderModifier.none,
          position: ExpanderPosition.start,
          color: Theme.of(context).primaryColor,
        ),
      ),
      nodes: _buildTreeNodes(folders),
    );
  }

  List<TreeNode> _buildTreeNodes(List<Folder> folders) {
    // 재귀적으로 트리 노드 생성 (최대 3단계)
  }
}
```

#### 4.3.2 태그 입력 & 관리

```dart
class TagInputField extends StatefulWidget {
  @override
  Widget build(BuildContext context) {
    return ChipsInput(
      initialValue: selectedTags,
      decoration: InputDecoration(
        labelText: '태그 추가',
        prefixIcon: Icon(Icons.label),
      ),
      findSuggestions: (String query) async {
        // API 호출하여 태그 자동완성
        return await _tagRepository.getSuggestions(query);
      },
      onChanged: (tags) {
        // 태그 변경 처리
      },
      chipBuilder: (context, state, tag) {
        return InputChip(
          label: Text(tag.name),
          backgroundColor: HexColor(tag.color),
          onDeleted: () => state.deleteChip(tag),
        );
      },
    );
  }
}
```

### 4.4 검색 시스템

#### 4.4.1 전문 검색

```dart
class SearchPage extends ConsumerStatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(searchProvider.notifier).search(
        query: query,
        filters: SearchFilters(
          tags: selectedTags,
          folders: selectedFolders,
          dateRange: dateRange,
          noteTypes: selectedTypes,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          decoration: InputDecoration(
            hintText: '검색...',
            border: InputBorder.none,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: FilterChipsRow(),
        ),
      ),
      body: searchResults.when(
        data: (notes) => SearchResultsList(notes),
        loading: () => ShimmerLoadingList(),
        error: (err, stack) => ErrorWidget(err),
      ),
    );
  }
}
```

### 4.5 오프라인 지원 & 동기화

#### 4.5.1 Isar 데이터베이스

```dart
// Isar Schema
@collection
class NoteEntity {
  Id id = Isar.autoIncrement;

  @Index()
  late String uuid;

  late String title;
  late String content;

  @enumerated
  late NoteType type;

  @Index()
  late DateTime createdAt;

  @Index()
  late DateTime updatedAt;

  @enumerated
  late SyncStatus syncStatus;

  final folders = IsarLink<FolderEntity>();
  final tags = IsarLinks<TagEntity>();

  @Index(composite: [CompositeIndex('updatedAt')])
  late bool needsSync;
}
```

#### 4.5.2 동기화 엔진

```dart
class SyncManager {
  final Isar _isar;
  final NoteApiClient _apiClient;
  final ConnectivityPlus _connectivity;

  // 양방향 동기화
  Future<void> syncNotes() async {
    if (!await _hasConnection()) return;

    try {
      // 1. 로컬 변경사항 업로드
      final localChanges = await _getLocalChanges();
      for (final note in localChanges) {
        await _uploadNote(note);
      }

      // 2. 서버 변경사항 다운로드
      final lastSync = await _getLastSyncTime();
      final serverChanges = await _apiClient.getChanges(since: lastSync);

      // 3. 충돌 해결
      for (final remoteNote in serverChanges) {
        await _resolveAndSave(remoteNote);
      }

      // 4. 동기화 완료 표시
      await _updateSyncStatus();

    } catch (e) {
      // 에러 처리 및 재시도 큐에 추가
      await _queueForRetry();
    }
  }

  // 충돌 해결 전략
  Future<void> _resolveAndSave(NoteModel remoteNote) async {
    final localNote = await _isar.noteEntitys
        .where()
        .uuidEqualTo(remoteNote.uuid)
        .findFirst();

    if (localNote == null) {
      // 새 노트: 로컬에 추가
      await _saveToLocal(remoteNote);
    } else if (localNote.updatedAt.isBefore(remoteNote.updatedAt)) {
      // 서버가 더 최신: 로컬 업데이트
      await _updateLocal(remoteNote);
    } else if (localNote.needsSync) {
      // 충돌: 사용자에게 선택 요청 또는 자동 병합
      await _handleConflict(localNote, remoteNote);
    }
  }
}
```

### 4.6 가계부 연동

#### 4.6.1 거래 연결

```dart
class TransactionLinkDialog extends ConsumerWidget {
  final String noteId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);

    return Dialog(
      child: Column(
        children: [
          Text('거래 선택', style: Theme.of(context).textTheme.headlineSmall),

          // 거래 검색
          SearchBar(
            onChanged: (query) {
              ref.read(transactionsProvider.notifier).search(query);
            },
          ),

          // 거래 목록
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: CategoryIcon(transaction.category),
                  title: Text(transaction.description),
                  subtitle: Text(
                    '${DateFormat('MM/dd').format(transaction.date)} • '
                    '${NumberFormat.currency(locale: 'ko_KR', symbol: '₩').format(transaction.amount)}',
                  ),
                  onTap: () async {
                    await ref.read(noteProvider.notifier).linkTransaction(
                      noteId: noteId,
                      transactionId: transaction.id,
                    );
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 5. UI/UX 디자인

### 5.1 Material Design 3

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),

    // Dynamic Color (Android 12+)
    extensions: [
      CustomColors.light,
    ],

    // Typography
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        fontFamily: 'Pretendard',
      ),
      // ... 기타 텍스트 스타일
    ),

    // Component Themes
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
    ),

    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    // ... 다크 테마 설정
  );
}
```

### 5.2 반응형 레이아웃

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return mobile;
        } else if (constraints.maxWidth < 900) {
          return tablet ?? mobile;
        } else {
          return desktop ?? tablet ?? mobile;
        }
      },
    );
  }
}

// 사용 예시
class NoteHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobile: MobileNoteLayout(),
      tablet: TabletNoteLayout(),
      desktop: DesktopNoteLayout(),
    );
  }
}
```

### 5.3 애니메이션

```dart
class AnimatedNoteCard extends StatelessWidget {
  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _openNote(context),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title),
              Text(note.content),
              Wrap(
                children: note.tags.map((tag) =>
                  TagChip(tag: tag)
                ).toList(),
              ),
            ],
          ),
        ),
      ),
    ).animate()
     .fadeIn(duration: 300.ms, delay: (100 * index).ms)
     .slideY(begin: 0.1, end: 0, duration: 300.ms);
  }
}
```

---

## 6. 플랫폼별 최적화

### 6.1 iOS 최적화

```dart
// iOS 특화 기능
class IOSFeatures {
  // Cupertino 위젯 사용
  static Widget buildIOSStyleDialog() {
    return CupertinoAlertDialog(
      title: Text('메모 삭제'),
      content: Text('이 메모를 삭제하시겠습니까?'),
      actions: [
        CupertinoDialogAction(
          child: Text('취소'),
          onPressed: () {},
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text('삭제'),
          onPressed: () {},
        ),
      ],
    );
  }

  // Haptic Feedback
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  // iOS 스타일 스크롤
  static ScrollPhysics get iosScrollPhysics =>
    const BouncingScrollPhysics();
}
```

### 6.2 Android 최적화

```dart
// Android 특화 기능
class AndroidFeatures {
  // Material You Dynamic Color
  static Future<ColorScheme?> getDynamicColorScheme() async {
    return await DynamicColorPlugin.getCorePalette()
      .then((corePalette) => corePalette?.toColorScheme());
  }

  // Android 백 버튼 처리
  static Widget handleBackButton(Widget child) {
    return WillPopScope(
      onWillPop: () async {
        // 백 버튼 처리 로직
        return true;
      },
      child: child,
    );
  }

  // Android 스타일 스크롤
  static ScrollPhysics get androidScrollPhysics =>
    const ClampingScrollPhysics();
}
```

### 6.3 태블릿 최적화

```dart
class TabletLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    if (isLandscape) {
      // 가로 모드: Master-Detail View
      return Row(
        children: [
          // 사이드바 (폴더 & 태그)
          Container(
            width: 300,
            child: FolderTreePanel(),
          ),

          // 메모 목록
          Expanded(
            flex: 2,
            child: NoteListPanel(),
          ),

          // 메모 상세/에디터
          Expanded(
            flex: 3,
            child: NoteDetailPanel(),
          ),
        ],
      );
    } else {
      // 세로 모드: 2열 그리드
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
        ),
        itemBuilder: (context, index) => NoteCard(),
      );
    }
  }
}
```

---

## 7. 성능 최적화

### 7.1 렌더링 최적화

```dart
// 최적화 전략
class PerformanceOptimizations {
  // 1. const 생성자 사용
  static const Widget loadingIndicator = CircularProgressIndicator();

  // 2. RepaintBoundary 활용
  static Widget optimizedWidget(Widget child) {
    return RepaintBoundary(
      child: child,
    );
  }

  // 3. 이미지 캐싱
  static Widget cachedImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      cacheManager: DefaultCacheManager(),
      memCacheWidth: 500, // 메모리 캐시 크기 제한
    );
  }

  // 4. ListView 최적화
  static Widget optimizedList(List<Note> notes) {
    return ListView.builder(
      itemExtent: 100, // 고정 높이로 성능 향상
      cacheExtent: 500, // 캐시 범위 설정
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return NoteListItem(notes[index]);
      },
    );
  }
}
```

### 7.2 상태 관리 최적화

```dart
// Riverpod 최적화
final optimizedNotesProvider = Provider<List<Note>>((ref) {
  // select로 필요한 부분만 구독
  final notes = ref.watch(
    notesStateProvider.select((state) => state.notes)
  );

  // 메모이제이션
  return notes.where((note) => !note.isDeleted).toList();
});

// 자동 폐기
final autoDisposeProvider = FutureProvider.autoDispose<Note>((ref) async {
  // 사용하지 않을 때 자동으로 메모리 해제
  return fetchNote();
});
```

---

## 8. 보안

### 8.1 데이터 보안

```dart
class SecurityManager {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // 생체 인증
  Future<bool> authenticateBiometric() async {
    final LocalAuthentication auth = LocalAuthentication();

    final bool canCheckBiometrics = await auth.canCheckBiometrics;
    if (!canCheckBiometrics) return false;

    final bool didAuthenticate = await auth.authenticate(
      localizedReason: '메모 앱에 접근하려면 인증이 필요합니다',
      options: AuthenticationOptions(
        biometricOnly: true,
        stickyAuth: true,
      ),
    );

    return didAuthenticate;
  }

  // 데이터 암호화
  Future<String> encryptNote(String content) async {
    final key = await _getOrGenerateKey();
    final encrypter = Encrypter(AES(key));
    final iv = IV.fromSecureRandom(16);

    final encrypted = encrypter.encrypt(content, iv: iv);
    return '${iv.base64}:${encrypted.base64}';
  }

  // 안전한 저장소
  Future<void> saveSecurely(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }
}
```

---

## 9. 테스트 전략

### 9.1 단위 테스트

```dart
// Repository 테스트
void main() {
  group('NoteRepository Tests', () {
    late NoteRepository repository;
    late MockApiClient mockApiClient;
    late MockLocalDatabase mockDatabase;

    setUp(() {
      mockApiClient = MockApiClient();
      mockDatabase = MockLocalDatabase();
      repository = NoteRepositoryImpl(
        apiClient: mockApiClient,
        database: mockDatabase,
      );
    });

    test('should create note successfully', () async {
      // Arrange
      final note = Note(title: 'Test', content: 'Content');
      when(() => mockApiClient.createNote(any()))
        .thenAnswer((_) async => note);

      // Act
      final result = await repository.createNote(note);

      // Assert
      expect(result, equals(note));
      verify(() => mockDatabase.saveNote(note)).called(1);
    });
  });
}
```

### 9.2 위젯 테스트

```dart
// Widget 테스트
void main() {
  testWidgets('NoteCard displays correctly', (WidgetTester tester) async {
    // Arrange
    final note = Note(
      title: 'Test Note',
      content: 'Test Content',
      tags: [Tag(name: 'important', color: 'blue')],
    );

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: NoteCard(note: note),
      ),
    );

    // Assert
    expect(find.text('Test Note'), findsOneWidget);
    expect(find.text('Test Content'), findsOneWidget);
    expect(find.text('important'), findsOneWidget);
  });
}
```

### 9.3 통합 테스트

```dart
// Integration 테스트
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Create and save note flow', (WidgetTester tester) async {
    // 앱 실행
    await tester.pumpWidget(MyApp());

    // FAB 탭
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    // 제목 입력
    await tester.enterText(
      find.byKey(Key('title_field')),
      'Integration Test Note',
    );

    // 내용 입력
    await tester.enterText(
      find.byKey(Key('content_field')),
      'This is test content',
    );

    // 저장
    await tester.tap(find.byIcon(Icons.save));
    await tester.pumpAndSettle();

    // 확인
    expect(find.text('Integration Test Note'), findsOneWidget);
  });
}
```

---

## 10. 배포 전략

### 10.1 CI/CD Pipeline

```yaml
# .github/workflows/flutter.yml
name: Flutter CI/CD

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.16.x"

      - name: Install dependencies
        run: flutter pub get

      - name: Run tests
        run: flutter test

      - name: Build APK
        run: flutter build apk --release

      - name: Build iOS
        if: runner.os == 'macOS'
        run: flutter build ios --release --no-codesign

  deploy:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Play Store
        uses: r0adkll/upload-google-play@v1
        with:
          serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
          packageName: com.worklife.notes
          releaseFiles: build/app/outputs/bundle/release/app-release.aab
          track: production
```

### 10.2 버전 관리

```dart
// pubspec.yaml
version: 1.0.0+1  # Major.Minor.Patch+BuildNumber

// 버전 정보 표시
class AppVersion {
  static Future<String> getVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return '${packageInfo.version} (${packageInfo.buildNumber})';
  }
}
```

---

## 11. 모니터링 & 분석

### 11.1 Firebase 통합

```dart
class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // 이벤트 추적
  Future<void> logEvent(String name, Map<String, dynamic>? parameters) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  // 화면 추적
  Future<void> logScreenView(String screenName) async {
    await _analytics.setCurrentScreen(screenName: screenName);
  }

  // 사용자 속성
  Future<void> setUserProperty(String name, String value) async {
    await _analytics.setUserProperty(name: name, value: value);
  }
}

// Crashlytics
class CrashReporting {
  static void initialize() {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
```

---

## 12. 개발 일정

### Phase 1: 기초 구축 (3주)

- Week 1: 프로젝트 설정, 아키텍처 구성
- Week 2: 인증 시스템, API 연동
- Week 3: 기본 UI 컴포넌트

### Phase 2: 핵심 기능 (5주)

- Week 4-5: 메모 CRUD, 에디터
- Week 6: 폴더/태그 시스템
- Week 7-8: 검색 및 필터링

### Phase 3: 고급 기능 (4주)

- Week 9-10: 오프라인 지원, 동기화
- Week 11: 가계부 연동
- Week 12: 템플릿 시스템

### Phase 4: 최적화 및 출시 (2주)

- Week 13: 성능 최적화, 버그 수정
- Week 14: 스토어 출시 준비

**총 개발 기간: 14주**

---

## 13. 리스크 관리

### 기술적 리스크

| 리스크             | 영향도 | 대응 방안                    |
| ------------------ | ------ | ---------------------------- |
| 동기화 충돌        | 높음   | 3-way merge 알고리즘 구현    |
| 대용량 데이터 처리 | 중간   | 페이지네이션, 가상화 리스트  |
| 플랫폼 간 UI 차이  | 낮음   | Platform.isIOS 조건부 렌더링 |

### 비즈니스 리스크

| 리스크         | 영향도 | 대응 방안               |
| -------------- | ------ | ----------------------- |
| 앱스토어 리젝  | 높음   | 가이드라인 철저 준수    |
| 사용자 이탈    | 중간   | 온보딩 개선, A/B 테스트 |
| 서버 비용 증가 | 낮음   | 캐싱 전략, CDN 활용     |

---

## 14. 성공 지표

### 기술 지표

- 앱 크기 < 30MB
- 콜드 스타트 < 1.5초
- 프레임 렌더링 60fps
- 메모리 사용량 < 150MB
- 크래시율 < 0.5%

### 비즈니스 지표

- MAU 2,000명
- DAU/MAU > 30%
- 7일 리텐션 > 50%
- 평균 세션 시간 > 5분
- 앱스토어 평점 > 4.7

---

## 15. 향후 로드맵

### v1.1 (1개월)

- 음성 메모
- OCR 텍스트 추출
- 위젯 지원

### v1.2 (2개월)

- 협업 기능
- 실시간 동기화
- AI 요약

### v2.0 (6개월)

- 엔드투엔드 암호화
- 플러그인 시스템
- 데스크톱 버전 (Windows, macOS, Linux)

---

**마지막 업데이트**: 2025-01-23  
**작성자**: 개발팀

Flutter로 구현하는 WorkLife Dashboard 메모 앱 - One Codebase, All Platforms! 🚀
