import 'dart:io';
import 'package:get/get.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/controller/state/auth_manager.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/widget/dialolg/popup/camera_option.dart';
import 'base_controller.dart';

class CompanyController extends GetxController {

  final _companyModel = CompanyModel().obs;

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
        AuthManager.userModel!.activeCompanyId = res['objectId'];
        Get.find<BaseController>().activeCompany = newModel;
        await AuthManager().updateUser();
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
      String? response = await APIManager.uploadFile(file, BLPath.company, company.objectId!);
      if (response != null) {
        Uri uri = Uri.parse(response);
        company.avatar = uri;
        createOrEditCompany(company, addressModel: company.address!, isEdit: true);
      } else {

      }
    } else {

    }
  }

  @override
  void onInit() {
    company = Get.arguments ?? CompanyModel();
    super.onInit();
  }
}
