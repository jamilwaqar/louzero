import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/models.dart';

class CustomerController extends GetxController {

  _fetchSiteProfile(String customerId) async {
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
      add(UpdateCustomerModelEvent(model));
    }
  }

  _updateCustomerModel(CustomerModel model) async {
    List<CustomerModel> models = [... state.customers];
    int index = models.indexWhere((e) => e.objectId == model.objectId);
    models.removeWhere((e) => e.objectId == model.objectId);
    models.insert(index, model);
    yield state.copyWith(customers: models, stateFlag: !state.stateFlag);
  }

  CustomerModel? customerModelById(String customerId) {
    try {
      return state.customers.firstWhere((e) => e.objectId == customerId);
    } catch(e) {
      return null;
    }
  }
}