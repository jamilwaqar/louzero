import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/auth/accept_invite.dart';
import '../../global_config/flutter_test_config.dart';
import '../../src/mocks.dart';

void main() {
  const email = 'test@gmail.com';
  Get.put(AuthController(mockBLUserService));
  testWidgets('Widgets in AcceptInvite page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const AcceptInvitePage(), tester: tester));
    expect(find.text('Accept Invitation'), findsOneWidget);
    expect(find.text('Enter your email address and invitation code below.'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Go back to'), findsOneWidget);
  });

  testWidgets('Enter Email and Invitation Code', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const AcceptInvitePage(), tester: tester));

    expect(find.text(email), findsNothing);
    final emailText = find.byKey(const ValueKey('Email Address'));
    expect(emailText, findsOneWidget);
    await tester.enterText(emailText, email);
    expect(find.text(email), findsOneWidget);
  });
}
