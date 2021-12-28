import 'package:get/get.dart';
import '../company_controller.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CompanyController>(CompanyController());
  }
}
