import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:worklife_memo_flutter/data/datasources/local/drift_service.dart';
import 'package:worklife_memo_flutter/data/datasources/local/note_local_datasource.dart';
import 'package:worklife_memo_flutter/domain/repositories/note_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

final noteLocalDataSourceProvider = Provider<NoteLocalDataSource>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return NoteLocalDataSourceImpl(database: database);
});

final noteRepositoryProvider = Provider<NoteRepository>((ref) {
  final localDataSource = ref.watch(noteLocalDataSourceProvider);
  return NoteRepositoryImpl(localDataSource: localDataSource);
});
