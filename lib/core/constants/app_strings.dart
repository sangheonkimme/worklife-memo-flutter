/// App Strings - 앱에서 사용하는 문자열 상수
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'WorkLife Memo';
  static const String appDescription = 'WorkLife Dashboard 메모 앱';

  // Common
  static const String ok = '확인';
  static const String cancel = '취소';
  static const String save = '저장';
  static const String delete = '삭제';
  static const String edit = '수정';
  static const String create = '생성';
  static const String search = '검색';
  static const String filter = '필터';
  static const String sort = '정렬';
  static const String share = '공유';
  static const String loading = '로딩중...';
  static const String retry = '재시도';
  static const String close = '닫기';
  static const String back = '뒤로';
  static const String next = '다음';
  static const String done = '완료';
  static const String yes = '예';
  static const String no = '아니오';

  // Note
  static const String note = '메모';
  static const String notes = '메모';
  static const String newNote = '새 메모';
  static const String editNote = '메모 수정';
  static const String deleteNote = '메모 삭제';
  static const String noteTitle = '제목';
  static const String noteContent = '내용';
  static const String noteDeleted = '메모가 삭제되었습니다';
  static const String noteSaved = '메모가 저장되었습니다';
  static const String emptyNotes = '메모가 없습니다';
  static const String createFirstNote = '첫 번째 메모를 작성해보세요';

  // Note Types
  static const String richText = '리치 텍스트';
  static const String markdown = '마크다운';
  static const String checklist = '체크리스트';

  // Folder
  static const String folder = '폴더';
  static const String folders = '폴더';
  static const String newFolder = '새 폴더';
  static const String folderName = '폴더 이름';
  static const String renameFolder = '폴더 이름 변경';
  static const String deleteFolder = '폴더 삭제';
  static const String moveToFolder = '폴더로 이동';
  static const String emptyFolders = '폴더가 없습니다';

  // Tag
  static const String tag = '태그';
  static const String tags = '태그';
  static const String addTag = '태그 추가';
  static const String removeTag = '태그 제거';
  static const String selectTags = '태그 선택';
  static const String noTags = '태그 없음';

  // Search
  static const String searchNotes = '메모 검색';
  static const String searchHint = '제목, 내용, 태그로 검색';
  static const String searchResults = '검색 결과';
  static const String noResults = '검색 결과가 없습니다';

  // Filter & Sort
  static const String filterBy = '필터';
  static const String sortBy = '정렬';
  static const String sortByDate = '날짜순';
  static const String sortByTitle = '제목순';
  static const String sortByUpdated = '수정일순';
  static const String newest = '최신순';
  static const String oldest = '오래된순';

  // Actions
  static const String pin = '고정';
  static const String unpin = '고정 해제';
  static const String archive = '보관';
  static const String unarchive = '보관 해제';
  static const String restore = '복원';
  static const String permanentDelete = '영구 삭제';

  // Settings
  static const String settings = '설정';
  static const String theme = '테마';
  static const String lightMode = '라이트 모드';
  static const String darkMode = '다크 모드';
  static const String systemDefault = '시스템 기본값';
  static const String language = '언어';

  // Templates
  static const String template = '템플릿';
  static const String templates = '템플릿';
  static const String useTemplate = '템플릿 사용';
  static const String saveAsTemplate = '템플릿으로 저장';

  // Sync (Phase 3)
  static const String sync = '동기화';
  static const String syncing = '동기화 중...';
  static const String syncCompleted = '동기화 완료';
  static const String syncFailed = '동기화 실패';
  static const String offline = '오프라인';
  static const String online = '온라인';

  // Error Messages
  static const String errorOccurred = '오류가 발생했습니다';
  static const String errorLoadingNotes = '메모를 불러오는 중 오류가 발생했습니다';
  static const String errorSavingNote = '메모 저장 중 오류가 발생했습니다';
  static const String errorDeletingNote = '메모 삭제 중 오류가 발생했습니다';
  static const String errorEmptyTitle = '제목을 입력해주세요';
  static const String errorEmptyContent = '내용을 입력해주세요';

  // Confirmation
  static const String confirmDelete = '정말 삭제하시겠습니까?';
  static const String confirmDeleteNote = '이 메모를 삭제하시겠습니까?';
  static const String confirmDeleteFolder = '이 폴더를 삭제하시겠습니까?';
  static const String confirmPermanentDelete = '영구적으로 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  // Statistics
  static const String totalNotes = '전체 메모';
  static const String todayNotes = '오늘의 메모';
  static const String thisWeekNotes = '이번 주 메모';
  static const String thisMonthNotes = '이번 달 메모';
}
