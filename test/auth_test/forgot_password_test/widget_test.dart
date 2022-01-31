import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/auth/reset_password.dart';
import '../../global_config/flutter_test_config.dart';
import '../../src/mocks.dart';

void main() {
  const email = 'test@gmail.com';
  Get.put(AuthController(mockBLUserService));
  testWidgets('Widgets in ResetPassword page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const ResetPasswordPage(), tester: tester));
    expect(find.text("Can't Login?"), findsOneWidget);
    expect(find.text('Email Reset Instructions'), findsOneWidget);
    expect(find.text('Never mind, go back to'), findsOneWidget);
  });

  testWidgets('Enter Email and Password', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const ResetPasswordPage(), tester: tester));

    expect(find.text(email), findsNothing);
    final emailText = find.byKey(const Key('Email Address'));
    expect(emailText, findsOneWidget);
    await tester.enterText(emailText, email);
    expect(find.text(email), findsOneWidget);
  });
}
