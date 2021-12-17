import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/models.dart';
import 'base_controller.dart';

class CustomerController extends GetxController {

  final customerModel = Rx<CustomerModel?>(null);

  List<CustomerModel> get customers =>
      Get.find<BaseController>().customers.value;

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

  updateCustomerModel(CustomerModel model) async {
    List<CustomerModel> models = [...customers];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    Get.find<BaseController>().customers.value = models;
  }

  CustomerModel? customerModelById(String customerId) {
    try {
      return customers.firstWhere((e) => e.objectId == customerId);
    } catch (e) {
      return null;
    }
  }

  @override
  void onInit() {
    customerModel.value = Get.arguments;
    if (customerModel.value != null) {
      fetchSiteProfile(customerModel.value!.objectId!);
    }
    super.onInit();
  }
}
