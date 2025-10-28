# WorkLife Dashboard 메모 앱 - Flutter 개발 작업 계획

**프로젝트 기간**: 14주
**시작일**: 2025-01-27
**상태**: Phase 2 Week 4-5 완료 ✅ (진행 중)
**개발 전략**: 오프라인 우선 (Offline-First) → API 연동
**완료된 Week**: 5/14

---

## Phase 1: 기초 구축 (3주)

### Week 1: 프로젝트 설정 및 아키텍처 구성 ✅

#### 프로젝트 초기 설정
- [x] Flutter 프로젝트 생성 (3.16.x)
- [x] pubspec.yaml 의존성 패키지 추가
  - [x] 상태 관리 (Riverpod)
  - [x] 로컬 DB (Isar)
  - [x] UI 컴포넌트
  - [x] 에디터 (flutter_quill, markdown_widget)
  - [x] 유틸리티 (intl, path_provider, uuid, equatable)
  - [x] **네트워킹은 Phase 3에서 추가 (Dio, Retrofit, connectivity_plus)**
- [x] 프로젝트 폴더 구조 생성 (Clean Architecture)
  - [x] core/ 폴더 구조
  - [x] data/ 폴더 구조
  - [x] domain/ 폴더 구조
  - [x] presentation/ 폴더 구조

#### 코어 설정
- [x] constants 파일 생성
  - [x] app_colors.dart
  - [x] app_strings.dart
  - [x] app_themes.dart
- [x] 에러 핸들링 구조
  - [x] exceptions.dart
  - [x] failures.dart
- [x] 유틸리티 함수
  - [x] formatters.dart
  - [x] validators.dart
  - [x] extensions.dart

#### 테마 및 디자인 시스템
- [x] Material Design 3 테마 구현
  - [x] Light Theme
  - [x] Dark Theme
- [x] 커스텀 컬러 스킴 정의
- [x] 타이포그래피 설정 (Pretendard 폰트)
- [x] 공통 위젯 컴포넌트
  - [x] 버튼 스타일 (테마에 정의됨)
  - [x] 카드 스타일 (테마에 정의됨)
  - [x] 입력 필드 스타일 (테마에 정의됨)

---

### Week 2: 로컬 데이터베이스 구현 (Offline-First) ✅

#### Isar 데이터베이스 설정
- [x] Isar 스키마 정의
  - [x] NoteEntity (id, uuid, title, content, type, createdAt, updatedAt)
  - [x] FolderEntity (id, name, parentId, createdAt)
  - [x] TagEntity (id, name, color, createdAt)
  - [x] ChecklistItemEntity (id, noteId, text, isCompleted, order)
- [x] Isar 데이터베이스 초기화
- [x] 인덱스 설정
  - [x] 제목 검색 인덱스
  - [x] 날짜 정렬 인덱스
  - [x] UUID 고유 인덱스

#### 로컬 데이터 소스 구현
- [x] note_local_datasource.dart
  - [x] Create (메모 생성)
  - [x] Read (단일/목록/검색)
  - [x] Update (메모 수정)
  - [x] Delete (삭제/복구)
- [x] folder_local_datasource.dart
  - [x] 폴더 CRUD
  - [x] 폴더 트리 조회
- [x] tag_local_datasource.dart
  - [x] 태그 CRUD
  - [x] 태그 자동완성
- [x] checklist_item_local_datasource.dart
  - [x] 체크리스트 CRUD
  - [x] 완료/미완료 필터링

#### Domain Layer 구현
- [x] Entity 정의
  - [x] note.dart
  - [x] folder.dart
  - [x] tag.dart
  - [x] checklist_item.dart
- [x] Repository Interface
  - [x] note_repository.dart
  - [x] folder_repository.dart
  - [x] tag_repository.dart

#### Data Layer 구현
- [x] Repository 구현 (로컬 전용)
  - [x] note_repository_impl.dart
  - [x] folder_repository_impl.dart
  - [x] tag_repository_impl.dart
- [x] 에러 처리 로직
- [x] Code generation 실행 (build_runner)

---

### Week 3: 기본 UI 컴포넌트 및 네비게이션 ✅

#### 네비게이션 설정
- [x] go_router 설정
- [x] 라우트 정의
  - [x] Splash 화면
  - [x] 홈 화면 (메모 목록)
  - [x] 메모 에디터 (라우트 준비 완료, Week 4에서 구현)
  - [x] 검색 화면 (라우트 준비 완료, Week 7에서 구현)
  - [x] 설정 화면
- [x] 딥링크 설정 (iOS/Android - go_router가 자동 지원)

#### 기본 화면 구현
- [x] Splash 화면
  - [x] 로딩 애니메이션
  - [x] 앱 초기화 (Isar DB 초기화)
- [x] 홈 화면 레이아웃
  - [x] Bottom Navigation Bar (4개 탭)
  - [x] App Bar with search
  - [x] Drawer (폴더 트리 - 구조 완료, 실제 데이터는 Week 6)
  - [x] FAB (새 메모 작성)

#### 공통 위젯
- [x] 로딩 인디케이터 (AppLoadingIndicator, AppSmallLoadingIndicator)
- [x] 에러 위젯 (AppErrorWidget + factory methods)
- [x] 빈 상태 위젯 (AppEmptyWidget + factory methods)
- [x] Shimmer 로딩 효과 (NoteCardShimmer, FolderItemShimmer 등)
- [x] 다이얼로그 컴포넌트 (AppDialog + extension methods)
- [x] 스낵바 유틸리티 (BuildContext extension)

---

## Phase 2: 핵심 기능 - 오프라인 완성 (5주)

### Week 4-5: 메모 CRUD 및 에디터 ✅

#### UseCase 구현 (비즈니스 로직)
- [x] create_note.dart
- [x] update_note.dart
- [x] delete_note.dart
- [x] get_notes.dart
- [x] get_note_by_id.dart
- [x] pin_note.dart
- [x] archive_note.dart

#### Riverpod Provider 설정
- [x] note_provider.dart
  - [x] 메모 목록 상태
  - [x] CRUD 액션
  - [x] 필터링 로직
- [ ] folder_provider.dart (Week 6에서 구현 예정)
- [ ] tag_provider.dart (Week 6에서 구현 예정)

#### 리치 텍스트 에디터 (Flutter Quill)
- [x] QuillController 설정
- [x] 에디터 툴바 커스터마이징
  - [x] Bold, Italic, Underline
  - [x] 헤딩, 리스트
  - [x] 링크, 이미지
  - [x] 코드 블록
- [x] 자동 저장 기능 (디바운스 3초)
- [x] 실행 취소/재실행

#### 마크다운 에디터
- [x] 마크다운 입력 필드
- [x] 실시간 미리보기 (Split View)
- [x] 문법 하이라이팅
- [x] GFM (GitHub Flavored Markdown) 지원
- [x] 마크다운 툴바

#### 체크리스트 에디터
- [x] ReorderableListView 구현
- [x] 체크박스 토글 기능
- [x] 드래그 앤 드롭 재정렬
- [x] 진행률 인디케이터
- [ ] 서브 태스크 지원 (추후 구현)
- [ ] 완료 애니메이션 (추후 구현)

#### 메모 에디터 페이지
- [x] note_editor_screen.dart
- [x] 타입별 에디터 전환 (Rich Text/Markdown/Checklist)
- [x] 제목 입력 필드
- [ ] 이미지 삽입 기능 (추후 구현)
- [x] 저장/취소 버튼
- [x] 자동 저장 인디케이터

---

### Week 6: 폴더 및 태그 시스템

#### 폴더 기능 (로컬 전용)
- [ ] 폴더 UseCase
  - [ ] create_folder.dart
  - [ ] update_folder.dart
  - [ ] delete_folder.dart
  - [ ] move_folder.dart
- [ ] 폴더 트리 구조 구현
  - [ ] TreeView 위젯
  - [ ] 계층 구조 (최대 3단계)
  - [ ] 확장/축소 애니메이션
- [ ] 폴더 CRUD UI
  - [ ] 폴더 생성 다이얼로그
  - [ ] 폴더 이름 변경
  - [ ] 폴더 삭제 확인
  - [ ] 폴더 이동
- [ ] 메모를 폴더로 이동
- [ ] 폴더별 메모 필터링

#### 태그 시스템 (로컬 전용)
- [ ] 태그 UseCase
  - [ ] create_tag.dart
  - [ ] get_tags.dart
  - [ ] search_tags.dart (로컬 자동완성)
- [ ] 태그 입력 위젯 (ChipsInput)
- [ ] 태그 자동완성 (로컬 DB 검색)
  - [ ] 디바운스 처리
- [ ] 태그 색상 관리
- [ ] 태그 칩 위젯
- [ ] 태그별 필터링
- [ ] 인기 태그 표시 (사용 빈도)

#### 폴더/태그 UI
- [ ] 폴더 트리 사이드바
- [ ] 태그 관리 화면
- [ ] 폴더 선택 다이얼로그
- [ ] 태그 선택 다이얼로그
- [ ] 필터 칩스 행

---

### Week 7-8: 검색 및 필터링

#### 검색 기능
- [ ] 전문 검색 (Full-Text Search)
  - [ ] Isar 검색 쿼리 최적화
  - [ ] 제목 + 내용 검색
- [ ] 검색 입력 필드
  - [ ] 디바운스 (300ms)
  - [ ] 검색 기록 저장
- [ ] 검색 결과 페이지
  - [ ] 하이라이팅
  - [ ] 관련도 정렬

#### 고급 필터링
- [ ] SearchFilters 모델
- [ ] 필터 UI
  - [ ] 태그 필터
  - [ ] 폴더 필터
  - [ ] 날짜 범위 필터
  - [ ] 메모 타입 필터 (텍스트/마크다운/체크리스트)
- [ ] 필터 조합 로직
- [ ] 필터 프리셋 저장

#### 정렬 기능
- [ ] 정렬 옵션
  - [ ] 최신순
  - [ ] 오래된순
  - [ ] 제목순
  - [ ] 수정일순
- [ ] 정렬 UI (드롭다운)

#### 검색 최적화
- [ ] 검색 인덱스 최적화
- [ ] 결과 캐싱
- [ ] 무한 스크롤 (페이지네이션)

---

## Phase 3: API 연동 및 동기화 (4주)

### Week 9-10: API 연동 및 동기화 엔진

#### API 클라이언트 구현
- [ ] Dio 클라이언트 설정
  - [ ] dio_client.dart
  - [ ] api_interceptor.dart (토큰, 로깅)
  - [ ] network_info.dart (연결 상태 확인)
- [ ] Retrofit API 클라이언트 생성
  - [ ] auth_api_client.dart
  - [ ] note_api_client.dart
  - [ ] folder_api_client.dart
  - [ ] tag_api_client.dart
- [ ] API 엔드포인트 정의
  - [ ] 메모 CRUD 엔드포인트
  - [ ] 폴더 관리 엔드포인트
  - [ ] 태그 관리 엔드포인트
  - [ ] 검색 엔드포인트
  - [ ] 동기화 엔드포인트 (변경 조회)

#### Remote Data Source
- [ ] note_remote_datasource.dart
- [ ] folder_remote_datasource.dart
- [ ] tag_remote_datasource.dart

#### Repository 수정 (로컬+리모트 통합)
- [ ] note_repository_impl 수정
  - [ ] 로컬/리모트 데이터 소스 통합
  - [ ] 네트워크 연결 감지
  - [ ] 오프라인 시 로컬 반환
- [ ] folder_repository_impl 수정
- [ ] tag_repository_impl 수정

#### 인증 시스템
- [ ] 보안 저장소 설정 (flutter_secure_storage)
- [ ] 로그인/로그아웃 기능
- [ ] 토큰 관리 시스템
- [ ] 토큰 자동 갱신
- [ ] 생체 인증 통합 (선택)

#### 동기화 엔진
- [ ] 네트워크 연결 감지 (connectivity_plus)
- [ ] SyncManager 클래스 구현
- [ ] 동기화 상태 모델
  - [ ] SYNCED
  - [ ] PENDING
  - [ ] CONFLICT
- [ ] 양방향 동기화
  - [ ] 로컬 → 서버 업로드
  - [ ] 서버 → 로컬 다운로드
- [ ] 충돌 해결 전략
  - [ ] 최신 수정 우선
  - [ ] 사용자 선택
  - [ ] 자동 병합

#### 백그라운드 동기화
- [ ] WorkManager 설정
  - [ ] 주기적 동기화 (30분)
  - [ ] 제약 조건 (WiFi only, 배터리)
- [ ] 동기화 큐
- [ ] 재시도 로직 (Exponential Backoff)

#### 동기화 UI
- [ ] 동기화 상태 인디케이터
- [ ] 동기화 진행 상황 표시
- [ ] 수동 동기화 버튼
- [ ] 충돌 해결 다이얼로그

#### 네트워크 에러 처리
- [ ] 오프라인 알림
- [ ] 재연결 시 자동 동기화
- [ ] 동기화 실패 알림

---

### Week 11: 템플릿 시스템 (로컬 + API)

#### 템플릿 로컬 구현
- [ ] TemplateEntity 스키마 추가
- [ ] template_local_datasource.dart
- [ ] template_repository.dart

#### 템플릿 API 연동
- [ ] template_api_client.dart
  - [ ] GET /api/templates
  - [ ] POST /api/templates
  - [ ] DELETE /api/templates/{id}
- [ ] template_remote_datasource.dart
- [ ] 템플릿 동기화

#### 템플릿 UI
- [ ] 템플릿 목록 화면
  - [ ] 그리드 뷰
  - [ ] 미리보기
  - [ ] 로컬/서버 구분 표시
- [ ] 템플릿 생성 기능
  - [ ] 현재 메모를 템플릿으로 저장
  - [ ] 템플릿 제목/설명
  - [ ] 로컬 저장 / 서버 업로드 선택
- [ ] 템플릿으로 메모 생성
  - [ ] 템플릿 선택
  - [ ] 내용 자동 채우기

#### 기본 템플릿 (프리셋)
- [ ] 회의록 템플릿
- [ ] 일일 업무 일지
- [ ] 여행 계획
- [ ] 독서 노트

---

### Week 12: 가계부 연동 및 고급 기능

#### 가계부 연동 (API)
- [ ] 거래 API 클라이언트
  - [ ] GET /api/transactions
  - [ ] POST /api/notes/{id}/link-transaction
  - [ ] DELETE /api/notes/{id}/unlink/{tid}
- [ ] TransactionEntity 스키마
- [ ] transaction_repository.dart
- [ ] 거래 목록 Provider

#### 거래 연결 UI
- [ ] 거래 선택 다이얼로그
  - [ ] 거래 목록 표시
  - [ ] 검색 기능
  - [ ] 카테고리 아이콘
  - [ ] 금액 포맷팅
- [ ] 연결된 거래 표시
  - [ ] 메모 상세에서 거래 카드
  - [ ] 연결 해제 버튼
- [ ] 거래별 메모 조회

#### 통계 기능
- [ ] 거래-메모 통계
- [ ] 카테고리별 메모 수
- [ ] 지출 메모 분석
- [ ] 메모 작성 통계 (일별/주별/월별)

---

## Phase 4: 최적화 및 출시 (2주)

### Week 13: 성능 최적화 및 버그 수정

#### 성능 최적화
- [ ] 렌더링 최적화
  - [ ] const 생성자 사용
  - [ ] RepaintBoundary 적용
  - [ ] ListView 최적화 (itemExtent)
- [ ] 상태 관리 최적화
  - [ ] Provider select 사용
  - [ ] autoDispose 활용
  - [ ] 메모이제이션
- [ ] 이미지 최적화
  - [ ] CachedNetworkImage
  - [ ] 이미지 압축
  - [ ] 메모리 캐시 크기 제한
- [ ] 빌드 크기 최적화
  - [ ] 불필요한 패키지 제거
  - [ ] Tree shaking 확인
  - [ ] 앱 번들 분석

#### 플랫폼별 최적화
- [ ] iOS 최적화
  - [ ] Cupertino 위젯 적용
  - [ ] Haptic Feedback
  - [ ] iOS 스타일 스크롤
- [ ] Android 최적화
  - [ ] Material You Dynamic Color
  - [ ] 백 버튼 처리
  - [ ] Android 스타일 스크롤
- [ ] 태블릿 최적화
  - [ ] Master-Detail 레이아웃
  - [ ] 그리드 뷰 최적화
  - [ ] 가로/세로 모드 대응

#### 반응형 레이아웃
- [ ] ResponsiveLayout 위젯 구현
- [ ] 브레이크포인트 설정
  - [ ] Mobile: < 600px
  - [ ] Tablet: 600-900px
  - [ ] Desktop: > 900px
- [ ] 화면별 레이아웃 조정

#### 버그 수정
- [ ] 크래시 이슈 해결
- [ ] UI 버그 수정
- [ ] 동기화 버그 수정
- [ ] 메모리 누수 체크

#### 테스트
- [ ] 단위 테스트 (80% 커버리지)
  - [ ] Repository 테스트
  - [ ] UseCase 테스트
  - [ ] Provider 테스트
- [ ] 위젯 테스트
  - [ ] 주요 위젯 테스트
  - [ ] UI 상호작용 테스트
- [ ] 통합 테스트
  - [ ] 메모 생성/수정/삭제 플로우
  - [ ] 검색 플로우
  - [ ] 동기화 플로우
- [ ] 성능 테스트
  - [ ] 콜드 스타트 시간
  - [ ] 프레임 렌더링
  - [ ] 메모리 사용량

---

### Week 14: 스토어 출시 준비

#### Firebase 통합
- [ ] Firebase 프로젝트 설정
- [ ] Firebase Analytics
  - [ ] 주요 이벤트 추적
  - [ ] 화면 추적
  - [ ] 사용자 속성
- [ ] Firebase Crashlytics
  - [ ] 크래시 리포팅
  - [ ] 커스텀 로그
- [ ] Firebase Performance Monitoring

#### 보안
- [ ] 코드 난독화 (ProGuard/R8)
- [ ] API 키 보안
- [ ] SSL 핀닝
- [ ] 루팅/탈옥 감지

#### 앱 아이콘 & 스플래시
- [ ] 앱 아이콘 제작 (iOS/Android)
- [ ] 적응형 아이콘 (Android)
- [ ] 스플래시 스크린 설정

#### 앱 스토어 준비
- [ ] 앱 스토어 스크린샷
  - [ ] iPhone (6.5", 5.5")
  - [ ] iPad Pro
  - [ ] Android (Phone/Tablet)
- [ ] 앱 설명 작성
  - [ ] 한국어
  - [ ] 영어
- [ ] 개인정보 처리방침
- [ ] 이용약관

#### Google Play Store
- [ ] Google Play Console 설정
- [ ] 앱 서명
- [ ] AAB 빌드
  - [ ] Release 빌드 설정
  - [ ] 서명 키 생성
- [ ] 내부 테스트 배포
- [ ] 공개 베타 배포
- [ ] 프로덕션 배포

#### Apple App Store
- [ ] App Store Connect 설정
- [ ] 프로비저닝 프로파일
- [ ] IPA 빌드
  - [ ] Release 빌드 설정
  - [ ] 인증서 설정
- [ ] TestFlight 배포
- [ ] App Store 심사 제출

#### CI/CD 파이프라인
- [ ] GitHub Actions 설정
  - [ ] 자동 테스트
  - [ ] 자동 빌드
  - [ ] 자동 배포
- [ ] Fastlane 설정 (선택)

#### 문서화
- [ ] README.md 작성
- [ ] API 문서
- [ ] 코드 주석
- [ ] 사용자 가이드

---

## 추가 기능 (선택 사항)

### 알림 시스템
- [ ] 로컬 알림 (flutter_local_notifications)
- [ ] 푸시 알림 (Firebase Messaging)
- [ ] 알림 스케줄링
- [ ] 알림 설정 UI

### 공유 기능
- [ ] 메모 공유 (share_plus)
  - [ ] 텍스트 공유
  - [ ] PDF 내보내기
  - [ ] 마크다운 내보내기
- [ ] 공유 링크 생성
- [ ] QR 코드 생성

### 위젯
- [ ] iOS 홈 화면 위젯
- [ ] Android 홈 화면 위젯
- [ ] 빠른 메모 작성
- [ ] 최근 메모 목록

### 다국어 지원
- [ ] intl 패키지 설정
- [ ] ARB 파일 생성
- [ ] 한국어 (기본)
- [ ] 영어
- [ ] 일본어 (선택)

---

## 성공 지표 체크리스트

### 기술 지표
- [ ] 앱 크기 < 30MB
- [ ] 콜드 스타트 < 1.5초
- [ ] 프레임 렌더링 60fps
- [ ] 메모리 사용량 < 150MB
- [ ] 크래시율 < 0.5%

### 비즈니스 지표
- [ ] 앱 다운로드 5,000건 (3개월)
- [ ] DAU 1,000명 이상
- [ ] MAU 2,000명 이상
- [ ] 앱스토어 평점 4.7 이상
- [ ] 7일 리텐션 > 50%

---

## 리스크 관리 체크리스트

### 기술적 리스크 대응
- [ ] 동기화 충돌 해결 로직 검증
- [ ] 대용량 데이터 처리 테스트
- [ ] 플랫폼 간 UI 일관성 확인

### 비즈니스 리스크 대응
- [ ] 앱스토어 가이드라인 준수 확인
- [ ] 온보딩 UX 개선
- [ ] 서버 비용 최적화 전략 수립

---

## 개발 전략 요약

### 오프라인 우선 (Offline-First) 접근

이 프로젝트는 **오프라인 우선** 전략을 채택합니다:

1. **Phase 1-2 (Week 1-8)**: 완전한 오프라인 앱 개발
   - 로컬 데이터베이스 (Isar) 기반
   - 모든 핵심 기능 로컬에서 동작
   - 네트워크 없이 완전히 사용 가능

2. **Phase 3 (Week 9-12)**: API 연동 및 동기화
   - 기존 로컬 코드에 API 레이어 추가
   - 양방향 동기화 구현
   - 충돌 해결 로직

3. **장점**:
   - ✅ 초기 개발 단순화 (네트워크 이슈 없음)
   - ✅ 오프라인 경험 우선 설계
   - ✅ 단계적 기능 검증 가능
   - ✅ API 서버 없이도 앱 테스트 가능

### 주요 마일스톤

- **Week 3**: 오프라인 메모 작성/조회 가능
- **Week 8**: 오프라인 전체 기능 완성
- **Week 10**: API 동기화 완료
- **Week 14**: 앱스토어 출시

---

**작성일**: 2025-01-27
**최종 업데이트**: 2025-03-03 (Phase 2 Week 4-5 완료)
**작성자**: Claude Code

> 💡 **Tip**: 각 작업을 완료할 때마다 체크박스를 체크하여 진행 상황을 추적하세요!
>
> 🚀 **개발 전략**: 오프라인 먼저 → API 연동 나중에!
