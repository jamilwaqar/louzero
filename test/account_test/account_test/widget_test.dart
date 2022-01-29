import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/ui/page/account/account.dart';
import '../../global_config/flutter_test_config.dart';
import '../../src/mocks.dart';

void main() {

  testWidgets('My Account page', (WidgetTester tester) async {
    Get.put(BaseController());
    Get.put(CompanyController());
    Get.find<AuthController>().userModel.value = mockUserModel;
    final company = MockCompanyModel();
    Get.find<BaseController>().companies = [company];

    await tester.pumpWidget(
        makeTestableWidget(child: const MyAccountPage(), tester: tester));

    /// Account Info
    expect(find.text(mockUserModel.fullName), findsWidgets);
    expect(find.text(mockUserModel.initials), findsOneWidget);
    expect(find.text(mockUserModel.phone), findsOneWidget);
    expect(find.text(mockUserModel.email), findsOneWidget);

    /// My Companies
    expect(Get.find<CompanyController>().companies.length, 1);
    expect(find.text(company.name), findsOneWidget);
  });

  testWidgets('Edit Account page', (WidgetTester tester) async {
    Get.put(BaseController());
    Get.put(CompanyController());
    Get.find<AuthController>().userModel.value = mockUserModel;
    final company = MockCompanyModel();
    Get.find<BaseController>().companies = [company];

    await tester.pumpWidget(
        makeTestableWidget(child: const MyAccountPage(), tester: tester));
    expect(find.text('Edit Account'), findsNothing);
    expect(find.text('Update Account'), findsNothing);

    Finder editBtn = find.byKey(const Key('AppIconButton'));
    expect(editBtn, findsOneWidget);
    await tester.tap(editBtn);
    await tester.pump();
    expect(find.text('Edit Account'), findsOneWidget);
    expect(find.text('Update Account'), findsOneWidget);
  });
}
