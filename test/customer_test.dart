import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:mockito/mockito.dart';

const _customerId = 'customerId';
const _companyId = 'companyId';
const _country = 'United State';
const _city = 'New York';
const _street = '350 W 40th St';
const _zip = '10018';
const _customerType = 'Residential';
const _state = 'New York';

final AddressModel _addressModel = AddressModel(
    country: _country, street: _street, city: _city, state: _state, zip: _zip);

final CustomerModel _customerModel = CustomerModel(
    companyId: _companyId,
    type: _customerType,
    serviceAddress: _addressModel,
    billingAddress: _addressModel)..objectId = _customerId;

class MockBackendlessData extends Mock implements IDataStore {
  @override
  Future save(entity) {
    Map<String, dynamic> data = _customerModel.toJson();
    data['serviceAddress'] = _customerModel.serviceAddress.toJson();
    data['billingAddress'] = _customerModel.billingAddress.toJson();
    data['customerContacts'] =
        _customerModel.customerContacts.map((e) => e.toJson()).toList();
    return Future.value(data);
  }
}

void main() {
  Get.put(BaseController());

  CustomerController controller = CustomerController()
    ..customerModel.value = _customerModel;

  setUp(() {});
  tearDown(() {});

  test("Update Customer", () {
    controller.baseController.customers.add(_customerModel);
    controller.updateCustomerModel(_customerModel);

    expect(controller.customers.length, 1);
    expect(controller.customers.first.objectId, _customerId);
    expect(Get.find<BaseController>().customers.length, 1);
    expect(Get.find<BaseController>().customers.first.companyId, _companyId);
  });

  test('Customer by Id', () {
    controller.baseController.customers.add(_customerModel);
    CustomerModel? model = controller.customerModelById(_customerId);

    expect(_customerModel.objectId, model!.objectId);
    expect(_customerModel, model);
  });

  test('Save', () async {
    controller.baseController.customers.add(_customerModel);
    controller.baseController.activeCompany = CompanyModel()..objectId = _companyId;
    final dataStore = MockBackendlessData();

    final updatedObject = (await controller.save(_customerModel, dataStore)) as CustomerModel;

    expect(updatedObject, isNotNull);
    expect(updatedObject.objectId, _customerId);
    expect(updatedObject.type, _customerType);
    expect(updatedObject.serviceAddress.country, _country);
    expect(updatedObject.serviceAddress.state, _state);
    expect(updatedObject.serviceAddress.city, _city);
    expect(updatedObject.serviceAddress.street, _street);
    expect(updatedObject.serviceAddress.zip, _zip);
  });
}