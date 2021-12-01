import 'package:get/get.dart';
import '../job_controller.dart';

class JobBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<JobController>(JobController()/*, permanent: true*/);
  }
}
