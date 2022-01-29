import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';

class MockUser extends Mock implements BackendlessUser {}

class MockBLUserService extends Mock implements BackendlessUserService {
  @override
  Future<BackendlessUser?> getCurrentUser() {
    return Future.value(mockUser);
  }

  @override
  Future<bool?>isValidLogin() {
    return Future.value(true);
  }

  @override
  Future<BackendlessUser?>login(String email, String password, [bool stayLoggedIn = false]) {
    return Future.value(mockUser);
  }

  @override
  Future<BackendlessUser?> register(BackendlessUser user) {
    return Future.value(mockUser);
  }

  @override
  Future<BackendlessUser?> loginAsGuest([bool stayLoggedIn = false]) {
    return Future.value(mockUser);
  }

  @override
  Future<String> logout() {
    return Future.value('Success');
  }
}