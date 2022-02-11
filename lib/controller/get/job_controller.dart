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
  set jobModel(val) {
    _jobModel.value = val;
    if (val != null) {
        _fetchSchedules().then((value) => scheduleModels.value = value);
        _fetchBillingLines().then((value) => billingLineModels.value = value);
    }
  }

  final RxList<ScheduleModel> scheduleModels= <ScheduleModel>[].obs;
  final RxList<BillingLineModel> billingLineModels = <BillingLineModel>[].obs;
  List<JobModel> get jobModels => baseController.jobs;

  Future save(JobModel model, {IDataStore? store, showLoading = true}) async {
    store ??= Backendless.data.of(BLPath.job);
    Map<String, dynamic> data = model.toJson();
    if (showLoading) {
      NavigationController().loading();
    }
    try {
      dynamic response = await store.save(data);
      JobModel newModel = JobModel.fromJson(response);
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

  Future _fetchSchedules() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "jobId = '${jobModel!.objectId!}'"..pageSize = 100;
    try {
      var response = await Backendless.data.of(BLPath.schedule).find(queryBuilder);
      List<ScheduleModel>list = List<Map>.from(response!).map((e) => ScheduleModel.fromJson(Map<String, dynamic>.from(e))).toList();
      return list;
    } catch (e) {
      return e.toString();
    }
  }

  Future _fetchBillingLines() async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "jobId = '${jobModel!.objectId!}'"..pageSize = 100;
    try {
      var response = await Backendless.data.of(BLPath.billingLine).find(queryBuilder);
      List<BillingLineModel>list = List<Map>.from(response!).map((e) => BillingLineModel.fromJson(Map<String, dynamic>.from(e))).toList();
      return list;
    } catch (e) {
      return e.toString();
    }
  }
}