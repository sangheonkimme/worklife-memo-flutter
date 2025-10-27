import 'package:flutter/material.dart';
import 'formatters.dart';

/// String Extensions
extension StringExtensions on String {
  /// 첫 글자 대문자로 변환
  String capitalize() => Formatters.capitalize(this);

  /// 빈 문자열 여부
  bool get isEmptyOrNull => trim().isEmpty;

  /// null이 아니고 비어있지 않은 문자열
  bool get isNotEmptyOrNull => !isEmptyOrNull;

  /// HTML 태그 제거
  String stripHtml() => Formatters.stripHtmlTags(this);

  /// 텍스트 자르기
  String truncate(int maxLength, {String ellipsis = '...'}) =>
      Formatters.truncate(this, maxLength, ellipsis: ellipsis);

  /// 이니셜 추출
  String getInitials({int maxLength = 2}) =>
      Formatters.getInitials(this, maxLength: maxLength);

  /// nullable String을 non-nullable로 변환 (기본값 제공)
  String orEmpty() => this;
}

/// String? (nullable) Extensions
extension NullableStringExtensions on String? {
  /// null 또는 빈 문자열 여부
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// null이 아니고 비어있지 않은 문자열
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// nullable String을 non-nullable로 변환 (기본값 제공)
  String orEmpty() => this ?? '';

  /// nullable String을 non-nullable로 변환 (커스텀 기본값)
  String or(String defaultValue) => this ?? defaultValue;
}

/// DateTime Extensions
extension DateTimeExtensions on DateTime {
  /// 상대적인 시간 표시 (예: "3분 전")
  String toRelativeTime() => Formatters.formatRelativeTime(this);

  /// 사용자 친화적인 날짜 표시 (예: "오늘 15:30")
  String toFriendlyDate() => Formatters.formatFriendlyDate(this);

  /// 날짜만 추출 (시간 제거)
  DateTime get dateOnly => DateTime(year, month, day);

  /// 같은 날짜인지 확인
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// 오늘인지 확인
  bool get isToday => isSameDate(DateTime.now());

  /// 어제인지 확인
  bool get isYesterday =>
      isSameDate(DateTime.now().subtract(const Duration(days: 1)));

  /// 내일인지 확인
  bool get isTomorrow =>
      isSameDate(DateTime.now().add(const Duration(days: 1)));

  /// 이번 주인지 확인
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// 이번 달인지 확인
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }

  /// 이번 해인지 확인
  bool get isThisYear => year == DateTime.now().year;

  /// 주말인지 확인
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;

  /// 평일인지 확인
  bool get isWeekday => !isWeekend;

  /// 날짜 포맷 (yyyy-MM-dd)
  String toDateString() => Formatters.dateFormat.format(this);

  /// 시간 포맷 (HH:mm)
  String toTimeString() => Formatters.timeFormat.format(this);

  /// 날짜+시간 포맷 (yyyy-MM-dd HH:mm)
  String toDateTimeString() => Formatters.dateTimeFormat.format(this);

  /// 한국어 날짜 포맷 (yyyy년 MM월 dd일)
  String toKoreanDateString() => Formatters.koreanDateFormat.format(this);
}

/// int Extensions
extension IntExtensions on int {
  /// 천 단위 구분자와 함께 표시
  String toFormattedString() => Formatters.formatNumber(this);

  /// 통화 포맷 (원화)
  String toCurrency() => Formatters.formatCurrency(this);

  /// 파일 크기 포맷
  String toFileSize() => Formatters.formatFileSize(this);

  /// Duration으로 변환 (milliseconds)
  Duration get milliseconds => Duration(milliseconds: this);

  /// Duration으로 변환 (seconds)
  Duration get seconds => Duration(seconds: this);

  /// Duration으로 변환 (minutes)
  Duration get minutes => Duration(minutes: this);

  /// Duration으로 변환 (hours)
  Duration get hours => Duration(hours: this);

  /// Duration으로 변환 (days)
  Duration get days => Duration(days: this);
}

/// double Extensions
extension DoubleExtensions on double {
  /// 소수점 포맷
  String toFormattedString({int decimalDigits = 2}) =>
      Formatters.formatDecimal(this, decimalDigits: decimalDigits);

  /// 백분율 포맷
  String toPercentage({int decimalDigits = 1}) =>
      Formatters.formatPercentage(this, decimalDigits: decimalDigits);
}

/// List Extensions
extension ListExtensions<T> on List<T> {
  /// 리스트가 null이 아니고 비어있지 않은지 확인
  bool get isNotNullOrEmpty => isNotEmpty;

  /// 안전한 elementAt (범위를 벗어나면 null 반환)
  T? elementAtOrNull(int index) {
    if (index >= 0 && index < length) {
      return this[index];
    }
    return null;
  }

  /// 중복 제거
  List<T> get unique => toSet().toList();

  /// 리스트 분할 (chunk)
  List<List<T>> chunk(int size) {
    final chunks = <List<T>>[];
    for (var i = 0; i < length; i += size) {
      chunks.add(sublist(i, i + size > length ? length : i + size));
    }
    return chunks;
  }
}

/// BuildContext Extensions
extension BuildContextExtensions on BuildContext {
  /// Theme 접근
  ThemeData get theme => Theme.of(this);

  /// TextTheme 접근
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// ColorScheme 접근
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// MediaQuery 접근
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// 화면 크기
  Size get screenSize => mediaQuery.size;

  /// 화면 너비
  double get screenWidth => screenSize.width;

  /// 화면 높이
  double get screenHeight => screenSize.height;

  /// 패딩 (Safe Area)
  EdgeInsets get padding => mediaQuery.padding;

  /// 키보드 높이
  double get keyboardHeight => mediaQuery.viewInsets.bottom;

  /// 다크 모드 여부
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// 라이트 모드 여부
  bool get isLightMode => !isDarkMode;

  /// 화면 방향
  Orientation get orientation => mediaQuery.orientation;

  /// 가로 모드 여부
  bool get isLandscape => orientation == Orientation.landscape;

  /// 세로 모드 여부
  bool get isPortrait => orientation == Orientation.portrait;

  /// 태블릿 여부 (화면 너비 기준)
  bool get isTablet => screenWidth >= 600;

  /// 모바일 여부
  bool get isMobile => !isTablet;

  /// SnackBar 표시 (편의 메서드)
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// 에러 SnackBar 표시
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: colorScheme.error,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  /// 성공 SnackBar 표시
  void showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// Color Extensions
extension ColorExtensions on Color {
  /// Hex 코드로 변환
  String toHex() {
    final argb = (a * 255).toInt() << 24 |
                 (r * 255).toInt() << 16 |
                 (g * 255).toInt() << 8 |
                 (b * 255).toInt();
    return '#${argb.toRadixString(16).substring(2).toUpperCase()}';
  }

  /// 대비되는 텍스트 색상 얻기
  Color getContrastingTextColor() {
    final luminance = computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}
