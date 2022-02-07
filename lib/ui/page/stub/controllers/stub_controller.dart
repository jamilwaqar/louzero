import 'package:get/get.dart';
import 'package:louzero/ui/page/stub/models/mockJob.dart';
import 'package:louzero/ui/page/stub/util/mock_data.dart';

class StubController extends GetxController {
  final _title = 'Clients'.obs;

  var _count = 0.obs;

  int get count => _count.value;

  String get title => _title.value;

  set count(int amt) {
    _count.value = amt;
  }

  set title(String title) {
    _title.value = title;
  }

  void increment() {
    _count++;
  }

  final List<MockJob> _jobs = List<MockJob>.generate(
    20,
    (index) => MockJob(
        id: '0',
        name: MockData.companyName(),
        fullName: MockData.fullName(),
        jobType: MockData.getOne(['Repair', 'Estimate', 'Install']),
        address: MockData.address(),
        date: MockData.dateString(),
        total: MockData.price(max: 500)),
  );

  List<MockJob> get items => _jobs;
}
