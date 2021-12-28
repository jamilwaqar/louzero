import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/models.dart';

class JobController extends GetxController {
  Rx<List<JobModel>> jobModelList = Rx<List<JobModel>>(tempJobModels ?? []);

  List<JobModel> get jobModels => jobModelList.value;

  void save() async {}
}