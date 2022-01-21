import 'dart:io';
import 'package:get/get.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/widget/dialog/popup/camera_option.dart';
import 'package:uuid/uuid.dart';
import 'base_controller.dart';

class CompanyController extends GetxController {
  final _companyModel = CompanyModel().obs;
  final _authController = Get.find<AuthController>();
  RxBool isEditing = false.obs;
  void toggleEdit(bool val) {
    isEditing = RxBool(val);
    update();
  }

  RxInt _selectedCompany = 1.obs;

  int get selectedCompany {
    return _selectedCompany.value;
  }

  set selectedCompany(int val) {
    _selectedCompany.value = val;
    update();
  }

  CompanyModel get company => _companyModel.value;

  set company(CompanyModel model) {
    _companyModel.value = model;
  }

  List<CompanyModel> get companies => Get.find<BaseController>().companies;

  Future createOrEditCompany(CompanyModel companyModel,
      {required AddressModel addressModel,
      required bool isEdit,
      bool isActiveCompany = false}) async {
    NavigationController().loading();
    String currentUserId = _authController.user.objectId!;
    if (!isEdit && !companyModel.users.contains(currentUserId)) {
      companyModel.users.add(currentUserId);
    }
    Map<String, dynamic> data = companyModel.toJson();
    data['address'] = addressModel.toJson();

    var res = await APIManager.save(BLPath.company, data);
    if (res is Map) {
      final newModel = CompanyModel.fromMap(res);
      if (isEdit) {
        company = newModel;
      } else {
        companies.add(newModel);
      }
      if (isActiveCompany) {
        _authController.user.activeCompanyId = res['objectId'];
        Get.find<BaseController>().activeCompany = newModel;
        await _authController.updateUser();
      }
    }
    update();
    NavigationController().loading(isLoading: false);
  }

  void deleteCompany(String objectId) async {
    NavigationController().loading();
    await APIManager.delete(BLPath.company, objectId);
    companies.removeWhere((element) => element.objectId == objectId);
    update();
    NavigationController().loading(isLoading: false);
  }

  void uploadAvatar() async {
    File? file = await CameraOption().showCameraOptions(Get.context!);
    if (file != null) {
      NavigationController().loading();
      String? response =
          await APIManager.uploadFile(file, BLPath.company, const Uuid().v4());
      if (response != null) {
        Uri uri = Uri.parse(response);
        company.avatar = uri;
        createOrEditCompany(company,
            addressModel: company.address!, isEdit: true);
      } else {
        Get.snackbar('Upload image Error', "Something wrong!");
        NavigationController().loading(isLoading: false);
      }
    } else {
      Get.snackbar('Upload image Error', "Something wrong!");
      NavigationController().loading(isLoading: false);
    }
  }

  @override
  void onInit() {
    company = Get.arguments ?? CompanyModel();
    super.onInit();
  }
}
