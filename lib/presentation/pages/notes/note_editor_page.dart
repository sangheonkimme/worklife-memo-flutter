import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:worklife_memo_flutter/data/datasources/local/drift_service.dart';
import 'package:worklife_memo_flutter/presentation/providers/database_provider.dart';

class NoteEditorPage extends ConsumerWidget {
  final Note? note;

  const NoteEditorPage({super.key, this.note});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.content);

    return Scaffold(
      appBar: AppBar(
        title: Text(note == null ? 'New Note' : 'Edit Note'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final noteRepository = ref.read(noteRepositoryProvider);
              final title = titleController.text;
              final content = contentController.text;

              if (note == null) {
                final newNote = NotesCompanion(
                  title: drift.Value(title),
                  content: drift.Value(content),
                );
                noteRepository.addNote(newNote);
              } else {
                final updatedNote = note!.copyWith(
                  title: title,
                  content: content,
                );
                noteRepository.updateNote(updatedNote);
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}