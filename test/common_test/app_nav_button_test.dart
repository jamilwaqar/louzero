import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_nav_button.dart';

void main() {
  testWidgets('App Nav Button', (WidgetTester tester) async {

    var pressed = false;
    const key = Key('App Nav Button');

    final widget = AppNavButton(title: 'App Nav Button', key: key, onPressed: () => pressed = true);

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('App Nav Button'), findsOneWidget);
    await tester.tap(find.byKey(key));
    await tester.pump();
    expect(pressed, equals(true));
  });
}