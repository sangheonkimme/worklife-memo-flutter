# WorkLife Memo Flutter

메모 및 생산성 앱을 위한 새로운 Flutter 프로젝트입니다.

## 프로젝트 개요

WorkLife Memo는 Flutter로 개발된 크로스 플랫폼 메모 및 생산성 앱입니다. <br/> 기존 웹 서비스와 실시간으로 동기화되어, iOS와 Android 사용자 모두에게 끊김 없는 사용 경험을 제공하는
것을 목표로 합니다.

클린 아키텍처 원칙을 따르고 Riverpod 상태 관리 라이브러리를 활용하며, Flutter Quill을 사용한 리치 텍스트 편집기, 마크다운 편집기 및 체크리스트 편집기 기능을 제공합니다. <br/> 이 앱은 오프라인 우선으로 작동하도록 설계되었으며, 백엔드 API와 통신하는 사용자 지정 동기화 엔진으로 데이터 동기화를 처리합니다.

## 기술 스택

- **프레임워크:** Flutter
- **언어:** Dart
- **상태 관리:** Riverpod
- **아키텍처:** 클린 아키텍처
- **로컬 데이터베이스:** Isar
- **네트워킹:** Dio

## 시작하기

이 프로젝트를 빌드하고 실행하려면 Flutter SDK가 설치되어 있어야 합니다.

**1. 의존성 설치:**

```bash
flutter pub get
```

**2. 앱 실행:**

```bash
flutter run
```

**3. 테스트 실행:**

```bash
flutter test
```

## 프로젝트 구조

이 프로젝트는 클린 아키텍처 구조를 따릅니다:

```
lib/
├── core/
├── data/
├── domain/
└── presentation/
```

## 개발 컨벤션

이 프로젝트는 다음 규칙을 준수합니다:

- **클린 아키텍처:** 코드 베이스는 `data`, `domain`, `presentation`의 세 가지 계층으로 구성됩니다.
- **상태 관리:** Riverpod는 `presentation/providers` 디렉토리에 정의된 공급자와 함께 상태 관리에 사용됩니다.
- **라우팅:** `go_router`가 내비게이션에 사용됩니다.
- **스타일링:** 이 앱은 Material Design 3를 사용하며 `lib/core/constants/app_themes.dart`에 사용자 지정 테마를 정의합니다.
- **테스트:** 이 프로젝트에는 단위, 위젯 및 통합 테스트가 포함됩니다. 테스트 파일은 `test` 디렉토리에 있습니다.
- **CI/CD:** 지속적인 통합 및 배포를 위해 GitHub Actions 워크플로가 설정되어 있습니다.
