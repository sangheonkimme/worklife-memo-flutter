/// Base Exception
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AppException: $message${code != null ? ' (code: $code)' : ''}';
}

/// 로컬 데이터베이스 관련 Exception
class DatabaseException extends AppException {
  const DatabaseException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'DatabaseException: $message';
}

/// 캐시 관련 Exception
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'CacheException: $message';
}

/// 네트워크 관련 Exception (Phase 3에서 사용)
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'NetworkException: $message';
}

/// 서버 관련 Exception (Phase 3에서 사용)
class ServerException extends AppException {
  final int? statusCode;

  const ServerException({
    required super.message,
    this.statusCode,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'ServerException: $message${statusCode != null ? ' (status: $statusCode)' : ''}';
}

/// 인증 관련 Exception (Phase 3에서 사용)
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'AuthException: $message';
}

/// 유효성 검증 Exception
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    this.fieldErrors,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'ValidationException: $message';
}

/// 리소스를 찾을 수 없는 Exception
class NotFoundException extends AppException {
  final String? resourceType;
  final String? resourceId;

  const NotFoundException({
    required super.message,
    this.resourceType,
    this.resourceId,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'NotFoundException: $message'
      '${resourceType != null ? ' (type: $resourceType)' : ''}'
      '${resourceId != null ? ' (id: $resourceId)' : ''}';
}

/// 권한 없음 Exception
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    required super.message,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// 충돌 Exception (동기화 시 사용)
class ConflictException extends AppException {
  final dynamic localData;
  final dynamic remoteData;

  const ConflictException({
    required super.message,
    this.localData,
    this.remoteData,
    super.code,
    super.originalError,
  });

  @override
  String toString() => 'ConflictException: $message';
}
