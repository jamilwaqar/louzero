import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:mockito/mockito.dart';
import '../src/mocks.dart' hide mockBLDataStore;

class MockBackendlessData extends Mock implements IDataStore {
  @override
  Future save(entity) {
    Map<String, dynamic> data = mockJobModel.toJson();
    data['billingLineModels'] =
        mockJobModel.billingLineModels.map((e) => e.toJson()).toList();
    data['scheduleModels'] =
        mockJobModel.scheduleModels.map((e) => e.toJson()).toList();
    return Future.value(data);
  }
}

final mockData = MockBackendlessData();

void main() {
  setUp(() {
    Get.put(AuthController(mockBLUserService));
    Get.put(BaseController());
    Get.put(JobController())
      .jobModel = mockJobModel;
  });

  tearDown(() {});

  test("All Jobs", () async {
    final controller = Get.find<JobController>();
    controller.baseController.jobs.add(mockJobModel);
    await controller.save(mockJobModel, store: mockData);

    expect(controller.jobModels.length, 1);
    expect(controller.jobModels.first.objectId, mockJobModel.objectId);
    expect(Get.find<BaseController>().jobs.length, 1);
    expect(Get.find<BaseController>().jobs.first.jobType, mockJobModel.jobType);
  });
}