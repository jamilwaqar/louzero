import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_advanced_textfield.dart';

void main() {
  testWidgets('App Advanced TextField', (WidgetTester tester) async {
    String value = '';
    var pressed = false;
    const key = Key('AppAdvancedTextField');
    final controller = TextEditingController(text: 'Test Message');
    final widget = AppAdvancedTextField(
      controller: controller,
      label: 'App Advanced TextField',
      key: key,
      onTap: () => pressed = true,
      onChange: (val) {
        value = val;
      },
    );

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: Material(child: widget),
      ),
    ));
    expect(find.text('App Advanced TextField'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);
    await tester.tap(find.byKey(key));
    await tester.pump();
    expect(pressed, equals(true));

    await tester.enterText(find.byWidget(widget), 'My new text');
    await tester.pump();
    expect(find.text('My new text'), findsOneWidget);
    expect(controller.text, 'My new text');
    expect(value, 'My new text');
  });
}