import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/dashboard/dashboard.dart';
import '../global_config/flutter_test_config.dart';
import '../src/mocks.dart';

void main() {
  Get.put(AuthController(mockBLUserService));
  testWidgets('Dashboard page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: DashboardPage(), tester: tester));
    expect(find.text('Dashboard'), findsOneWidget);

    expect(find.text('Jobs'), findsOneWidget);
    expect(find.text('Add Job'), findsOneWidget);
    expect(find.text('Search Jobs'), findsOneWidget);

    expect(find.text('Customers'), findsOneWidget);
    expect(find.text('Add Customer'), findsOneWidget);
    expect(find.text('View All'), findsOneWidget);
  });
}
