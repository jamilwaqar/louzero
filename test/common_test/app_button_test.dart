import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_button.dart';

void main() {
  testWidgets('App Button', (WidgetTester tester) async {

    var pressed = false;
    const key = Key('App Button');

    final widget = AppButton(label: 'App Button', key: key, onPressed: () => pressed = true);

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('App Button'), findsOneWidget);
    await tester.tap(find.byKey(key));
    await tester.pump();
    expect(pressed, equals(true));
  });
}