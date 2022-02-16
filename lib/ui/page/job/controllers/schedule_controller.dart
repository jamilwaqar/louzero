import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/job_models.dart';

class ScheduleController extends GetxController {
  final jobController = Get.find<JobController>();
  late final scheduleModels = jobController.scheduleModels;

  save(ScheduleModel item, {IDataStore? store, showLoading = true}) async {
    store ??= Backendless.data.of(BLPath.schedule);
    try {
      Map<String, dynamic> data = item.toJson();
      if (showLoading) {
        NavigationController().loading();
      }
      data.remove('objectId');
      try {
        dynamic response = await store.save(data);
        ScheduleModel newModel = ScheduleModel.fromJson(Map<String, dynamic>.from(response));
        if (item.objectId != null) {
          int index = scheduleModels.indexWhere((e) => e.objectId == item.objectId);
          scheduleModels.removeWhere((e) => e.objectId == item.objectId);
          scheduleModels.insert(index, item);
        } else {
          scheduleModels.add(newModel);
        }
        JobModel jobModel = jobController.jobModel!;
        jobModel.scheduled = newModel.startTime;
        await jobController.save(jobModel);
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
    } catch (e) {
      return e.toString();
    }
  }

  Future delete(String objectId, {IDataStore? store}) async {
    bool showLoading = store == null;
    if (showLoading) {
      NavigationController().loading();
    }
    try {
      store ??= Backendless.data.of(BLPath.schedule);
      dynamic response = await store.remove(entity: {"objectId": objectId});
      scheduleModels.removeWhere((element) => element.objectId == objectId);
      jobController.scheduleModels.value = [... scheduleModels];
      update();
      return response;
    } catch(e) {
      return e.toString();
    }
  }

  ScheduleModel? scheduleById(String id) {
    if (scheduleModels.isEmpty) return null;
    try {
      return scheduleModels.firstWhere((e) => e.objectId == id);
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
