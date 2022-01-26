import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/ui/page/auth/signup.dart';
import '../../global_config/flutter_test_config.dart';

void main() {
  const email = 'test@gmail.com';

  testWidgets('Widgets in Signup page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const SignUpPage(), tester: tester));
    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Already using LOUzero?'), findsOneWidget);
    expect(find.text('Sign Up with Google'), findsOneWidget);
    expect(find.text('Enter your email to create a new account'), findsOneWidget);
    expect(find.text('Your Email'), findsOneWidget);
    expect(find.text('Continue'), findsOneWidget);
    expect(find.text('HAVE AN INVITATION CODE?'), findsOneWidget);
  });

  testWidgets('Enter Email and Password', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const SignUpPage(), tester: tester));

    expect(find.text(email), findsNothing);
    final emailText = find.byKey(const ValueKey('Email Address'));
    expect(emailText, findsOneWidget);
    await tester.enterText(emailText, email);
    expect(find.text(email), findsOneWidget);
  });
}
