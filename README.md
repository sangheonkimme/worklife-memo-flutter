# WorkLife Memo 📝

업무와 일상을 기록하는 스마트한 크로스 플랫폼 메모 앱

## 프로젝트 소개

WorkLife Memo는 Flutter로 개발된 크로스 플랫폼 메모 애플리케이션입니다.
Clean Architecture와 Offline-First 전략을 채택하여 안정적이고 확장 가능한 구조로 설계되었습니다.

### 주요 특징

- 🎨 **Material Design 3** - 최신 디자인 시스템 적용
- 📱 **크로스 플랫폼** - iOS, Android, Web 지원
- 💾 **Offline-First** - 네트워크 없이도 완벽한 기능 동작
- 🏗️ **Clean Architecture** - 계층 분리로 유지보수성 향상
- 🔄 **상태 관리** - Riverpod 기반 반응형 상태 관리
- 🗄️ **로컬 데이터베이스** - Isar를 사용한 빠른 로컬 저장소

## 기술 스택

### 핵심 기술
- **Flutter** 3.9.2+
- **Dart** 3.9.2+

### 주요 패키지

#### 상태 관리 & DI
- `flutter_riverpod` ^2.4.0 - 상태 관리
- `riverpod_annotation` ^2.3.0 - 코드 생성
- `get_it` ^7.6.0 - 의존성 주입

#### 네비게이션
- `go_router` ^12.1.0 - 선언적 라우팅

#### 로컬 데이터베이스
- `isar` ^3.1.0 - NoSQL 데이터베이스
- `isar_flutter_libs` ^3.1.0 - Flutter 통합

#### UI 컴포넌트
- `flutter_animate` ^4.3.0 - 애니메이션
- `shimmer` ^3.0.0 - 스켈레톤 로딩
- `flutter_slidable` ^3.0.0 - 슬라이드 액션

#### 에디터 & 마크다운
- `flutter_quill` ^9.0.0 - 리치 텍스트 에디터
- `markdown_widget` ^2.3.0 - 마크다운 렌더링
- `flutter_markdown` ^0.6.0 - 마크다운 표시

#### 유틸리티
- `freezed` ^2.4.0 - 불변 데이터 클래스
- `uuid` ^4.0.0 - 고유 ID 생성
- `intl` ^0.20.2 - 국제화 & 포맷팅
- `equatable` ^2.0.5 - 값 비교

## 프로젝트 구조

```
lib/
├── core/                          # 핵심 유틸리티 및 상수
│   ├── constants/                 # 앱 전역 상수
│   │   ├── app_colors.dart       # 색상 팔레트
│   │   ├── app_strings.dart      # 문자열 상수
│   │   └── app_themes.dart       # Material Design 3 테마
│   ├── errors/                    # 에러 처리
│   │   ├── exceptions.dart       # 예외 클래스
│   │   └── failures.dart         # Failure 클래스
│   └── utils/                     # 유틸리티 함수
│       ├── formatters.dart       # 포맷터
│       ├── validators.dart       # 검증 함수
│       └── extensions.dart       # 확장 메서드
│
├── data/                          # 데이터 레이어
│   ├── datasources/
│   │   └── local/                # 로컬 데이터 소스
│   │       ├── entities/         # Isar 엔티티
│   │       │   ├── note_entity.dart
│   │       │   ├── folder_entity.dart
│   │       │   ├── tag_entity.dart
│   │       │   └── checklist_item_entity.dart
│   │       ├── isar_database.dart
│   │       ├── note_local_datasource.dart
│   │       ├── folder_local_datasource.dart
│   │       ├── tag_local_datasource.dart
│   │       └── checklist_item_local_datasource.dart
│   └── repositories/              # Repository 구현
│       ├── note_repository_impl.dart
│       ├── folder_repository_impl.dart
│       └── tag_repository_impl.dart
│
├── domain/                        # 도메인 레이어
│   ├── entities/                  # 도메인 엔티티
│   │   ├── note.dart             # 메모 (Freezed)
│   │   ├── folder.dart           # 폴더 (Freezed)
│   │   ├── tag.dart              # 태그 (Freezed)
│   │   └── checklist_item.dart   # 체크리스트 (Freezed)
│   └── repositories/              # Repository 인터페이스
│       ├── note_repository.dart
│       ├── folder_repository.dart
│       └── tag_repository.dart
│
└── presentation/                  # 프레젠테이션 레이어
    ├── router/                    # 라우팅 설정
    │   └── app_router.dart       # go_router 설정
    ├── screens/                   # 화면
    │   ├── splash/
    │   │   └── splash_screen.dart
    │   └── home/
    │       ├── home_shell.dart   # Bottom Navigation Shell
    │       ├── notes_screen.dart
    │       ├── folders_screen.dart
    │       ├── tags_screen.dart
    │       └── settings_screen.dart
    └── widgets/                   # 재사용 위젯
        ├── common/                # 공통 위젯
        │   ├── app_loading_indicator.dart
        │   ├── app_error_widget.dart
        │   ├── app_empty_widget.dart
        │   ├── app_shimmer_loading.dart
        │   └── app_snackbar.dart
        └── dialogs/               # 다이얼로그
            └── app_dialog.dart
```

## 완료된 작업 (Phase 1: 기초 구축)

### ✅ Week 1: 프로젝트 설정 및 아키텍처 구성
- Flutter 프로젝트 생성 및 의존성 설정
- Clean Architecture 폴더 구조 생성
- Material Design 3 테마 구현 (Light/Dark)
- 핵심 유틸리티 및 상수 정의
- 에러 핸들링 구조 구축

### ✅ Week 2: 로컬 데이터베이스 구현
- Isar 데이터베이스 스키마 정의
- Domain Layer 엔티티 (Freezed 사용)
- Repository 인터페이스 정의
- Local Data Sources 구현
- Repository 구현체 (에러 처리 포함)
- 코드 생성 (build_runner) - 180개 파일

### ✅ Week 3: 기본 UI 컴포넌트 및 네비게이션
- go_router 기반 네비게이션 설정
- Splash Screen (DB 초기화)
- Home Shell (Bottom Navigation - 4개 탭)
- 공통 위젯 라이브러리
  - Loading Indicator
  - Error Widget
  - Empty State Widget
  - Shimmer Loading
  - Dialog Components
  - SnackBar Utilities

## 시작하기

### 사전 요구사항

- Flutter SDK 3.9.2 이상
- Dart SDK 3.9.2 이상
- iOS: Xcode 15.0+ (iOS 개발 시)
- Android: Android Studio (Android 개발 시)

### 설치 및 실행

1. **저장소 클론**
```bash
git clone <repository-url>
cd worklife-memo-flutter
```

2. **의존성 설치**
```bash
flutter pub get
```

3. **코드 생성 실행**
```bash
dart run build_runner build --delete-conflicting-outputs
```

4. **앱 실행**
```bash
# 개발 모드
flutter run

# 특정 디바이스 지정
flutter run -d <device-id>
```

### 빌드

```bash
# Android APK
flutter build apk

# Android App Bundle
flutter build appbundle

# iOS
flutter build ios
```

## 개발 전략: Offline-First

이 프로젝트는 **Offline-First** 전략을 채택합니다:

### Phase 1-2: 완전한 오프라인 앱 (Week 1-8)
- 로컬 데이터베이스 (Isar) 기반
- 모든 핵심 기능이 로컬에서 동작
- 네트워크 없이 완전히 사용 가능

### Phase 3: API 연동 및 동기화 (Week 9-12)
- 기존 로컬 코드에 API 레이어 추가
- 양방향 동기화 구현
- 충돌 해결 로직

### 장점
✅ 초기 개발 단순화 (네트워크 이슈 없음)
✅ 오프라인 경험 우선 설계
✅ 단계적 기능 검증 가능
✅ API 서버 없이도 앱 테스트 가능

## 개발 로드맵

### 📍 현재 진행 상황: Week 3 완료 (21%)

- [x] **Week 1**: 프로젝트 설정 및 아키텍처
- [x] **Week 2**: 로컬 데이터베이스
- [x] **Week 3**: UI 컴포넌트 및 네비게이션
- [ ] **Week 4-5**: 메모 CRUD 및 에디터
- [ ] **Week 6**: 폴더 및 태그 시스템
- [ ] **Week 7-8**: 검색 및 필터링
- [ ] **Week 9-10**: API 연동 및 동기화
- [ ] **Week 11**: 템플릿 시스템
- [ ] **Week 12**: 가계부 연동
- [ ] **Week 13**: 성능 최적화
- [ ] **Week 14**: 스토어 출시 준비

자세한 내용은 [작업 계획서](docs/flutter-app-work-plan.md) 참조

## 주요 기능 (계획)

### 메모 작성
- 📝 리치 텍스트 에디터 (Flutter Quill)
- 📄 마크다운 에디터
- ☑️ 체크리스트
- 🖼️ 이미지 삽입

### 조직화
- 📁 폴더 (최대 3단계 계층)
- 🏷️ 태그 (색상, 자동완성)
- 📌 고정, ⭐ 즐겨찾기, 📦 보관

### 검색 & 필터
- 🔍 전문 검색 (제목 + 내용)
- 🎯 고급 필터링 (태그, 폴더, 날짜, 타입)
- 📊 정렬 (최신순, 제목순, 수정일순)

### 동기화 (Phase 3)
- ☁️ 클라우드 동기화
- 🔄 양방향 동기화
- ⚡ 실시간 충돌 해결

## 기여하기

프로젝트에 기여하고 싶으시다면:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 라이선스

This project is licensed under the MIT License - see the LICENSE file for details

## 문의

프로젝트 관련 문의사항이 있으시면 이슈를 등록해주세요.

---

**개발 시작일**: 2025-01-27
**현재 상태**: Phase 1 완료 (Week 3/14)
**다음 목표**: Week 4-5 메모 CRUD 및 에디터 구현
