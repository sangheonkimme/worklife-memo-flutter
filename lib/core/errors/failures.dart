import 'package:equatable/equatable.dart';

/// Base Failure
/// Either를 사용한 에러 처리의 Left 타입으로 사용됩니다.
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];

  @override
  String toString() => 'Failure: $message${code != null ? ' (code: $code)' : ''}';
}

/// 로컬 데이터베이스 관련 Failure
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'DatabaseFailure: $message';
}

/// 캐시 관련 Failure
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'CacheFailure: $message';
}

/// 네트워크 관련 Failure (Phase 3)
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'NetworkFailure: $message';
}

/// 서버 관련 Failure (Phase 3)
class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({
    required super.message,
    this.statusCode,
    super.code,
  });

  @override
  List<Object?> get props => [message, code, statusCode];

  @override
  String toString() => 'ServerFailure: $message${statusCode != null ? ' (status: $statusCode)' : ''}';
}

/// 인증 관련 Failure (Phase 3)
class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'AuthFailure: $message';
}

/// 유효성 검증 Failure
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    this.fieldErrors,
    super.code,
  });

  @override
  List<Object?> get props => [message, code, fieldErrors];

  @override
  String toString() => 'ValidationFailure: $message';
}

/// 리소스를 찾을 수 없는 Failure
class NotFoundFailure extends Failure {
  final String? resourceType;
  final String? resourceId;

  const NotFoundFailure({
    required super.message,
    this.resourceType,
    this.resourceId,
    super.code,
  });

  @override
  List<Object?> get props => [message, code, resourceType, resourceId];

  @override
  String toString() => 'NotFoundFailure: $message'
      '${resourceType != null ? ' (type: $resourceType)' : ''}'
      '${resourceId != null ? ' (id: $resourceId)' : ''}';
}

/// 권한 없음 Failure
class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'UnauthorizedFailure: $message';
}

/// 충돌 Failure (동기화 시 사용)
class ConflictFailure extends Failure {
  const ConflictFailure({
    required super.message,
    super.code,
  });

  @override
  String toString() => 'ConflictFailure: $message';
}

/// 일반 Failure (알 수 없는 에러)
class UnknownFailure extends Failure {
  const UnknownFailure({
    String? message,
    super.code,
  }) : super(message: message ?? '알 수 없는 오류가 발생했습니다');

  @override
  String toString() => 'UnknownFailure: $message';
}
