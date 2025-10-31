import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/drift/app_database.dart';

part 'app_database_provider.g.dart';

/// AppDatabase Provider
///
/// Drift AppDatabase 싱글톤 인스턴스를 제공합니다.
@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  final database = AppDatabase();

  // Provider가 dispose될 때 데이터베이스 연결 닫기
  ref.onDispose(() {
    database.close();
  });

  return database;
}
