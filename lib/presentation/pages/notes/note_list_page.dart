import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:worklife_memo_flutter/data/datasources/local/drift_service.dart';
import 'package:worklife_memo_flutter/presentation/pages/notes/note_editor_page.dart';
import 'package:worklife_memo_flutter/presentation/providers/database_provider.dart';
import 'package:worklife_memo_flutter/presentation/widgets/notes/note_card.dart';
import 'package:worklife_memo_flutter/presentation/widgets/notes/note_list_item.dart';

final isGridViewProvider = StateProvider<bool>((ref) => false);

class NoteListPage extends ConsumerWidget {
  const NoteListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noteRepository = ref.watch(noteRepositoryProvider);
    final isGridView = ref.watch(isGridViewProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes2'),
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.view_module),
            onPressed: () {
              ref.read(isGridViewProvider.notifier).state = !isGridView;
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Note>>(
        future: noteRepository.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final notes = snapshot.data ?? [];
          if (isGridView) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(note: note);
              },
            );
          } else {
            return ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                final note = notes[index];
                return Dismissible(
                  key: Key(note.id.toString()),
                  onDismissed: (direction) {
                    noteRepository.deleteNote(note.id);
                  },
                  background: Container(color: Colors.red),
                  child: NoteListItem(note: note),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NoteEditorPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
