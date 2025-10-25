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
