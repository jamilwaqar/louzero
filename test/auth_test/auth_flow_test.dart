import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements BackendlessUser {}
final MockUser _mockUser = MockUser();

class MockBackendlessAuth extends Mock implements BackendlessUserService {
  @override
  Future<BackendlessUser?> getCurrentUser() {
    return Future.value(_mockUser);
  }

  @override
  Future<bool?>isValidLogin() {
    return Future.value(true);
  }

  @override
  Future<BackendlessUser?>login(String email, String password, [bool stayLoggedIn = false]) {
    return Future.value(_mockUser);
  }

  @override
  Future<BackendlessUser?> register(BackendlessUser user) {
    return Future.value(_mockUser);
  }

  @override
  Future<BackendlessUser?> loginAsGuest([bool stayLoggedIn = false]) {
    return Future.value(_mockUser);
  }

  @override
  Future<String> logout() {
    return Future.value('Success');
  }
}


void main() {

  final MockBackendlessAuth mockBackendlessAuth = MockBackendlessAuth();
  Get.put(AuthController(mockBackendlessAuth));
  final AuthAPI auth = AuthAPI(auth: mockBackendlessAuth);
  const String email = "mark@gmail.com";
  const String password = "123456";

  setUp(() {});
  tearDown(() {});

  test("completion occurs", () async {
    expectLater(auth.user, completion(_mockUser));
  });

  test("Default Current User", () async {
    final response = await mockBackendlessAuth.getCurrentUser();
    expect(response, _mockUser);
  });

  test("create account_test", () async {
    var user = BackendlessUser();
    final response = await mockBackendlessAuth.register(user);
    expect(await auth.signup(email, password), response);
  });

  test("sign in account_test", () async {
    final response = await mockBackendlessAuth.login(email, password);
    expect(await auth.login(email, password), response);
  });

  test("login_test as guest", () async {
    final response = await mockBackendlessAuth.loginAsGuest();
    expect(await auth.loginGuest(), response);
  });

  test("logout", () async {
    final response = await mockBackendlessAuth.logout();
    expect(await auth.logout(), response);
  });
}