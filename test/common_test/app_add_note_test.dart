import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_add_note.dart';

void main() {
  testWidgets('App Add Note', (WidgetTester tester) async {

    const key = Key('App Add Note');
    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: AppAddNote(initialText: 'App Note', key: key, onChange: (val){}),
      ),
    ));
    expect(find.text('App Note'), findsOneWidget);
    expect(find.text('Add Note'), findsNothing);
    expect(find.text('Delete Note'), findsNothing);

    /// Edit button
    Finder editBtn = find.byKey(const Key('AppIconButton'));
    expect(editBtn, findsOneWidget);
    await tester.tap(editBtn);
    await tester.pump();

    expect(find.text('App Note'), findsOneWidget);
    expect(find.text('Add Note'), findsOneWidget);
    await tester.enterText(find.byKey(key), 'Test');
    await tester.pump();
    expect(find.text('Test'), findsOneWidget);

    /// Delete Button
    Finder deleteNote = find.text('Delete Note');
    expect(deleteNote, findsOneWidget);
    await tester.tap(deleteNote);
    await tester.pump();
    expect(find.text('Test'), findsNothing);
  });
}