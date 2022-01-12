import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/models/inventory_item.dart';
import 'package:uuid/uuid.dart';

class LineItemController extends GetxController {
  final Uuid uuid = const Uuid();
  final baseController = Get.find<BaseController>();
  final jobController = Get.find<JobController>();
  RxList<BillingLineModel> lineItems = <BillingLineModel>[].obs;
  final _editLineId = ''.obs;
  String get editLineId => _editLineId.value;

  set editLineId(val) {
    _editLineId.value = val;
    update();
  }

  addLineItem(BillingLineModel item) async {
    try {
      JobModel jobModel = baseController.jobModelById(item.jobId)!;
      jobModel.billingLineModels = [... jobModel.billingLineModels, item];
      dynamic response = await jobController.save(jobModel);
      if (editLineId.isNotEmpty) {
        int index = lineItems.indexWhere((e) => e.objectId == item.objectId);
        lineItems.removeWhere((e) => e.objectId == item.objectId);
        lineItems.insert(index, item);
        editLineId = '';
      } else {
        lineItems.add(item);
      }
      update();
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteLineItemById(String id, String jobId) async {
    try {
      JobModel jobModel = baseController.jobModelById(jobId)!;
      lineItems.removeWhere((element) => element.objectId == id);
      jobModel.billingLineModels = [... lineItems];
      dynamic response = await jobController.save(jobModel);
      update();
      return response;
    } catch(e) {
      return e.toString();
    }
  }

  String get newId {
    return uuid.v1();
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
