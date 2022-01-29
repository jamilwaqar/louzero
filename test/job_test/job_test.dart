import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import '../src/mock_user_service.dart';
import '../src/mocks.dart';


/*class MockBackendlessData extends Mock implements IDataStore {
  @override
  Future save(entity) {
    Map<String, dynamic> data = _jobModel.toJson();
    data['billingLineModels'] =
        _jobModel.billingLineModels.map((e) => e.toJson()).toList();
    data['scheduleModels'] =
        _jobModel.scheduleModels.map((e) => e.toJson()).toList();
    return Future.value(data);
  }
}*/

void main() {
  final MockBLUserService mockBackendlessAuth = MockBLUserService();
  setUp(() {
    Get.put(AuthController(mockBackendlessAuth));
    Get.put(BaseController());
    Get.put(JobController())
      .jobModel = mockJob;
  });

  tearDown(() {});

  test("All Jobs", () {
    final controller = Get.find<JobController>();
    controller.baseController.jobs.add(mockJob);
    controller.save(mockJob);

    expect(controller.jobModels.length, 1);
    expect(controller.jobModels.first.objectId, mockJob.objectId);
    expect(Get.find<BaseController>().jobs.length, 1);
    expect(Get.find<BaseController>().jobs.first.jobType, mockJob.jobType);
  });
}