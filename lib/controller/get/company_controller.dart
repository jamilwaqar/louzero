import 'package:get/get.dart';
import 'package:louzero/models/company_models.dart';
import 'base_controller.dart';

class CompanyController extends GetxController {

  final companyModel = Rx<CompanyModel?>(null);

  List<CompanyModel> get companies =>
      Get.find<BaseController>().companies.value;


  @override
  void onInit() {
    companyModel.value = Get.arguments;
    if (companyModel.value != null) {
      // fetchSiteProfile(companyModel.value!.objectId!);
    }
    super.onInit();
  }
}
