import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/ui/page/job/jobs.dart';
import '../../global_config/flutter_test_config.dart';
import '../../src/mocks.dart';

//TODO: Work in progress:
void main() {
  Get.put(AuthController(mockBLUserService));
  Get.put(BaseController());
  Get.put(JobController());
  testWidgets('JobList page', (WidgetTester tester) async {
    await tester.pumpWidget(
        makeTestableWidget(child: const JobListPage(), tester: tester));
    expect(find.text('All Jobs'), findsOneWidget);
    expect(find.text('Canceled'), findsOneWidget);
  });
}
