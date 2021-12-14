// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_multiselect.dart';

void main() {
  testWidgets('MultisSelect', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: AppMultiSelect(),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('Select Options'), findsOneWidget);

    // Tap the Input Element
    await tester.tap(find.byKey(Key('select')));
    await tester.pump();
  });
}
