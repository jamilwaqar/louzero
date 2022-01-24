import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/company_controller.dart';
import 'package:louzero/ui/page/account/account.dart';
import 'mocks.dart';

void main() {

  testWidgets('My Account page', (WidgetTester tester) async {
    Get.put(BaseController());
    Get.put(CompanyController());

    final userModel = MockUserModel();
    Get.find<AuthController>().userModel.value = userModel;
    final company = MockCompanyModel();
    Get.find<BaseController>().companies = [company];
    await tester.pumpWidget(const MaterialApp(home: MyAccountPage()));

    /// Account Info
    expect(find.text(userModel.fullName), findsWidgets);
    expect(find.text(userModel.initials), findsOneWidget);
    expect(find.text(userModel.phone), findsOneWidget);
    expect(find.text(userModel.email), findsOneWidget);

    /// My Companies
    expect(Get.find<CompanyController>().companies.length, 1);
    expect(find.text(company.name), findsOneWidget);
  });

  // testWidgets('Edit Account page', (WidgetTester tester) async {
  //   tester.binding.window.textScaleFactorTestValue = 0.6;
  //   Get.put(BaseController());
  //   Get.put(CompanyController());
  //   final userModel = MockUserModel();
  //   final company = MockCompanyModel();
  //   Get.find<BaseController>().companies = [company];
  //   await tester.pumpWidget(MaterialApp(home: EditAccountPage(userModel)));
  //
  //   /// Account Info
  //   expect(find.text(userModel.fullName), findsWidgets);
  //   expect(find.text(userModel.initials), findsOneWidget);
  //   expect(find.text(userModel.phone), findsOneWidget);
  //   expect(find.text(userModel.email), findsOneWidget);
  //   expect(find.text(userModel.serviceAddress), findsNothing);
  // });
}
