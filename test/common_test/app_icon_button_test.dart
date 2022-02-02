import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_icon_button.dart';

void main() {
  testWidgets('App Icon Button', (WidgetTester tester) async {

    var pressed = false;
    const key = Key('App Icon Button');

    final widget = AppIconButton(key: key, onTap: () => pressed = true);

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.byIcon(Icons.close), findsOneWidget);
    await tester.tap(find.byKey(key));
    await tester.pump();
    expect(pressed, equals(true));
  });
}