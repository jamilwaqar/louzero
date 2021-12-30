import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/ui/page/job/models/line_item.dart';

class LineItemController extends GetxController {
  final CustomerContact contact = CustomerContact(
      email: 'nswanson@emailaddress.net',
      firstName: 'Nicole',
      lastName: 'Swanson',
      phone: '1 (360) 936-7594',
      role: 'Home Owner',
      types: [CTContactType.primary]);

  final AddressModel billingAddress = AddressModel(
      country: 'United States',
      street: '123 Alphabet Blvd.',
      city: 'Portland',
      state: 'OR',
      zip: '97202');

  String get nameAndRole {
    return "${contact.firstName} ${contact.lastName} - ${contact.role}";
  }

  String get fullAddress {
    return " ${billingAddress.street} ${billingAddress.city},  ${billingAddress.state}  ${billingAddress.zip}";
  }

  String get cityStateZip {
    return "${billingAddress.city},  ${billingAddress.state}  ${billingAddress.zip}";
  }

  RxList<LineItem> lineItems = <LineItem>[
    // Sample Data (remove in prod)
    const LineItem(
      description: 'Clean Pool',
      count: 1,
      price: 50.00,
      subtotal: 50.00,
    ),
    const LineItem(
      description: 'Solar Heating System',
      count: 2,
      price: 100.00,
      subtotal: 200.00,
      note:
          'Adding in an interesting comment about what this is and why it’s here. If I need to add more than one line of text, this input grows vertically as needed!',
    ),
  ].obs;

  addLineItem(LineItem item) {
    lineItems.add(item);
    update();
  }
}
