/// 입력 유효성 검증 유틸리티
class Validators {
  Validators._();

  /// 빈 문자열 검증
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// 이메일 형식 검증
  static bool isValidEmail(String? email) {
    if (email == null || email.isEmpty) return false;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    return emailRegex.hasMatch(email);
  }

  /// 비밀번호 강도 검증 (최소 8자, 영문+숫자+특수문자 포함)
  static bool isStrongPassword(String? password) {
    if (password == null || password.length < 8) return false;

    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChar = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    return hasUppercase && hasLowercase && hasDigit && hasSpecialChar;
  }

  /// 전화번호 형식 검증 (한국)
  static bool isValidPhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) return false;

    // 010-1234-5678, 01012345678, 02-123-4567 등
    final phoneRegex = RegExp(
      r'^(01[016789]|02|0[3-9][0-9])-?[0-9]{3,4}-?[0-9]{4}$',
    );

    return phoneRegex.hasMatch(phone);
  }

  /// URL 형식 검증
  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) return false;

    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.hasAuthority || uri.host.isNotEmpty);
    } catch (e) {
      return false;
    }
  }

  /// 최소 길이 검증
  static bool hasMinLength(String? value, int minLength) {
    return value != null && value.length >= minLength;
  }

  /// 최대 길이 검증
  static bool hasMaxLength(String? value, int maxLength) {
    return value != null && value.length <= maxLength;
  }

  /// 길이 범위 검증
  static bool isInLengthRange(String? value, int minLength, int maxLength) {
    return hasMinLength(value, minLength) && hasMaxLength(value, maxLength);
  }

  /// 숫자만 포함 검증
  static bool isNumeric(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'^[0-9]+$').hasMatch(value);
  }

  /// 영문자만 포함 검증
  static bool isAlpha(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'^[a-zA-Z]+$').hasMatch(value);
  }

  /// 영문자와 숫자만 포함 검증
  static bool isAlphanumeric(String? value) {
    if (value == null || value.isEmpty) return false;
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value);
  }

  /// 날짜 형식 검증 (yyyy-MM-dd)
  static bool isValidDate(String? date) {
    if (date == null || date.isEmpty) return false;

    try {
      final parts = date.split('-');
      if (parts.length != 3) return false;

      final year = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final day = int.parse(parts[2]);

      final dateTime = DateTime(year, month, day);
      return dateTime.year == year && dateTime.month == month && dateTime.day == day;
    } catch (e) {
      return false;
    }
  }

  /// 두 값이 일치하는지 검증 (비밀번호 확인 등)
  static bool matches(String? value1, String? value2) {
    return value1 != null && value2 != null && value1 == value2;
  }

  /// 정규식 패턴 매칭 검증
  static bool matchesPattern(String? value, String pattern) {
    if (value == null || value.isEmpty) return false;
    return RegExp(pattern).hasMatch(value);
  }

  // Form Validators (Form 위젯에서 사용)

  /// 필수 입력 검증
  static String? validateRequired(String? value, {String? fieldName}) {
    if (!isNotEmpty(value)) {
      return '${fieldName ?? '값'}을(를) 입력해주세요';
    }
    return null;
  }

  /// 이메일 검증
  static String? validateEmail(String? value) {
    if (!isNotEmpty(value)) {
      return '이메일을 입력해주세요';
    }
    if (!isValidEmail(value)) {
      return '올바른 이메일 형식이 아닙니다';
    }
    return null;
  }

  /// 비밀번호 검증
  static String? validatePassword(String? value) {
    if (!isNotEmpty(value)) {
      return '비밀번호를 입력해주세요';
    }
    if (!hasMinLength(value, 8)) {
      return '비밀번호는 최소 8자 이상이어야 합니다';
    }
    if (!isStrongPassword(value)) {
      return '비밀번호는 영문 대소문자, 숫자, 특수문자를 포함해야 합니다';
    }
    return null;
  }

  /// 비밀번호 확인 검증
  static String? validatePasswordConfirm(String? value, String? password) {
    if (!isNotEmpty(value)) {
      return '비밀번호 확인을 입력해주세요';
    }
    if (!matches(value, password)) {
      return '비밀번호가 일치하지 않습니다';
    }
    return null;
  }

  /// 전화번호 검증
  static String? validatePhoneNumber(String? value) {
    if (!isNotEmpty(value)) {
      return '전화번호를 입력해주세요';
    }
    if (!isValidPhoneNumber(value)) {
      return '올바른 전화번호 형식이 아닙니다';
    }
    return null;
  }

  /// 메모 제목 검증
  static String? validateNoteTitle(String? value) {
    if (!isNotEmpty(value)) {
      return '제목을 입력해주세요';
    }
    if (!hasMaxLength(value, 200)) {
      return '제목은 최대 200자까지 입력 가능합니다';
    }
    return null;
  }

  /// 폴더 이름 검증
  static String? validateFolderName(String? value) {
    if (!isNotEmpty(value)) {
      return '폴더 이름을 입력해주세요';
    }
    if (!hasMaxLength(value, 50)) {
      return '폴더 이름은 최대 50자까지 입력 가능합니다';
    }
    return null;
  }

  /// 태그 이름 검증
  static String? validateTagName(String? value) {
    if (!isNotEmpty(value)) {
      return '태그 이름을 입력해주세요';
    }
    if (!hasMaxLength(value, 30)) {
      return '태그 이름은 최대 30자까지 입력 가능합니다';
    }
    // 태그는 특수문자 제한
    if (!matchesPattern(value, r'^[가-힣a-zA-Z0-9_\s]+$')) {
      return '태그는 한글, 영문, 숫자, 언더스코어만 사용 가능합니다';
    }
    return null;
  }
}
