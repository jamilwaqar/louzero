import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/ui/page/auth/login.dart';
import '../../global_config/flutter_test_config.dart';

void main() {
  const email = 'test@gmail.com';
  const password = '12345678';

  testWidgets('Widgets in Login page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const LoginPage(), tester: tester));
    expect(find.text('Sign in to LOUzero'), findsOneWidget);
    expect(find.text('New to LOUzero?'), findsOneWidget);
    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Remember this device'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('HAVE AN INVITATION CODE?'), findsOneWidget);
    expect(find.text('Accept Invite'), findsOneWidget);
  });

  testWidgets('Enter Email and Password', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const LoginPage(), tester: tester));

    expect(find.text(email), findsNothing);
    expect(find.text(password), findsNothing);

    final emailText = find.byKey(const ValueKey('Email Address'));
    final passwordText = find.byKey(const ValueKey('Password'));

    expect(emailText, findsOneWidget);
    expect(passwordText, findsOneWidget);

    await tester.enterText(emailText, email);
    expect(find.text(email), findsOneWidget);
    await tester.enterText(passwordText, password);
    expect(find.text(password), findsOneWidget);
  });
}
