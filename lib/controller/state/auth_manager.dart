import 'package:flutter/cupertino.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/user_models.dart';

class AuthManager {
  static final AuthManager _singleton = AuthManager._internal();
  bool get isAuthUser => GetStorage().read(GSKey.isAuthUser) ?? false;

  static late UserModel userModel;
  static String? guestUserId;
  static String? inviteModelId;
  factory AuthManager() {
    return _singleton;
  }
  AuthManager._internal() {
    // Initialize
  }

  final loggedIn = ValueNotifier(false);

  Future initializeManager() async {
    BackendlessUser? response = await Backendless.userService.getCurrentUser();
    initUser(response);
    loggedIn.value = (await Backendless.userService.isValidLogin()) ?? false;
  }

  static void initUser(BackendlessUser? user) {
    if (user != null) {
      userModel = UserModel.fromJson(Map<String, dynamic>.from(user.properties));
      userModel.objectId = user.getObjectId();
      GetStorage().write(GSKey.isAuthUser, true);
    }
  }

  Future updateUser() async {
    BackendlessUser? user = await Backendless.userService.getCurrentUser();
    if (user == null) return;
    user.setProperties(
      {... user.properties, ... userModel.toJson()}
    );
    var res = await Backendless.userService.update(user);
    return res;
  }
}