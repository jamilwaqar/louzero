import 'package:get/get.dart';
import 'package:louzero/models/company_models.dart';
import 'base_controller.dart';

class CompanyController extends GetxController {

  final _companyModel = CompanyModel().obs;

  CompanyModel get company => _companyModel.value;

  set company(CompanyModel model) {
    _companyModel.value = model;
    // var com = companies.firstWhere((e) => e.objectId == model.objectId);
    // var index = companies.indexOf(com);
    // companies.replaceRange(index, index + 1, [model]);
  }

  List<CompanyModel> get companies =>
      Get.find<BaseController>().companies.value;


  @override
  void onInit() {
    company = Get.arguments ?? CompanyModel();
    super.onInit();
  }
}
