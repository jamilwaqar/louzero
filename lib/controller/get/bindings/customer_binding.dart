import 'package:get/get.dart';
import 'package:louzero/controller/get/customer_controller.dart';

class CustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CustomerController>(CustomerController());
  }
}
