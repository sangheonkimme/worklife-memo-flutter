import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:worklife_memo_flutter/main.dart';

void main() {
  testWidgets('NoteListPage renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that the AppBar title is 'Notes'.
    expect(find.text('Notes'), findsOneWidget);
  });
}