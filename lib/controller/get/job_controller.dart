import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/models.dart';
import 'base_controller.dart';

class JobController extends GetxController {
  final baseController = Get.find<BaseController>();

  List<JobModel> get jobModels => baseController.jobs;

  Future save(JobModel model, {IDataStore? store, showLoading = true}) async {
    store ??= Backendless.data.of(BLPath.job);
    Map<String, dynamic> data = model.toJson();
    data['billingLineModels'] =
        model.billingLineModels.map((e) => e.toJson()).toList();
    data['scheduleModels'] =
        model.scheduleModels.map((e) => e.toJson()).toList();
    if (data['objectId'] == null) {
      data.remove('objectId');
    }
    if (showLoading) {
      NavigationController().loading();
    }
    try {
      dynamic response = await store.save(data);
      JobModel newModel = JobModel.fromMap(response);
      if (model.objectId == null) {
        List<JobModel> newList = [...baseController.jobs, newModel];
        baseController.jobs = newList;
      } else {
        updateJobModel(newModel);
      }
      update();
      if (showLoading) {
        NavigationController().loading(isLoading: false);
      }
      return newModel;
    } catch (e) {
      if (showLoading) {
        NavigationController().loading(isLoading: false);
      }
      return e.toString();
    }
  }

  updateJobModel(JobModel model) {
    List<JobModel> models = [...jobModels];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    baseController.jobs = models;
  }
}