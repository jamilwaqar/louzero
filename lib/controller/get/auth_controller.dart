import 'dart:io';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {

  bool get isAuthUser => GetStorage().read(GSKey.isAuthUser) ?? false;

  final userModel = Rx<UserModel>(UserModel());

  UserModel get user => userModel.value;

  String? guestUserId;
  String? inviteModelId;

  final loggedIn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    BackendlessUser? response = await Backendless.userService.getCurrentUser();
    initUser(response);
    loggedIn.value = (await Backendless.userService.isValidLogin()) ?? false;
  }

  void initUser(BackendlessUser? user) {
    if (user != null) {
      userModel.value = UserModel.fromJson(Map<String, dynamic>.from(user.properties));
      userModel.value.objectId = user.getObjectId();
      GetStorage().write(GSKey.isAuthUser, true);
    }
  }

  Future uploadAccountAvatar() async {
    File? file = await CameraOption().showCameraOptions(Get.context!);
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
    BackendlessUser? user = await Backendless.userService.getCurrentUser();
    if (user == null) return;
    user.setProperties(
      {... user.properties, ... userModel.toJson()}
    );
    try {
      var res = await Backendless.userService.update(user);
      userModel.value = UserModel.fromJson(Map<String, dynamic>.from(res!.properties));
      return userModel;
    } catch (e) {
      return e.toString();
    }
  }
}