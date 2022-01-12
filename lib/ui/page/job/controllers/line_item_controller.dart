import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/models/inventory_item.dart';
import 'package:uuid/uuid.dart';

class LineItemController extends GetxController {
  final Uuid uuid = const Uuid();

  final CustomerContact contact = CustomerContact(
      email: 'nswanson@emailaddress.net',
      firstName: 'Nicole',
      lastName: 'Swanson',
      phone: '1 (360) 936-7594',
      role: 'Home Owner',
      types: [CTContactType.primary]);

  final AddressModel address = AddressModel(
      country: 'United States',
      street: '123 Alphabet Blvd.',
      city: 'Portland',
      state: 'OR',
      zip: '97202');

  RxList<BillingLineModel> lineItems = <BillingLineModel>[].obs;

  addLineItem(BillingLineModel item) {
    lineItems.add(item);
    update();
  }

  deleteLineItemById(String id) {
    lineItems.removeWhere((element) => element.objectId == id);
    update();
  }

  String get newId {
    return uuid.v1();
  }

  String get nameAndRole {
    return "${contact.firstName} ${contact.lastName} - ${contact.role}";
  }

  String get fullAddress {
    return " ${address.street} ${address.city},  ${address.state}  ${address.zip}";
  }

  String get cityStateZip {
    return "${address.city},  ${address.state}  ${address.zip}";
  }

  double get subTotal {
    return lineItems.fold(0, (sum, item) {
      double price = item.price * item.quantity;
      if (item.discountAmount != null) {
        price = price - item.discountAmount!;
      }
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
