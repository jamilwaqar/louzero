import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/ui/page/customer/customers.dart';
import '../../global_config/flutter_test_config.dart';
import '../../src/mocks.dart';

void main() {
  Get.put(AuthController(mockBLUserService));
  Get.put(BaseController());
  Get.put(CustomerController());
  testWidgets('Customer List Page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const CustomerListPage(), tester: tester));
    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('New Customer'), findsOneWidget);
  });
}
