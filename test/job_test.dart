import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:mockito/mockito.dart';
import 'src/mocks.dart';


final _jobModel = MockJobModel();

class MockBackendlessData extends Mock implements IDataStore {
  @override
  Future save(entity) {
    Map<String, dynamic> data = _jobModel.toJson();
    data['billingLineModels'] =
        _jobModel.billingLineModels.map((e) => e.toJson()).toList();
    data['scheduleModels'] =
        _jobModel.scheduleModels.map((e) => e.toJson()).toList();
    return Future.value(data);
  }
}

void main() {

  setUp(() {
    Get.put(AuthController());
    Get.put(BaseController());
    Get.put(JobController())
      .jobModel = _jobModel;
  });

  tearDown(() {});

  test("All Jobs", () {
    final controller = Get.find<JobController>();
    controller.baseController.jobs.add(_jobModel);
    controller.save(_jobModel);

    expect(controller.jobModels.length, 1);
    expect(controller.jobModels.first.objectId, _jobModel.objectId);
    expect(Get.find<BaseController>().jobs.length, 1);
    expect(Get.find<BaseController>().jobs.first.jobType, _jobModel.jobType);
  });
}