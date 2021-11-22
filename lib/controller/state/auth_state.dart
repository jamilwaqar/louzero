import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:louzero/models/user_models.dart';

class AuthStateManager {
  static final AuthStateManager _singleton = AuthStateManager._internal();
  static late UserModel userModel;
  factory AuthStateManager() {
    return _singleton;
  }
  AuthStateManager._internal() {
    // Initialize
  }

  final loggedIn = ValueNotifier(false);

  Future initializeManager() async {
    BackendlessUser? response = await Backendless.userService.getCurrentUser();
    if (response != null) {
      userModel = UserModel.fromJson(Map<String, dynamic>.from(response.properties));
      userModel.objectId = response.getObjectId();
    }
    loggedIn.value = (await Backendless.userService.isValidLogin()) ?? false;
  }
}