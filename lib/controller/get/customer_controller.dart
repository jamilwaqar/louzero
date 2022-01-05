import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/models.dart';
import 'base_controller.dart';

class CustomerController extends GetxController {

  final _customerModel = Rx<CustomerModel?>(null);

  CustomerModel? get customerModel => _customerModel.value;

  set customerModel(CustomerModel? model) => _customerModel.value = model;

  final baseController = Get.find<BaseController>();

  List<CustomerModel> get customers => baseController.customers;

  fetchSiteProfile(String customerId) async {
    CustomerModel? model = customerModelById(customerId);
    if (model != null && model.siteProfiles.isNotEmpty) return;

    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "customerId = '$customerId'";
    List<CTSiteProfile> list = [];
    try {
      var response = await Backendless.data
          .of(BLPath.customerSiteProfile)
          .find(queryBuilder);
      list = List<Map>.from(response!)
          .map((e) => CTSiteProfile.fromMap(e))
          .toList();
    } catch (e) {
      print(e.toString());
    }

    if (model != null) {
      model.siteProfiles = list;
      updateCustomerModel(model);
    }
  }

  updateCustomerModel(CustomerModel model) {
    List<CustomerModel> models = [...customers];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    baseController.customers = models;
  }

  CustomerModel? customerModelById(String customerId) {
    try {
      return customers.firstWhere((e) => e.objectId == customerId);
    } catch (e) {
      return null;
    }
  }

  Future save(CustomerModel model, IDataStore store) async {
    Map<String, dynamic> data = model.toJson();
    data['serviceAddress'] = model.serviceAddress.toJson();
    data['billingAddress'] = model.billingAddress.toJson();
    data['customerContacts'] =
        model.customerContacts.map((e) => e.toJson()).toList();
    if (data['objectId'] == null) {
      data.remove('objectId');
    }
    try {
      dynamic response =
          await /*Backendless.data.of(BLPath.customer)*/ store.save(data);
      CustomerModel newModel = CustomerModel.fromMap(response);
      if (model.objectId == null) {
        List<CustomerModel> newList = [...baseController.customers, newModel];
        baseController.customers = newList;
      } else {
        updateCustomerModel(newModel);
      }
      update();
      return newModel;
    } catch (e) {
      print('save data error: ${e.toString()}');
      return e.toString();
    }
  }

  Future deleteCustomer(String objectId, IDataStore store) async {
    try {
      dynamic response = await store.remove(entity: {"objectId": objectId});
      customers.removeWhere((element) => element.objectId == objectId);
      update();
      return response;
    } catch(e) {
      return e.toString();
    }
  }

  @override
  void onInit() {
    customerModel = Get.arguments;
    if (customerModel != null) {
      fetchSiteProfile(customerModel!.objectId!);
    }
    super.onInit();
  }

  @override
  void onClose() {
    baseController.searchedAddressList = [];
    super.onClose();
  }
}
