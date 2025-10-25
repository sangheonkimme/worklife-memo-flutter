# WorkLife Dashboard 메모 앱 - Flutter 개발 체크리스트

**프로젝트명**: WorkLife Dashboard 메모 앱
**플랫폼**: Flutter (iOS/Android)
**개발 기간**: 12주 (Flutter의 빠른 개발로 4주 단축)
**시작일**: ____________
**완료 목표**: ____________

---

## 📱 개발 진행 상태

| 단계 | 기간 | 진행률 | 상태 |
|------|------|--------|------|
| Phase 1: 기초 구축 | 2주 | 50% | 🟡 진행 중 |
| Phase 2: 핵심 기능 | 5주 | 0% | 🔴 시작 전 |
| Phase 3: 고급 기능 | 3주 | 0% | 🔴 시작 전 |
| Phase 4: 최적화 및 출시 | 2주 | 0% | 🔴 시작 전 |

**전체 진행률**: 10%

---

## Phase 1: 기초 구축 (Week 1-2)

### Week 1: 프로젝트 설정 및 개발 환경

#### 🛠️ 개발 환경 설정
- [x] Flutter SDK 설치 (최신 stable 버전)
  ```bash
  # macOS
  brew install flutter
  # 또는 https://flutter.dev/docs/get-started/install
  ```
- [x] Flutter Doctor 실행 및 검증
  ```bash
  flutter doctor -v
  ```
- [x] IDE 설정
  - [x] Android Studio 설치
    - [x] Flutter 플러그인
    - [x] Dart 플러그인
  - [x] VSCode 설치 (선택)
    - [x] Flutter 확장
    - [x] Dart 확장
- [x] Android 환경 설정
  - [x] Android SDK 설치
  - [x] Android Studio 에뮬레이터
  - [x] Android 라이선스 동의
    ```bash
    flutter doctor --android-licenses
    ```
- [x] iOS 환경 설정 (Mac)
  - [x] Xcode 설치
  - [x] Xcode Command Line Tools
  - [x] CocoaPods 설치
    ```bash
    sudo gem install cocoapods
    ```
  - [x] iOS 시뮬레이터 설정
- [x] 디버깅 도구
  - [x] Flutter DevTools
  - [x] Dart DevTools

#### 📁 프로젝트 생성
- [x] Flutter 프로젝트 생성
  ```bash
  flutter create worklife_notes_app --org com.yourcompany
  cd worklife_notes_app
  ```
- [x] 프로젝트 폴더 구조 생성
  ```
  lib/
  ├── core/
  │   ├── constants/       # 상수 정의
  │   ├── theme/          # 테마 설정
  │   ├── utils/          # 유틸리티 함수
  │   └── router/         # 라우팅 설정
  ├── data/
  │   ├── models/         # 데이터 모델
  │   ├── repositories/   # 레포지토리
  │   ├── datasources/    # 데이터 소스
  │   └── services/       # API 서비스
  ├── domain/
  │   ├── entities/       # 엔티티
  │   └── usecases/       # 유스케이스
  ├── presentation/
  │   ├── screens/        # 화면
  │   ├── widgets/        # 위젯
  │   ├── providers/      # 상태 관리
  │   └── blocs/          # BLoC (선택)
  └── main.dart
  ```
- [x] pubspec.yaml 설정
  - [x] 앱 이름 및 설명
  - [x] 버전 정보
  - [x] 최소 SDK 버전
- [x] Git 저장소 초기화
- [x] .gitignore 설정

#### 📦 핵심 패키지 설치
- [x] 상태 관리
  ```yaml
  dependencies:
    # Riverpod (권장) 또는 Provider
    flutter_riverpod: ^2.4.0
    # 또는
    # provider: ^6.1.0
  ```
- [x] 네비게이션
  ```yaml
  dependencies:
    go_router: ^12.1.0
  ```
- [x] UI 라이브러리
  ```yaml
  dependencies:
    flutter_screenutil: ^5.9.0  # 반응형 UI
    flutter_svg: ^2.0.9          # SVG 지원
    cached_network_image: ^3.3.0 # 이미지 캐싱
    shimmer: ^3.0.0              # 스켈레톤 로딩
  ```
- [x] HTTP 클라이언트
  ```yaml
  dependencies:
    dio: ^5.4.0                  # HTTP 클라이언트
    retrofit: ^4.0.0             # REST API
  dev_dependencies:
    retrofit_generator: ^7.0.0
    build_runner: ^2.4.0
  ```
- [x] 로컬 스토리지
  ```yaml
  dependencies:
    flutter_secure_storage: ^9.0.0  # 보안 저장소
    shared_preferences: ^2.2.2       # 설정 저장
    hive: ^2.2.3                     # NoSQL DB
    hive_flutter: ^1.1.0
    isar: ^3.1.0                     # 고성능 DB (대안)
    isar_flutter_libs: ^3.1.0
  dev_dependencies:
    hive_generator: ^2.0.1
    # 또는
    isar_generator: ^3.1.0
  ```
- [x] 유틸리티
  ```yaml
  dependencies:
    intl: ^0.18.1                # 국제화 및 날짜 포맷
    uuid: ^4.2.0                 # UUID 생성
    equatable: ^2.0.5            # 객체 비교
    freezed_annotation: ^2.4.1   # 불변 객체
    json_annotation: ^4.8.1      # JSON 직렬화
  dev_dependencies:
    freezed: ^2.4.5
    json_serializable: ^6.7.0
  ```

#### 🎨 디자인 시스템 구축
- [ ] 테마 설정 (lib/core/theme/)
  - [ ] app_theme.dart
    - [ ] ThemeData 정의
    - [ ] ColorScheme 설정
    - [ ] TextTheme 설정
  - [ ] app_colors.dart
    - [ ] 라이트 테마 색상
    - [ ] 다크 테마 색상
    - [ ] 메모 타입별 색상
    - [ ] 시스템 색상
  - [ ] app_typography.dart
    - [ ] 폰트 패밀리
    - [ ] 폰트 크기 스케일
    - [ ] 폰트 굵기
    - [ ] TextStyle 정의
  - [ ] app_spacing.dart
    - [ ] 8px 기반 간격 시스템
    - [ ] padding/margin 상수
  - [ ] app_dimensions.dart
    - [ ] 버튼 높이
    - [ ] 아이콘 크기
    - [ ] 모서리 반경
- [ ] 커스텀 폰트 추가
  - [ ] fonts/ 디렉토리 생성
  - [ ] pubspec.yaml에 폰트 등록
- [ ] 다크 모드 지원
  - [ ] ThemeMode Provider
  - [ ] 테마 토글 위젯

### Week 2: 기본 위젯 및 네비게이션

#### 🧱 기본 위젯 라이브러리 (lib/presentation/widgets/)
- [ ] 버튼 위젯
  - [ ] primary_button.dart
  - [ ] secondary_button.dart
  - [ ] icon_button.dart
  - [ ] fab_button.dart (FloatingActionButton)
  - [ ] 로딩 상태 지원
- [ ] 입력 위젯
  - [ ] custom_text_field.dart
    - [ ] 유효성 검사
    - [ ] 에러 메시지
    - [ ] 프리픽스/서픽스 아이콘
  - [ ] search_field.dart
  - [ ] password_field.dart
- [ ] 카드 위젯
  - [ ] note_card.dart
    - [ ] 메모 미리보기
    - [ ] 태그 칩 표시
    - [ ] 스와이프 액션
  - [ ] folder_card.dart
  - [ ] stats_card.dart
- [ ] 로딩 위젯
  - [ ] loading_spinner.dart
  - [ ] skeleton_loader.dart (shimmer 사용)
  - [ ] progress_indicator.dart
- [ ] 모달 위젯
  - [ ] bottom_sheet_modal.dart
  - [ ] custom_dialog.dart
  - [ ] action_sheet.dart
- [ ] 공통 위젯
  - [ ] empty_state.dart
  - [ ] error_widget.dart
  - [ ] tag_chip.dart
  - [ ] avatar.dart

#### 🧭 네비게이션 구조 (go_router)
- [ ] 라우터 설정 (lib/core/router/app_router.dart)
  ```dart
  final goRouter = GoRouter(
    initialLocation: '/',
    routes: [...]
  );
  ```
- [ ] 인증 전 라우트
  - [ ] /splash - 스플래시 화면
  - [ ] /onboarding - 온보딩
  - [ ] /login - 로그인
  - [ ] /register - 회원가입
  - [ ] /forgot-password - 비밀번호 찾기
- [ ] 메인 라우트 (인증 후)
  - [ ] /home - 홈 (바텀 네비게이션)
    - [ ] /notes - 메모 목록
    - [ ] /folders - 폴더 목록
    - [ ] /search - 검색
    - [ ] /settings - 설정
  - [ ] /note/new - 메모 작성
  - [ ] /note/:id - 메모 상세
  - [ ] /note/:id/edit - 메모 수정
  - [ ] /folder/:id - 폴더 상세
- [ ] 라우트 가드
  - [ ] 인증 체크
  - [ ] 리다이렉트 로직
- [ ] 딥 링킹 설정
  - [ ] Android: AndroidManifest.xml
  - [ ] iOS: Info.plist

#### 🎭 스플래시 및 온보딩
- [ ] 스플래시 스크린
  - [ ] native_splash 패키지 사용
    ```yaml
    dev_dependencies:
      flutter_native_splash: ^2.3.0
    ```
  - [ ] flutter_native_splash.yaml 설정
  - [ ] 앱 초기화 로직
- [ ] 온보딩 스크린
  - [ ] intro_slider 또는 직접 구현
  - [ ] 페이지 인디케이터
  - [ ] 건너뛰기 버튼
  - [ ] 완료 시 SharedPreferences 저장

---

## Phase 2: 핵심 기능 (Week 3-7)

### Week 3: 인증 시스템 및 API 연동

#### 🔐 인증 화면 구현
- [ ] 로그인 화면 (lib/presentation/screens/auth/)
  - [ ] login_screen.dart
  - [ ] 폼 유효성 검사 (flutter_form_builder)
  - [ ] 에러 처리
  - [ ] 로딩 상태
- [ ] 회원가입 화면
  - [ ] register_screen.dart
  - [ ] 다단계 폼 또는 단일 폼
  - [ ] 약관 동의 체크박스
  - [ ] 이메일 형식 검증
- [ ] 비밀번호 찾기
  - [ ] forgot_password_screen.dart
- [ ] 자동 로그인
  - [ ] flutter_secure_storage로 토큰 저장
  - [ ] 앱 시작 시 토큰 확인
  - [ ] 토큰 자동 갱신
- [ ] 생체 인증
  ```yaml
  dependencies:
    local_auth: ^2.1.7
  ```
  - [ ] Face ID / Touch ID (iOS)
  - [ ] 지문 인증 (Android)
  - [ ] 폴백 처리 (PIN 코드)

#### 🔌 API 클라이언트 설정
- [ ] Dio 설정 (lib/data/services/)
  ```dart
  // dio_client.dart
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.worklife.com',
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));
  ```
- [ ] Retrofit API 정의
  ```dart
  // api_service.dart
  @RestApi(baseUrl: "https://api.worklife.com")
  abstract class ApiService {
    factory ApiService(Dio dio) = _ApiService;

    @POST("/auth/login")
    Future<LoginResponse> login(@Body() LoginRequest request);

    @GET("/notes")
    Future<List<Note>> getNotes();
    // ... 기타 엔드포인트
  }
  ```
- [ ] API 엔드포인트 정의
  - [ ] /api/auth/* (로그인, 회원가입, 토큰 갱신)
  - [ ] /api/notes/* (메모 CRUD)
  - [ ] /api/folders/* (폴더 CRUD)
  - [ ] /api/tags/* (태그 CRUD)
  - [ ] /api/templates/* (템플릿 CRUD)
- [ ] Interceptor 설정
  - [ ] Request Interceptor
    - [ ] 토큰 자동 첨부
    - [ ] 요청 로깅
  - [ ] Response Interceptor
    - [ ] 에러 처리
    - [ ] 401 시 토큰 갱신
    - [ ] 응답 로깅
- [ ] 에러 핸들링
  - [ ] NetworkException
  - [ ] ServerException
  - [ ] UnauthorizedException

#### 🏗️ 상태 관리 설정 (Riverpod)
- [ ] Provider 구조 (lib/presentation/providers/)
  - [ ] auth_provider.dart
    ```dart
    final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
      return AuthNotifier(ref.read(authRepositoryProvider));
    });
    ```
  - [ ] notes_provider.dart
  - [ ] folders_provider.dart
  - [ ] tags_provider.dart
  - [ ] theme_provider.dart
- [ ] Repository 패턴
  - [ ] lib/data/repositories/
    - [ ] auth_repository.dart
    - [ ] notes_repository.dart
    - [ ] folders_repository.dart
- [ ] State 정의 (Freezed 사용)
  ```dart
  @freezed
  class AuthState with _$AuthState {
    const factory AuthState.initial() = _Initial;
    const factory AuthState.loading() = _Loading;
    const factory AuthState.authenticated(User user) = _Authenticated;
    const factory AuthState.unauthenticated() = _Unauthenticated;
    const factory AuthState.error(String message) = _Error;
  }
  ```
- [ ] 로컬 스토리지 연동
  - [ ] Hive 초기화
  - [ ] Adapter 생성
  - [ ] Box 열기

### Week 4-5: 메모 CRUD 및 에디터

#### 📝 메모 에디터 구현
- [ ] 기본 텍스트 에디터
  - [ ] note_editor_screen.dart
  - [ ] TextField with maxLines: null
  - [ ] 자동 저장 (debounce 3초)
    ```yaml
    dependencies:
      rxdart: ^0.27.7  # debounce용
    ```
  - [ ] 문자 수 카운터
  - [ ] 실행 취소/재실행
- [ ] 리치 텍스트 에디터
  ```yaml
  dependencies:
    flutter_quill: ^9.0.0      # Quill 에디터
    # 또는
    appflowy_editor: ^2.0.0    # AppFlowy 에디터
  ```
  - [ ] 마크다운 지원
  - [ ] 에디터 툴바
    - [ ] 굵게, 기울임, 밑줄
    - [ ] 제목 스타일
    - [ ] 리스트
    - [ ] 링크
  - [ ] 미리보기 모드
    ```yaml
    dependencies:
      flutter_markdown: ^0.6.18
    ```
- [ ] 체크리스트 에디터
  - [ ] checklist_editor.dart
  - [ ] 항목 추가/삭제
  - [ ] 체크 상태 토글
  - [ ] 드래그 앤 드롭 정렬
    ```yaml
    dependencies:
      reorderable_list: ^2.0.0
    ```
  - [ ] 진행률 표시 (Linear Progress Indicator)
- [ ] 빠른 메모 모드
  - [ ] 간소화된 UI
  - [ ] 즉시 저장
  - [ ] 플로팅 위젯

#### 📋 메모 목록 화면
- [ ] 메모 목록 스크린 (notes_list_screen.dart)
  - [ ] ListView.builder 또는 CustomScrollView
  - [ ] Sliver 최적화
  - [ ] 무한 스크롤 (pagination)
    ```yaml
    dependencies:
      infinite_scroll_pagination: ^4.0.0
    ```
  - [ ] 당겨서 새로고침
    ```dart
    RefreshIndicator(
      onRefresh: () async { ... }
    )
    ```
- [ ] 메모 카드 위젯
  - [ ] note_list_item.dart
  - [ ] 제목/내용 미리보기 (최대 3줄)
  - [ ] 태그 칩 표시 (Wrap + Chip)
  - [ ] 메모 타입 아이콘
  - [ ] 날짜 포맷팅 (intl 패키지)
  - [ ] 즐겨찾기/고정 아이콘
- [ ] 보기 모드 전환
  - [ ] 리스트 뷰
  - [ ] 그리드 뷰 (GridView.builder)
  - [ ] 컴팩트 뷰
  - [ ] SharedPreferences에 설정 저장
- [ ] 스와이프 액션
  ```yaml
  dependencies:
    flutter_slidable: ^3.0.0
  ```
  - [ ] 왼쪽 스와이프: 보관
  - [ ] 오른쪽 스와이프: 삭제
  - [ ] 커스터마이징 가능
- [ ] 다중 선택 모드
  - [ ] 길게 눌러 활성화
  - [ ] 체크박스 표시
  - [ ] 일괄 작업 버튼 (삭제, 이동, 보관)
  - [ ] 선택 카운터 (AppBar에 표시)

#### 💾 메모 CRUD API 연동
- [ ] 데이터 모델 정의 (Freezed + JSON)
  ```dart
  @freezed
  class Note with _$Note {
    const factory Note({
      required String id,
      required String title,
      required String content,
      required NoteType type,
      List<String>? tags,
      DateTime? createdAt,
      DateTime? updatedAt,
    }) = _Note;

    factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
  }
  ```
- [ ] Repository 구현
  - [ ] NotesRepository
    - [ ] Future<List<Note>> getNotes()
    - [ ] Future<Note> getNoteById(String id)
    - [ ] Future<Note> createNote(Note note)
    - [ ] Future<Note> updateNote(Note note)
    - [ ] Future<void> deleteNote(String id)
    - [ ] Future<void> pinNote(String id)
    - [ ] Future<void> favoriteNote(String id)
    - [ ] Future<void> archiveNote(String id)
- [ ] Provider 구현
  - [ ] notesProvider (전체 메모 목록)
  - [ ] noteDetailProvider (특정 메모)
  - [ ] createNoteProvider (메모 생성)
  - [ ] 낙관적 업데이트
- [ ] 로컬 캐싱
  - [ ] Hive에 메모 저장
  - [ ] 캐시 우선 전략
  - [ ] 백그라운드 동기화

### Week 6: 폴더 및 태그 시스템

#### 📁 폴더 관리
- [ ] 폴더 목록 화면
  - [ ] folders_screen.dart
  - [ ] 트리 구조 표시
  - [ ] 확장/축소 애니메이션
  - [ ] 폴더별 메모 개수 뱃지
- [ ] 폴더 트리 위젯
  - [ ] folder_tree_widget.dart
  - [ ] 재귀적 렌더링
  - [ ] 중첩 폴더 (최대 3단계)
  - [ ] 폴더 아이콘 및 색상
- [ ] 폴더 생성 다이얼로그
  - [ ] create_folder_dialog.dart
  - [ ] 이름 입력
  - [ ] 색상 선택기
    ```yaml
    dependencies:
      flutter_colorpicker: ^1.0.3
    ```
  - [ ] 아이콘 선택기
  - [ ] 부모 폴더 선택 (드롭다운)
- [ ] 폴더 수정/삭제
  - [ ] 길게 눌러 메뉴 표시
  - [ ] BottomSheet 또는 Dialog
  - [ ] 이름 변경
  - [ ] 삭제 확인 다이얼로그
  - [ ] 하위 메모 처리 (이동 또는 삭제)
- [ ] 드래그 앤 드롭
  ```yaml
  dependencies:
    drag_and_drop_lists: ^0.4.0
  ```
  - [ ] 폴더 순서 변경
  - [ ] 메모를 폴더로 이동
  - [ ] 시각적 피드백 (elevation, opacity)

#### 🏷️ 태그 시스템
- [ ] 태그 입력 위젯
  - [ ] tag_input_field.dart
  - [ ] Autocomplete 위젯 사용
  - [ ] 칩 형태로 표시
    ```dart
    Wrap(
      children: tags.map((tag) => Chip(...)).toList()
    )
    ```
  - [ ] X 버튼으로 제거
  - [ ] 새 태그 생성
- [ ] 태그 관리 화면
  - [ ] tags_management_screen.dart
  - [ ] 태그 목록 (ListView)
  - [ ] 사용 빈도 표시
  - [ ] 태그 색상 변경
  - [ ] 태그 삭제
  - [ ] 태그 병합 기능
- [ ] 태그 색상 시스템
  - [ ] 12가지 프리셋 색상
  - [ ] 색상 선택 다이얼로그
  - [ ] 색상별 그룹핑
- [ ] 태그 클라우드 위젯
  - [ ] tag_cloud_widget.dart
  - [ ] 빈도별 크기 조정 (fontSize)
  - [ ] 탭하여 필터링
  - [ ] 애니메이션 효과

#### 🗂️ API 연동
- [ ] 폴더 모델 및 Repository
  ```dart
  @freezed
  class Folder with _$Folder {
    const factory Folder({
      required String id,
      required String name,
      String? parentId,
      Color? color,
      IconData? icon,
      int? noteCount,
    }) = _Folder;
  }
  ```
  - [ ] FoldersRepository
  - [ ] foldersProvider
- [ ] 태그 모델 및 Repository
  ```dart
  @freezed
  class Tag with _$Tag {
    const factory Tag({
      required String id,
      required String name,
      Color? color,
      int? usageCount,
    }) = _Tag;
  }
  ```
  - [ ] TagsRepository
  - [ ] tagsProvider
  - [ ] tagSuggestionsProvider (자동완성용)

### Week 7: 검색 및 필터링

#### 🔍 검색 기능
- [ ] 검색 화면
  - [ ] search_screen.dart
  - [ ] SearchDelegate 또는 커스텀 AppBar
  - [ ] 실시간 검색
  - [ ] 디바운스 (300ms - rxdart)
- [ ] 검색 바 위젯
  - [ ] search_bar.dart
  - [ ] 검색어 입력
  - [ ] 클리어 버튼
  - [ ] 음성 검색 (선택)
    ```yaml
    dependencies:
      speech_to_text: ^6.5.0
    ```
- [ ] 검색 히스토리
  - [ ] SharedPreferences에 저장
  - [ ] 최근 검색어 표시 (최대 10개)
  - [ ] 검색어 삭제
  - [ ] 검색어 탭하여 재검색
- [ ] 검색 결과 화면
  - [ ] 결과 개수 표시
  - [ ] 검색어 하이라이팅
    ```yaml
    dependencies:
      flutter_highlight: ^0.7.0
    ```
  - [ ] 정렬 옵션 (관련도, 날짜)
  - [ ] 필터 칩 표시
- [ ] 전문 검색 구현
  - [ ] 제목 검색
  - [ ] 내용 검색
  - [ ] 태그 검색
  - [ ] 복합 검색 (AND, OR)

#### 🎯 필터링 시스템
- [ ] 필터 모달
  - [ ] filter_bottom_sheet.dart
  - [ ] showModalBottomSheet 사용
  - [ ] 다중 필터 선택
    - [ ] 날짜 범위
      ```yaml
      dependencies:
        syncfusion_flutter_datepicker: ^24.1.0
      ```
    - [ ] 메모 타입 (체크박스)
    - [ ] 폴더 (드롭다운)
    - [ ] 태그 (칩 선택)
  - [ ] 필터 초기화 버튼
  - [ ] 적용 버튼
- [ ] 정렬 옵션
  - [ ] sort_option_sheet.dart
  - [ ] 라디오 버튼 그룹
    - [ ] 최신순
    - [ ] 오래된순
    - [ ] 이름순 (가나다순)
    - [ ] 수정일순
    - [ ] 인기순 (조회수)
- [ ] 빠른 필터 버튼
  - [ ] quick_filter_chips.dart
  - [ ] 필터 칩 (FilterChip)
    - [ ] 즐겨찾기만
    - [ ] 고정된 메모만
    - [ ] 최근 7일
    - [ ] 보관함
  - [ ] 선택된 필터 강조 표시

#### 🔎 로컬 검색 최적화
- [ ] Hive 인덱싱
  - [ ] 제목 인덱스
  - [ ] 내용 인덱스
  - [ ] 태그 인덱스
- [ ] 검색 알고리즘
  - [ ] 퍼지 검색 (fuzzy search)
    ```yaml
    dependencies:
      fuzzy: ^0.5.0
    ```
  - [ ] 가중치 기반 랭킹
- [ ] 검색 결과 캐싱
  - [ ] Provider에서 캐싱
  - [ ] 검색어별 결과 저장

---

## Phase 3: 고급 기능 (Week 8-10)

### Week 8-9: 오프라인 지원 및 동기화

#### 💾 로컬 데이터베이스 (Isar 또는 Hive)
- [ ] Isar 설정 (권장 - 고성능)
  ```yaml
  dependencies:
    isar: ^3.1.0
    isar_flutter_libs: ^3.1.0
  dev_dependencies:
    isar_generator: ^3.1.0
  ```
  - [ ] Isar 인스턴스 초기화
  - [ ] 스키마 정의
    ```dart
    @collection
    class NoteEntity {
      Id id = Isar.autoIncrement;
      late String noteId;
      late String title;
      late String content;
      @Index()
      late DateTime createdAt;
      // ... 기타 필드
    }
    ```
  - [ ] 인덱스 설정
  - [ ] 쿼리 최적화
- [ ] 또는 Hive 설정
  ```dart
  @HiveType(typeId: 0)
  class Note extends HiveObject {
    @HiveField(0)
    late String id;
    @HiveField(1)
    late String title;
    // ...
  }
  ```
- [ ] 데이터 모델 매핑
  - [ ] API 모델 ↔ 로컬 모델
  - [ ] 변환 함수 (toEntity, fromEntity)
- [ ] CRUD 작업
  - [ ] 로컬 생성/읽기/수정/삭제
  - [ ] 배치 작업
  - [ ] 트랜잭션

#### 🔄 동기화 엔진
- [ ] 동기화 매니저 (lib/data/services/sync/)
  - [ ] sync_manager.dart
  - [ ] 변경 감지 (dirty flag)
  - [ ] 큐 관리 (동기화 대기 목록)
  - [ ] 충돌 해결 전략
    - [ ] 서버 우선
    - [ ] 클라이언트 우선
    - [ ] 최신 수정 우선
    - [ ] 수동 해결
  - [ ] 재시도 로직 (exponential backoff)
- [ ] 백그라운드 동기화
  ```yaml
  dependencies:
    workmanager: ^0.5.1  # 백그라운드 작업
  ```
  - [ ] 주기적 동기화 (15분마다)
  - [ ] 와이파이 전용 옵션
  - [ ] 배터리 절약 모드 감지
    ```yaml
    dependencies:
      battery_plus: ^5.0.0
    ```
- [ ] 동기화 상태 UI
  - [ ] sync_indicator.dart
  - [ ] 동기화 중 아이콘 (회전 애니메이션)
  - [ ] 동기화 완료 토스트
  - [ ] 충돌 알림 다이얼로그
  - [ ] 수동 동기화 버튼

#### 🔐 오프라인 모드
- [ ] 네트워크 상태 감지
  ```yaml
  dependencies:
    connectivity_plus: ^5.0.0
  ```
  - [ ] ConnectivityProvider
  - [ ] 네트워크 변경 감지
  - [ ] 오프라인/온라인 이벤트
- [ ] 오프라인 배너
  - [ ] offline_banner.dart
  - [ ] 상단 배너 표시
  - [ ] 재시도 버튼
- [ ] 오프라인 작업 큐
  - [ ] offline_queue.dart
  - [ ] 작업 저장 (로컬 DB)
  - [ ] 온라인 복귀 시 자동 실행
  - [ ] 실패 시 재시도
- [ ] 캐싱 전략
  - [ ] 이미지 캐싱
    ```yaml
    dependencies:
      cached_network_image: ^3.3.0
      flutter_cache_manager: ^3.3.1
    ```
  - [ ] API 응답 캐싱
  - [ ] 캐시 만료 정책 (TTL)
  - [ ] 캐시 크기 제한

### Week 10: 가계부 연동 및 미디어

#### 💰 가계부 연동
- [ ] 거래 선택 모달
  - [ ] transaction_picker_screen.dart
  - [ ] 거래 목록 API 연동
  - [ ] 검색/필터
  - [ ] 다중 선택 (MultiSelectChip)
  - [ ] 날짜별 그룹핑
- [ ] 연결된 거래 표시
  - [ ] linked_transaction_card.dart
  - [ ] 거래 정보 표시
    - [ ] 금액 (NumberFormat)
    - [ ] 날짜
    - [ ] 카테고리 아이콘
    - [ ] 메모
  - [ ] 연결 해제 버튼
- [ ] 거래 메모 API
  - [ ] linkTransaction(noteId, transactionId)
  - [ ] unlinkTransaction(noteId, transactionId)
  - [ ] getTransactionNotes(transactionId)

#### 📷 미디어 처리
- [ ] 이미지 선택
  ```yaml
  dependencies:
    image_picker: ^1.0.5
  ```
  - [ ] 갤러리에서 선택
  - [ ] 카메라 촬영
  - [ ] 다중 선택
  - [ ] 권한 처리
    ```yaml
    dependencies:
      permission_handler: ^11.1.0
    ```
- [ ] 이미지 편집
  ```yaml
  dependencies:
    image_cropper: ^5.0.0
    image: ^4.1.3  # 이미지 처리
  ```
  - [ ] 크롭
  - [ ] 회전
  - [ ] 압축
  - [ ] 리사이즈
- [ ] 이미지 업로드
  - [ ] 멀티파트 폼 데이터 (Dio)
  - [ ] 업로드 진행률 표시
    ```dart
    onSendProgress: (sent, total) {
      setState(() => progress = sent / total);
    }
    ```
  - [ ] 실패 재시도
- [ ] 이미지 뷰어
  ```yaml
  dependencies:
    photo_view: ^0.14.0
  ```
  - [ ] 핀치 줌
  - [ ] 전체화면 모드
  - [ ] 스와이프 제스처 (여러 이미지 전환)
  - [ ] 이미지 다운로드

#### 📄 템플릿 시스템
- [ ] 템플릿 목록 화면
  - [ ] templates_screen.dart
  - [ ] 기본 템플릿 (5개 프리셋)
  - [ ] 사용자 템플릿
  - [ ] 템플릿 미리보기
  - [ ] 그리드 레이아웃
- [ ] 템플릿 생성
  - [ ] create_template_dialog.dart
  - [ ] 현재 메모를 템플릿으로 저장
  - [ ] 템플릿 이름/설명
  - [ ] 템플릿 아이콘 선택
- [ ] 템플릿 적용
  - [ ] 변수 치환
    - [ ] {{date}} → 현재 날짜
    - [ ] {{time}} → 현재 시간
    - [ ] {{user}} → 사용자 이름
  - [ ] 자동 입력
  - [ ] 커스터마이징 옵션
- [ ] 템플릿 API
  - [ ] TemplatesRepository
  - [ ] templatesProvider

#### 🎨 추가 기능
- [ ] 메모 공유
  ```yaml
  dependencies:
    share_plus: ^7.2.0
  ```
  - [ ] 텍스트 공유
  - [ ] 링크 공유
  - [ ] 이미지와 함께 공유
  - [ ] 소셜 미디어 선택
- [ ] 내보내기
  ```yaml
  dependencies:
    pdf: ^3.10.7
    printing: ^5.11.1
    path_provider: ^2.1.1
  ```
  - [ ] PDF 내보내기
  - [ ] Markdown 내보내기
  - [ ] 텍스트 파일
  - [ ] 파일 저장 위치 선택
- [ ] 알림 기능
  ```yaml
  dependencies:
    flutter_local_notifications: ^16.3.0
  ```
  - [ ] 로컬 알림 설정
  - [ ] 알림 스케줄링
  - [ ] 메모 리마인더
- [ ] 위젯 (선택)
  - [ ] 홈 스크린 위젯
    - [ ] iOS: WidgetKit (native)
    - [ ] Android: home_widget 패키지

---

## Phase 4: 최적화 및 출시 (Week 11-12)

### Week 11: 성능 최적화 및 테스트

#### ⚡ 성능 최적화
- [ ] 렌더링 최적화
  - [ ] const 생성자 사용
  - [ ] RepaintBoundary 활용
  - [ ] ListView.builder의 itemExtent 지정
  - [ ] AutomaticKeepAliveClientMixin (탭 상태 유지)
  - [ ] Selector (Provider 부분 업데이트)
- [ ] 빌드 최적화
  - [ ] Flutter DevTools Profiler 분석
  - [ ] 불필요한 rebuild 제거
  - [ ] Stateless vs Stateful 선택
  - [ ] 위젯 분할 (extract widget)
- [ ] 메모리 관리
  - [ ] 메모리 누수 체크
  - [ ] 이미지 캐시 제한 설정
  - [ ] dispose() 구현
  - [ ] Stream/Controller 정리
- [ ] 앱 크기 최적화
  - [ ] --split-per-abi 빌드
    ```bash
    flutter build apk --split-per-abi
    ```
  - [ ] 미사용 리소스 제거
  - [ ] 이미지 최적화 (WebP)
  - [ ] Font subset
- [ ] 네트워크 최적화
  - [ ] API 호출 최소화
  - [ ] 페이지네이션
  - [ ] 이미지 lazy loading
  - [ ] HTTP/2 활용

#### 🧪 테스트
- [ ] 단위 테스트
  ```yaml
  dev_dependencies:
    test: ^1.24.0
    mockito: ^5.4.0
  ```
  - [ ] 유틸리티 함수 테스트
  - [ ] Repository 테스트
  - [ ] Provider/Notifier 테스트
  - [ ] 비즈니스 로직 테스트
- [ ] 위젯 테스트
  ```yaml
  dev_dependencies:
    flutter_test:
      sdk: flutter
  ```
  - [ ] 위젯 렌더링 테스트
  - [ ] 사용자 상호작용 테스트
  - [ ] 스냅샷 테스트
- [ ] 통합 테스트
  ```yaml
  dev_dependencies:
    integration_test:
      sdk: flutter
  ```
  - [ ] 메모 작성 플로우
  - [ ] 검색 기능
  - [ ] 오프라인 모드
  - [ ] 동기화
- [ ] Golden 테스트 (선택)
  ```yaml
  dev_dependencies:
    golden_toolkit: ^0.15.0
  ```

#### 🐛 버그 수정 및 QA
- [ ] 크래시 리포팅
  ```yaml
  dependencies:
    sentry_flutter: ^7.14.0
    # 또는
    firebase_crashlytics: ^3.4.0
  ```
  - [ ] Sentry 또는 Crashlytics 설정
  - [ ] 에러 보고 자동화
- [ ] UI/UX 버그 수정
  - [ ] 레이아웃 오버플로우
  - [ ] 키보드 처리 (resizeToAvoidBottomInset)
  - [ ] 다크 모드 대비
- [ ] 엣지 케이스 처리
  - [ ] 빈 상태
  - [ ] 로딩 상태
  - [ ] 에러 상태
  - [ ] 대용량 데이터
- [ ] 접근성
  - [ ] Semantics 위젯
  - [ ] Screen reader 지원
  - [ ] 폰트 스케일링
  - [ ] 색상 대비 (WCAG AA)

### Week 12: 출시 준비 및 배포

#### 📱 앱 메타데이터
- [ ] pubspec.yaml 최종 설정
  ```yaml
  name: worklife_notes_app
  description: "WorkLife Dashboard 메모 앱"
  version: 1.0.0+1
  ```
- [ ] 앱 이름 및 설명
  - [ ] 한국어 (주)
  - [ ] 영어 (부)
- [ ] 개인정보 처리방침 작성
- [ ] 이용 약관 작성

#### 🎨 스토어 자산
- [ ] 앱 아이콘
  - [ ] 1024x1024 (iOS)
  - [ ] 512x512 (Android)
  - [ ] flutter_launcher_icons 사용
    ```yaml
    dev_dependencies:
      flutter_launcher_icons: ^0.13.0
    flutter_icons:
      android: true
      ios: true
      image_path: "assets/icon.png"
    ```
    ```bash
    flutter pub run flutter_launcher_icons
    ```
- [ ] 스플래시 스크린
  - [ ] flutter_native_splash 설정 완료
- [ ] 스크린샷 준비
  - [ ] iPhone (6.7", 6.5", 5.5")
  - [ ] iPad Pro (12.9", 11")
  - [ ] Android 폰 (다양한 해상도)
  - [ ] Android 태블릿
- [ ] 프로모션 자산
  - [ ] Feature Graphic (1024x500 - Android)
  - [ ] App Preview Video (선택)

#### 🔧 빌드 및 배포

**iOS 빌드**
- [ ] Apple Developer 계정 ($99/년)
- [ ] App Store Connect 앱 등록
- [ ] Bundle ID 설정
  - [ ] ios/Runner.xcodeproj 또는 Xcode에서
- [ ] 빌드 설정
  ```bash
  flutter build ios --release
  ```
- [ ] Xcode에서 Archive
  - [ ] Product > Archive
  - [ ] Validate App
  - [ ] Distribute App
- [ ] TestFlight 베타 테스트
  - [ ] 내부 테스터 초대
  - [ ] 외부 테스터 초대 (선택)
- [ ] App Store 제출
  - [ ] 스토어 리스팅 작성
  - [ ] 가격 설정 (무료)
  - [ ] 심사 정보 입력
  - [ ] 제출 (Submit for Review)

**Android 빌드**
- [ ] Google Play Console 계정 ($25 일회성)
- [ ] 앱 생성
- [ ] 서명 키 생성
  ```bash
  keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
  ```
- [ ] android/key.properties 설정
  ```properties
  storePassword=<password>
  keyPassword=<password>
  keyAlias=upload
  storeFile=/Users/<user>/upload-keystore.jks
  ```
- [ ] android/app/build.gradle 서명 설정
- [ ] App Bundle 빌드
  ```bash
  flutter build appbundle --release
  ```
- [ ] 내부 테스트 트랙 업로드
- [ ] 클로즈드 테스트 (선택)
- [ ] 프로덕션 출시
  - [ ] 스토어 리스팅 작성
  - [ ] 콘텐츠 등급
  - [ ] 가격 설정
  - [ ] 국가 선택
  - [ ] 출시

#### 📊 모니터링 설정
- [ ] Firebase 프로젝트 생성
  ```bash
  flutter pub add firebase_core
  flutter pub add firebase_analytics
  flutterfire configure
  ```
- [ ] Analytics
  - [ ] Firebase Analytics 설정
  - [ ] 커스텀 이벤트 추적
  - [ ] 사용자 속성
  - [ ] 전환 추적
- [ ] Crashlytics
  ```yaml
  dependencies:
    firebase_crashlytics: ^3.4.0
  ```
  - [ ] 크래시 리포트
  - [ ] 커스텀 로그
  - [ ] 사용자 ID 설정
- [ ] Performance Monitoring
  ```yaml
  dependencies:
    firebase_performance: ^0.9.3
  ```
  - [ ] 앱 시작 시간
  - [ ] 네트워크 요청 추적
  - [ ] 커스텀 트레이스
- [ ] Remote Config (선택)
  ```yaml
  dependencies:
    firebase_remote_config: ^4.3.0
  ```
  - [ ] 기능 플래그
  - [ ] A/B 테스트

#### 🚀 출시 후 계획
- [ ] 사용자 피드백 수집
  - [ ] 인앱 피드백 폼
  - [ ] 스토어 리뷰 모니터링
  - [ ] 이메일 지원
- [ ] 버그 핫픽스 프로세스
  - [ ] 긴급 패치 배포
  - [ ] 우선순위 관리
- [ ] 마케팅
  - [ ] 블로그 포스트
  - [ ] 소셜 미디어 (X, 인스타그램)
  - [ ] 프로덕트 헌트 (선택)
- [ ] 다음 버전 계획
  - [ ] 기능 로드맵
  - [ ] 사용자 요청 분석

---

## 🎯 품질 체크리스트

### 기능 완성도
- [ ] 모든 핵심 기능 구현 완료
- [ ] 오프라인 모드 정상 작동
- [ ] 동기화 안정성 확보
- [ ] 가계부 연동 정상 작동
- [ ] iOS/Android 동일한 UX

### 성능 지표
- [ ] 앱 크기 < 25MB (Flutter 최적화)
- [ ] 콜드 스타트 < 1.5초
- [ ] 메모리 사용량 < 120MB
- [ ] 크래시율 < 0.3%
- [ ] 60fps 유지 (Flutter의 장점)

### 사용성
- [ ] 머티리얼 디자인 3 준수
- [ ] 일관된 디자인 시스템
- [ ] 부드러운 애니메이션
- [ ] 빠른 반응성
- [ ] 직관적인 네비게이션

### 접근성
- [ ] Screen reader 지원 (Semantics)
- [ ] 동적 폰트 크기 (MediaQuery.textScaleFactor)
- [ ] 고대비 모드
- [ ] 키보드 네비게이션
- [ ] 터치 타겟 최소 48x48

### 보안
- [ ] 생체 인증 구현
- [ ] 데이터 암호화 (Hive/Isar)
- [ ] 안전한 토큰 저장 (flutter_secure_storage)
- [ ] HTTPS 전용
- [ ] SSL Certificate Pinning (선택)

---

## 📊 Flutter의 장점

### 개발 속도
- ✅ Hot Reload/Hot Restart로 즉각 피드백
- ✅ 단일 코드베이스로 iOS/Android 동시 개발
- ✅ 풍부한 위젯 라이브러리
- ✅ 빠른 개발 주기 (12주)

### 성능
- ✅ 네이티브 수준의 성능 (Dart AOT 컴파일)
- ✅ 60fps/120fps 부드러운 애니메이션
- ✅ 작은 앱 크기
- ✅ 빠른 시작 시간

### 개발 경험
- ✅ 선언형 UI (React와 유사)
- ✅ 강력한 타입 시스템 (Dart)
- ✅ 풍부한 패키지 생태계 (pub.dev)
- ✅ 우수한 문서 및 커뮤니티

### 플랫폼 일관성
- ✅ iOS/Android 동일한 UI/UX
- ✅ 픽셀 퍼펙트 디자인
- ✅ 플랫폼별 커스터마이징 가능
- ✅ Material/Cupertino 위젯 제공

---

## 📝 주차별 진행률

| 주차 | 계획 | 완료 | 진행률 | 메모 |
|------|------|------|--------|------|
| Week 1 | 환경 설정 및 프로젝트 생성 | | 0% | |
| Week 2 | 기본 위젯 및 네비게이션 | | 0% | |
| Week 3 | 인증 시스템 및 API | | 0% | |
| Week 4 | 메모 에디터 | | 0% | |
| Week 5 | 메모 목록 및 CRUD | | 0% | |
| Week 6 | 폴더 및 태그 | | 0% | |
| Week 7 | 검색 및 필터링 | | 0% | |
| Week 8 | 로컬 DB 및 오프라인 | | 0% | |
| Week 9 | 동기화 엔진 | | 0% | |
| Week 10 | 가계부 연동, 미디어, 템플릿 | | 0% | |
| Week 11 | 성능 최적화 및 테스트 | | 0% | |
| Week 12 | 출시 준비 및 배포 | | 0% | |

**전체 진행률**: 0%

---

## 🔗 중요 링크

### Flutter 관련
- **Flutter 문서**: https://docs.flutter.dev
- **Dart 문서**: https://dart.dev/guides
- **pub.dev**: https://pub.dev (패키지 저장소)
- **Flutter Packages**: https://pub.dev/flutter
- **Flutter Community**: https://flutter.dev/community

### 프로젝트 관련
- **GitHub Repository**: ____________
- **API 문서**: ____________
- **디자인 파일**: ____________
- **테스트 서버**: ____________

### 유용한 리소스
- **Flutter Awesome**: https://flutterawesome.com
- **Flutter Gems**: https://fluttergems.dev
- **Material Design 3**: https://m3.material.io
- **Riverpod 문서**: https://riverpod.dev

---

## 📅 마일스톤

| 마일스톤 | 목표 날짜 | 상태 | 완료 날짜 |
|----------|----------|------|----------|
| 프로젝트 킥오프 | | 🔴 | |
| Phase 1 완료 | | 🔴 | |
| Phase 2 완료 | | 🔴 | |
| Phase 3 완료 | | 🔴 | |
| Phase 4 완료 | | 🔴 | |
| TestFlight/내부 테스트 | | 🔴 | |
| 베타 테스트 | | 🔴 | |
| App Store 제출 | | 🔴 | |
| Play Store 제출 | | 🔴 | |
| 정식 출시 | | 🔴 | |

---

## 💡 Flutter 개발 팁

### 권장 사항
1. **상태 관리**: Riverpod 사용 (Provider보다 개선됨)
2. **로컬 DB**: Isar 사용 (Hive보다 빠름)
3. **아키텍처**: Clean Architecture + Repository 패턴
4. **코드 생성**: Freezed + JSON Serializable
5. **라우팅**: go_router (선언적, 딥링킹 지원)
6. **테스트**: 단위 테스트 + 위젯 테스트 필수

### 피해야 할 것
1. setState()의 과도한 사용 (Provider/Riverpod 사용)
2. 중첩된 위젯 (extract widget으로 분리)
3. 불필요한 rebuild (const, Selector 활용)
4. 동기 I/O 작업 (항상 비동기)

---

**마지막 업데이트**: 2025-01-23
**작성자**: 개발팀
**버전**: 1.0 (Flutter)

Flutter의 빠른 개발 속도와 우수한 성능으로 12주 안에 고품질 크로스 플랫폼 앱을 완성할 수 있습니다.
