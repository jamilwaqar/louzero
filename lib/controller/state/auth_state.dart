import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';

class AuthStateManager {
  static final AuthStateManager _singleton = AuthStateManager._internal();
  factory AuthStateManager() {
    return _singleton;
  }
  AuthStateManager._internal() {
    // Initialize
  }

  final loggedIn = ValueNotifier(false);

  Future initializeManager() async {
    loggedIn.value = true/*(await Backendless.userService.isValidLogin()) ?? false*/;
  }
}