import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:louzero/controller/state/auth_state.dart';

class AuthAPI {

  Future login(String email, String password) async {
    try {
      var authUser = await Backendless.userService.login(email, password, true);
      AuthStateManager.initUser(authUser);
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
      // AuthStateManager.initUser(authUser);
      if (authUser != null) {
        return authUser;
      } else {
        return "Failed to signup";
      }
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future sendVerificationCode(String email, int code) async {
    try {
      EmailEnvelope envelope = EmailEnvelope();
      envelope.to = {email};
      Backendless.messaging.sendEmailFromTemplate("Email Verification Code", envelope, {'code': code.toString()}).then(
          (response) => print("ASYNC: email has been sent"));
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

  Future sendForgot(String email) async {
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