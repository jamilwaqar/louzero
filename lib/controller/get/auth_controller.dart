import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/api/auth/auth_api.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/account/account_setup.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  
  AuthController(this.userService);
  final BackendlessUserService userService;
  
  bool get isAuthUser => GetStorage().read(GSKey.isAuthUser) ?? false;
  
  final userModel = Rx<UserModel>(UserModel());

  UserModel get user => userModel.value;

  String? guestUserId;
  String? inviteModelId;

  final loggedIn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    BackendlessUser? response = await userService.getCurrentUser();
    initUser(response);
    loggedIn.value = (await userService.isValidLogin()) ?? false;
  }

  void initUser(BackendlessUser? user) {
    if (user != null && user.properties != null) {
      userModel.value = UserModel.fromMap(Map<String, dynamic>.from(user.properties));
      userModel.value.objectId = user.getObjectId();
      GetStorage().write(GSKey.isAuthUser, true);
    }
  }

  Future uploadAccountAvatar() async {
    File? file = await CameraOption().showCameraOptions(Get.context!, isAvatar: true);
    if (file != null) {
      NavigationController().loading();
      String? response =
      await APIManager.uploadFile(file, BLPath.user, const Uuid().v4());
      if (response != null) {
        Uri uri = Uri.parse(response);
        userModel.value.avatar = uri;
        await updateUser();
        NavigationController().loading(isLoading: false);
      } else {
        Get.snackbar('Upload image Error', "Something wrong!");
        NavigationController().loading(isLoading: false);
      }
    } else {
      Get.snackbar('Upload image Error', "Something wrong!");
      NavigationController().loading(isLoading: false);
    }
  }

  Future updateUser() async {
    BackendlessUser? backendUser = await userService.getCurrentUser();
    if (backendUser == null) return;
    Map<String, dynamic> data = userModel.toJson();
    data['addressModel'] = user.addressModel?.toJson();
    backendUser.setProperties(
      {... backendUser.properties, ... data}
    );
    try {
      var res = await userService.update(backendUser);
      userModel.value = UserModel.fromMap(Map<String, dynamic>.from(res!.properties));
      return userModel;
    } catch (e) {
      return e.toString();
    }
  }

  Future signUp(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      bool invited = false,
      showLoading = true}) async {
    if (showLoading) NavigationController().loading();
    var res = await AuthAPI(auth: userService)
        .signup(email, password);
    if (res is String) {
      if (showLoading) {
        NavigationController().loading(isLoading: false);
        WarningMessageDialog.showDialog(Get.context!, res);
      }
    } else {
      if (guestUserId != null) {
        await AuthAPI(auth: userService).cleanupGuestUser();
      } else {
        await AuthAPI(auth: userService)
            .login(email, password);
      }
      if (showLoading) NavigationController().loading(isLoading: false);
      loggedIn.value = true;
      user.firstname = firstName;
      user.lastname = lastName;
      await updateUser();
      Get.to(() => const AccountSetup());
    }
  }

  Future changePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword}) async {
    String? errorMsg;
    if (oldPassword.isEmpty) {
      errorMsg = 'Enter Current Password';
    } else if (newPassword.isEmpty) {
      errorMsg = 'Enter New Password';
    } else if (newPassword != confirmPassword) {
      errorMsg = 'Confirm password is not matched';
    }
    if (errorMsg != null) {
      WarningMessageDialog.showDialog(Get.context!, errorMsg);
      return;
    }

    Get.back();
    NavigationController().loading();
    BackendlessUser? user = await userService.getCurrentUser();
    if (user == null) {
      errorMsg = 'Something wrong!';
    } else {
      try {
        user = await userService.login(user.email, oldPassword);
      } catch (e) {
        errorMsg = 'Your current password does not match. Please try again.';
      }
    }

    if (errorMsg != null) {
      NavigationController().loading(isLoading: false);
      WarningMessageDialog.showDialog(Get.context!, errorMsg);
      return;
    }

    user!.password = newPassword;
    await Backendless.data.of(BLPath.user).save(user.toJson());
    NavigationController().loading(isLoading: false);
    WarningMessageDialog.showDialog(Get.context!, 'Saved changes!');
  }
}