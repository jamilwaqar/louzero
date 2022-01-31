import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:mockito/mockito.dart';
import '../src/mocks.dart';

class MockBackendlessData extends Mock implements IDataStore {
  @override
  Future save(entity) {
    Map<String, dynamic> data = mockCustomerModel.toJson();
    data['serviceAddress'] = mockCustomerModel.serviceAddress.toJson();
    data['billingAddress'] = mockCustomerModel.billingAddress.toJson();
    data['customerContacts'] =
        mockCustomerModel.customerContacts.map((e) => e.toJson()).toList();
    return Future.value(data);
  }
}

final mockData = MockBackendlessData();

void main() {
  Get.put(BaseController());

  CustomerController controller = Get.put(CustomerController())
    ..customerModel = mockCustomerModel;

  setUp(() {
    controller.baseController.customers.add(mockCustomerModel);
  });
  tearDown(() {});

  test("Update Customer", () {
    controller.updateCustomerModel(mockCustomerModel);
    expect(controller.customers.length, 1);
    expect(controller.customers.first.objectId, mockCustomerModel.objectId);
    expect(Get.find<BaseController>().customers.length, 1);
    expect(Get.find<BaseController>().customers.first.companyName, mockCustomerModel.companyName);
  });

  test('Customer by Id', () {
    controller.baseController.customers.add(mockCustomerModel);
    CustomerModel? model = controller.customerModelById(mockCustomerModel.objectId!);

    expect(mockCustomerModel.objectId, model!.objectId);
    expect(mockCustomerModel, model);
  });

  test('Save', () async {
    controller.baseController.customers.add(mockCustomerModel);
    controller.baseController.activeCompany = CompanyModel()..objectId = mockCustomerModel.companyName;

    final updatedObject = await controller.save(mockCustomerModel, mockData);

    expect(updatedObject, isNotNull);
    expect(updatedObject.objectId, mockCustomerModel.objectId);
    expect(updatedObject.type, mockCustomerModel.type);
    expect(updatedObject.serviceAddress.country, mockCustomerModel.serviceAddress.country);
    expect(updatedObject.serviceAddress.state, mockCustomerModel.serviceAddress.state);
    expect(updatedObject.serviceAddress.city, mockCustomerModel.serviceAddress.city);
    expect(updatedObject.serviceAddress.street, mockCustomerModel.serviceAddress.street);
    expect(updatedObject.serviceAddress.zip, mockCustomerModel.serviceAddress.zip);
  });
}