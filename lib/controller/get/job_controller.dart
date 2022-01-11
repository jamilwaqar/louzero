import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/models/models.dart';
import 'base_controller.dart';

class JobController extends GetxController {
  final baseController = Get.find<BaseController>();

  List<JobModel> get jobModels => baseController.jobs;

  Future save(JobModel model, IDataStore store) async {
    Map<String, dynamic> data = model.toJson();
    data['billingLineModels'] =
        model.billingLineModels.map((e) => e.toJson()).toList();
    if (data['objectId'] == null) {
      data.remove('objectId');
    }
    try {
      dynamic response = await store.save(data);
      JobModel newModel = JobModel.fromMap(response);
      if (model.objectId == null) {
        List<JobModel> newList = [...baseController.jobs, newModel];
        baseController.jobs = newList;
      } else {
        updateCustomerModel(newModel);
      }
      update();
      return newModel;
    } catch (e) {
      print('save data error: ${e.toString()}');
      return e.toString();
    }
  }

  updateCustomerModel(JobModel model) {
    List<JobModel> models = [...jobModels];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    baseController.jobs = models;
  }
}