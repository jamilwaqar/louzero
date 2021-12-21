// import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'auth_flow_test.mocks.dart';

class MockUser extends Mock implements BackendlessUser {}
final MockUser _mockUser = MockUser();

class MockBackendlessAuth extends Mock implements BackendlessUserService {
  @override
  Future<BackendlessUser?> getCurrentUser() {
    return Future.value(_mockUser);
  }
}

@GenerateMocks([MockBackendlessAuth, MockUser])
void main() {
  final MockBackendlessAuth mockBackendlessAuth = MockBackendlessAuth();
  final AuthAPI auth = AuthAPI(auth: mockBackendlessAuth);
  setUp(() {});
  tearDown(() {});

  test("completion occurs", () async {
    expectLater(auth.user, completion(_mockUser));
  });

  test("create account", () async {
    var user = BackendlessUser();
    user.email = "mark@gmail.com";
    user.password = "123456";
    when(mockBackendlessAuth.register(user))
        .thenAnswer((_)=> Future(()=> _mockUser));

    // expect(await auth.signup("mark@gmail.com", "123456"), _mockUser);
  });

  test("sign in account", () async {
    when(mockBackendlessAuth.login("mark@gmail.com", "123456"))
        .thenAnswer((_) async => _mockUser);
    expect(await auth.login("mark@gmail.com", "123456"), _mockUser);
  });
}