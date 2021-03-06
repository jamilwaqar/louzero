import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/auth_controller.dart';

class AuthAPI {
  final BackendlessUserService auth;
  final _authController = Get.find<AuthController>();
  AuthAPI({required this.auth});
  Future<BackendlessUser?> get user => auth.getCurrentUser();

  Future login(String email, String password) async {
    try {
      var authUser = await auth.login(email, password, true);
      try {
        _authController.initUser(authUser);
      } catch (e){}
      if (authUser != null) {
        return authUser;
      } else {
        return "Failed to login";
      }
    } on PlatformException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future loginGuest() async {
    try {
      var authUser = await auth.loginAsGuest();
      try {
        _authController.guestUserId = authUser?.getObjectId();
      } catch (e) {}
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
      var authUser = await auth.register(user);
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
        'senderName': _authController.user.fullName,
        'senderEmail': _authController.user.email,
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
      await auth.restorePassword(email);
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future sendForgot(String email) async {
    try {
      await auth.restorePassword(email);
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future logout() async {
    try {
      await auth.logout();
      return 'Success';
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
    await deleteAccount(_authController.guestUserId!);
    if (_authController.inviteModelId != null) {
      await APIManager.delete(BLPath.invites, _authController.inviteModelId!);
    }
    return;
  }
}