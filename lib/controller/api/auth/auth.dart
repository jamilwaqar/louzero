import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';

class AuthAPI {
  Future login(String email, String password) async {
    try {
      var authUser = await Backendless.userService.login(email, password, true);
      if (authUser != null) {
        return authUser;
      } else {
        return "Failed to login";
      }
    } on PlatformException catch (e) {
      return e.message;
    }
  }
  Future signup(String email, String password) async {
    try {
      var user = BackendlessUser.fromJson({
        "email" : email,
        "password" : password,
        "nickname" : email,
      });
      var authUser = await Backendless.userService.register(user);
      if (authUser != null) {
        return authUser;
      } else {
        return "Failed to signup";
      }
    } on PlatformException catch (e) {
      return e.message;
    }
  }
  Future resetPassword(String email) async {
    try {
      await Backendless.userService.restorePassword(email);
    } on PlatformException catch (e) {
      return e.message;
    }
  }
  Future logout() async {
    try {
      await Backendless.userService.logout();
      return;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

}