import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/models/inventory_item.dart';

class LineItemController extends GetxController {
  final baseController = Get.find<BaseController>();
  final jobController = Get.find<JobController>();
  late final RxList<BillingLineModel> lineItems = jobController.billingLineModels;
  final _editLineId = ''.obs;
  String get editLineId => _editLineId.value;

  set editLineId(val) {
    _editLineId.value = val;
    update();
  }

  addLineItem(BillingLineModel item, {IDataStore? store, showLoading = true}) async {
    try {
      store ??= Backendless.data.of(BLPath.billingLine);
      Map<String, dynamic> data = item.toJson();
      if (showLoading) {
        NavigationController().loading();
      }
      try {
        dynamic response = await store.save(data);
        BillingLineModel newModel = BillingLineModel.fromJson(Map<String, dynamic>.from(response));
        if (editLineId.isNotEmpty) {
          int index = lineItems.indexWhere((e) => e.objectId == item.objectId);
          lineItems.removeWhere((e) => e.objectId == item.objectId);
          lineItems.insert(index, item);
          editLineId = '';
        } else {
          lineItems.add(newModel);
        }
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
      store ??= Backendless.data.of(BLPath.billingLine);
      dynamic response = await store.remove(entity: {"objectId": objectId});
      lineItems.removeWhere((element) => element.objectId == objectId);
      jobController.billingLineModels.value = [... lineItems];
      update();
      if (showLoading) {
        NavigationController().loading(isLoading: false);
      }
      return response;
    } catch(e) {
      if (showLoading) {
        NavigationController().loading(isLoading: false);
      }
      return e.toString();
    }
  }

  double get subTotal {
    return lineItems.fold(0, (sum, item) {
      double price = item.price * item.quantity;
      price = price - item.discountAmount;
      return sum + price;
    });
  }

  List<InventoryItem> get inventory {
    return const [
      InventoryItem(
        id: '001',
        description: 'Water Filters',
        price: 20,
      ),
      InventoryItem(
        id: '002',
        description: 'Pool Cleaning - Annual',
        price: 250,
      ),
      InventoryItem(
        id: '004',
        description: 'Pool Water Balancing',
        price: 175,
      ),
      InventoryItem(
        id: '005',
        description: 'Pool Alkalinity Increaser',
        price: 44.99,
      ),
      InventoryItem(
        id: '006',
        description: 'Pool Skimmer and Brushes',
        price: 138.95,
      ),
      InventoryItem(
        id: '007',
        description: 'Algae Brush - Stainless Steel ',
        price: 33.85,
      ),
      InventoryItem(
        id: '008',
        description: 'Wireless Floating Pool Thermometer',
        price: 63.95,
      ),
    ];
  }
}
