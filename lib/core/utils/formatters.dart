import 'package:intl/intl.dart';

/// 날짜 및 텍스트 포맷팅 유틸리티
class Formatters {
  Formatters._();

  // Date Formatters
  static final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat timeFormat = DateFormat('HH:mm');
  static final DateFormat dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');
  static final DateFormat fullDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat koreanDateFormat = DateFormat('yyyy년 MM월 dd일');
  static final DateFormat koreanDateTimeFormat = DateFormat('yyyy년 MM월 dd일 HH:mm');

  /// 날짜를 상대적인 시간으로 표시 (예: "방금 전", "3분 전", "어제")
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}주 전';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}개월 전';
    } else {
      return '${(difference.inDays / 365).floor()}년 전';
    }
  }

  /// 날짜를 사용자 친화적인 형식으로 표시
  static String formatFriendlyDate(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateToCheck = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (dateToCheck == today) {
      return '오늘 ${timeFormat.format(dateTime)}';
    } else if (dateToCheck == yesterday) {
      return '어제 ${timeFormat.format(dateTime)}';
    } else if (now.difference(dateTime).inDays < 7) {
      final weekday = ['월', '화', '수', '목', '금', '토', '일'][dateTime.weekday - 1];
      return '$weekday요일 ${timeFormat.format(dateTime)}';
    } else {
      return dateFormat.format(dateTime);
    }
  }

  /// 텍스트를 특정 길이로 자르고 말줄임표 추가
  static String truncate(String text, int maxLength, {String ellipsis = '...'}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength - ellipsis.length)}$ellipsis';
  }

  /// 파일 크기를 사람이 읽기 쉬운 형식으로 변환 (예: "1.5 MB")
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  /// 숫자를 천 단위 구분자와 함께 표시
  static String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  /// 소수점을 포함한 숫자 포맷
  static String formatDecimal(double number, {int decimalDigits = 2}) {
    final formatter = NumberFormat('#,##0.${'0' * decimalDigits}');
    return formatter.format(number);
  }

  /// 통화 포맷 (한국 원화)
  static String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'ko_KR',
      symbol: '₩',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  /// 백분율 포맷
  static String formatPercentage(double value, {int decimalDigits = 1}) {
    return '${(value * 100).toStringAsFixed(decimalDigits)}%';
  }

  /// HTML 태그 제거
  static String stripHtmlTags(String html) {
    final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: false);
    return html.replaceAll(exp, '');
  }

  /// 첫 글자 대문자로 변환
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// 단어의 첫 글자들을 조합하여 이니셜 생성 (예: "홍길동" -> "홍")
  static String getInitials(String text, {int maxLength = 2}) {
    if (text.isEmpty) return '';

    final words = text.trim().split(RegExp(r'\s+'));
    final initials = words
        .take(maxLength)
        .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
        .join();

    return initials;
  }

  /// 줄바꿈을 <br>로 변환
  static String nl2br(String text) {
    return text.replaceAll('\n', '<br>');
  }

  /// <br>을 줄바꿈으로 변환
  static String br2nl(String text) {
    return text.replaceAll('<br>', '\n').replaceAll('<br/>', '\n');
  }
}
