import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/models.dart';
import 'base_controller.dart';

class JobController extends GetxController {
  final baseController = Get.find<BaseController>();

  final _jobModel = Rx<JobModel?>(null);
  JobModel? get jobModel => _jobModel.value;
  set jobModel(val) => _jobModel.value = val;

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
        if (jobModel != null) {
          jobModel = newModel;
        }
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

  void updateJobModel(JobModel model) {
    List<JobModel> models = [...jobModels];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    baseController.jobs = models;
  }

  ScheduleModel? scheduleById(String id) {
    if (jobModel == null) return null;
    try {
      return jobModel!.scheduleModels.firstWhere((e) => e.objectId == id);
    } catch (e) {
      return null;
    }
  }

  int convertMilliseconds(String date, DateTime dateTime) {
    String filter = date.toLowerCase().replaceAll('am', '').replaceAll('pm', '').replaceAll(' ', '');
    List<String>ar = filter.split(':');
    bool pm = date.toLowerCase().contains('pm');
    int hr =  int.parse(ar[0]);
    if (pm) hr += 12;
    int min = int.parse(ar[1]);
    DateTime start = DateTime(dateTime.year, dateTime.month, dateTime.day, hr, min);
    return start.millisecondsSinceEpoch;
  }
}