import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import '../src/mocks.dart';

void main() {
  Get.put(BaseController(userService: mockBLUserService));

  CustomerController controller = Get.put(CustomerController())
    ..customerModel = mockCustomer;

  setUp(() {
    controller.baseController.customers.add(mockCustomer);
  });
  tearDown(() {});

  test("Update Customer", () {
    controller.updateCustomerModel(mockCustomer);
    expect(controller.customers.length, 1);
    expect(controller.customers.first.objectId, mockCustomer.objectId);
    expect(Get.find<BaseController>().customers.length, 1);
    expect(Get.find<BaseController>().customers.first.companyName, mockCustomer.companyName);
  });

  test('Customer by Id', () {
    controller.baseController.customers.add(mockCustomer);
    CustomerModel? model = controller.customerModelById(mockCustomer.objectId);

    expect(mockCustomer.objectId, model!.objectId);
    expect(mockCustomer, model);
  });

  test('Save', () async {
    controller.baseController.customers.add(mockCustomer);
    controller.baseController.activeCompany = CompanyModel()..objectId = mockCustomer.companyName;

    final updatedObject = (await controller.save(mockCustomer, mockBLDataStore)) as CustomerModel;

    expect(updatedObject, isNotNull);
    expect(updatedObject.objectId, mockCustomer.objectId);
    expect(updatedObject.type, mockCustomer.type);
    expect(updatedObject.serviceAddress.country, mockCustomer.serviceAddress.country);
    expect(updatedObject.serviceAddress.state, mockCustomer.serviceAddress.state);
    expect(updatedObject.serviceAddress.city, mockCustomer.serviceAddress.city);
    expect(updatedObject.serviceAddress.street, mockCustomer.serviceAddress.street);
    expect(updatedObject.serviceAddress.zip, mockCustomer.serviceAddress.zip);
  });
}