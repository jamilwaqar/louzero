import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/constants.dart';
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

  Future loginGuest(String email, String password) async {
    try {
      var authUser = await Backendless.userService.loginAsGuest();
      AuthStateManager.guestUserId = authUser?.getObjectId();
      // AuthStateManager.initUser(authUser);
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

  Future sendInvitationCode(String email, int code) async {
    try {
      EmailEnvelope envelope = EmailEnvelope();
      envelope.to = {email};
      Map<String, String> json = {
        'senderName': AuthStateManager.userModel.fullName,
        'senderEmail': AuthStateManager.userModel.email,
        'code': code.toString(),
      };
      await Backendless.messaging
          .sendEmailFromTemplate("Invite Customer", envelope, json)
          .then((response) => print("ASYNC: email has been sent"));
      var response = await APIManager.save(BLPath.invites, {'inviteCode': code.toString(),
        'email': email});
      return response;
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

  Future deleteAccount(String userId) async {
    try {
      await Backendless.data
          .of("Users")
          .remove(entity: {"objectId": userId});
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future cleanupGuestUser() async {
    await deleteAccount(AuthStateManager.guestUserId!);
    if (AuthStateManager.inviteModelId != null) {
      await APIManager.delete(BLPath.invites, AuthStateManager.inviteModelId!);
    }
    return;
  }
}