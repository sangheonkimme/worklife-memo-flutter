import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/local/note_local_datasource.dart';
import '../../data/repositories/note_repository_impl.dart';
import '../../domain/repositories/note_repository.dart';

part 'note_repository_provider.g.dart';

/// NoteLocalDataSource Provider
///
/// NoteLocalDataSource 싱글톤 인스턴스를 제공합니다.
@riverpod
NoteLocalDataSource noteLocalDataSource(NoteLocalDataSourceRef ref) {
  return NoteLocalDataSource();
}

/// NoteRepository Provider
///
/// NoteRepositoryImpl 싱글톤 인스턴스를 제공합니다.
@riverpod
NoteRepository noteRepository(NoteRepositoryRef ref) {
  final localDataSource = ref.watch(noteLocalDataSourceProvider);
  return NoteRepositoryImpl(localDataSource: localDataSource);
}
