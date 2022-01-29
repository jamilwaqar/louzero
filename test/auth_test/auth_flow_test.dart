import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import '../src/mocks.dart';

void main() {

  Get.put(AuthController(mockBLUserService));

  final AuthAPI auth = AuthAPI(auth: mockBLUserService);
  const String email = "mark@gmail.com";
  const String password = "123456";

  setUp(() {});
  tearDown(() {});

  test("completion occurs", () async {
    expectLater(auth.user, completion(mockUser));
  });

  test("Default Current User", () async {
    final response = await mockBLUserService.getCurrentUser();
    expect(response, mockUser);
  });

  test("create account_test", () async {
    var user = BackendlessUser();
    final response = await mockBLUserService.register(user);
    expect(await auth.signup(email, password), response);
  });

  test("sign in account_test", () async {
    final response = await mockBLUserService.login(email, password);
    expect(await auth.login(email, password), response);
  });

  test("login_test as guest", () async {
    final response = await mockBLUserService.loginAsGuest();
    expect(await auth.loginGuest(), response);
  });

  test("logout", () async {
    final response = await mockBLUserService.logout();
    expect(await auth.logout(), response);
  });
}