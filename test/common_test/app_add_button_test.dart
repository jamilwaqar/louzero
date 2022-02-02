import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_add_button.dart';


void main() {
  testWidgets('App Add Button', (WidgetTester tester) async {

    var pressed = false;
    const key = Key('App Button');

    final widget = AppAddButton('App Add Button', key: key, onPressed: () => pressed = true);

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('App Add Button'), findsOneWidget);
    await tester.tap(find.byKey(key));
    await tester.pump();
    expect(pressed, equals(true));
  });
}