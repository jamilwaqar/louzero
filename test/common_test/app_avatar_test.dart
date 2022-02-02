import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_image.dart';
import 'package:louzero/controller/constant/constants.dart';

void main() {

  testWidgets('App Avatar: No Url, No Placeholder', (WidgetTester tester) async {
    const key = Key('AppAvatar');
    const borderColor = Colors.orange;
    const backgroundColor = Colors.red;
    const widget = AppAvatar(
      text: 'MA',
      key: key,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
    );

    await tester.pumpWidget(const MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('MA'), findsOneWidget);
    expect(widget.size, equals(96));
    expect(widget.borderColor, equals(borderColor));
    expect(widget.backgroundColor, equals(backgroundColor));
    expect(widget.url, isNull);
    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byType(AppImage), findsNothing);
  });

  testWidgets('App Avatar: No Url, has Placeholder', (WidgetTester tester) async {
    const key = Key('AppAvatar');
    const widget = AppAvatar(
      text: 'MA',
      placeHolder: AppPlaceHolder.user,
      key: key,
    );

    await tester.pumpWidget(const MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('MA'), findsNothing);
    expect(widget.url, isNull);
    expect(find.byType(CachedNetworkImage), findsNothing);
    expect(find.byType(AppImage), findsOneWidget);
  });

  testWidgets('App Avatar: has Url', (WidgetTester tester) async {
    const key = Key('AppAvatar');
    final widget = AppAvatar(
      text: 'MA',
      url: Uri.parse('https://via.placeholder.com/150'),
      placeHolder: AppPlaceHolder.user,
      key: key,
    );

    await tester.pumpWidget(MaterialApp(
      home: Center(
        child: widget,
      ),
    ));
    expect(find.text('MA'), findsNothing);
    expect(widget.url, isNotNull);
    expect(find.byType(CachedNetworkImage), findsOneWidget);
    expect(find.byType(AppImage), findsNothing);
  });
}