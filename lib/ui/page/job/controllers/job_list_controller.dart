import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/models/job_models.dart';

class JobListController extends GetxController {
  final baseController = Get.find<BaseController>();

  List<JobModel> get jobModels => baseController.jobs;

  final selectedType = "".obs;
  final selectedDuration = "".obs;
  final isDetailsPopupVisible = false.obs;
  final showCustomDateRange = false.obs;
  DateTime? _startDate;
  DateTime? _endDate;
  int diffInDays = 0;
  double popModalHeight = 0;

  final RxList<JobModel> tableItems = <JobModel>[].obs;

  void searchItems(text) {
    tableItems.clear();
    if (text.toString().isNotEmpty) {
      List currentItems = jobModels;
      List updatedItems = currentItems.where((i) {
        final searchText = text.toString().toLowerCase();
        return i['type'].toString().toLowerCase().contains(searchText) ||
            i['customer'].toString().toLowerCase().contains(searchText) ||
            i['address'].toString().toLowerCase().contains(searchText);
      }).toList();
      tableItems.value = [...updatedItems];
    } else {
      tableItems.value = [...jobModels];
    }
  }

  void sortByType() {
    List currentItems = tableItems;
    List updatedItems = currentItems
        .where((i) =>
            i['type'].toString().toLowerCase() ==
            selectedType.toString().toLowerCase())
        .toList();

    if (selectedType.isNotEmpty) {
      tableItems.value = [...updatedItems];
    } else {
      tableItems.value = [...tableItems];
    }
  }

  void sortByDuration() {
    if (selectedDuration.isEmpty) {
      tableItems.value = [...jobModels];

      return;
    }

    if (selectedDuration.value == "Custom Range") {
      showCustomDateRange.value = true;
      return;
    }

    List<JobModel> currentItems = jobModels;
    List<JobModel> updatedItems = [];
    DateTime now = DateTime.now();
    if (selectedDuration.value == "Yesterday") {
      DateTime prevOfYesterday = now.subtract(const Duration(days: 2));
      updatedItems = currentItems.where((i) {
        if (i['scheduled'].toString().isEmpty) {
          return false;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(i['scheduled']) * 1000);
        return prevOfYesterday.millisecondsSinceEpoch >
                date.millisecondsSinceEpoch &&
            now.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
      }).toList();
    } else if (selectedDuration == "Today") {
      DateTime yesterday = now.subtract(const Duration(days: 1));
      DateTime tomorrow = now.add(const Duration(days: 1));

      updatedItems = currentItems.where((i) {
        if (i['scheduled'].toString().isEmpty) {
          return false;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(i['scheduled']) * 1000);
        return yesterday.millisecondsSinceEpoch > date.millisecondsSinceEpoch &&
            tomorrow.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
      }).toList();
    } else if (selectedDuration == "Tomorrow") {
      DateTime nexOfTomorrow = now.add(const Duration(days: 2));
      updatedItems = currentItems.where((i) {
        if (i['scheduled'].toString().isEmpty) {
          return false;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(i['scheduled']) * 1000);
        return now.millisecondsSinceEpoch > date.millisecondsSinceEpoch &&
            nexOfTomorrow.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
      }).toList();
    } else if (selectedDuration == "This Week") {
      DateTime endOfWeek = now.add(const Duration(days: 8));

      updatedItems = currentItems.where((i) {
        if (i['scheduled'].toString().isEmpty) {
          return false;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(i['scheduled']) * 1000);
        return now.millisecondsSinceEpoch > date.millisecondsSinceEpoch &&
            endOfWeek.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
      }).toList();
    } else if (selectedDuration == "Next Week") {
      DateTime startOfWeek = now.add(const Duration(days: 7));
      DateTime endOfNextWeek = now.add(const Duration(days: 15));

      updatedItems = currentItems.where((i) {
        if (i['scheduled'].toString().isEmpty) {
          return false;
        }

        var date = DateTime.fromMillisecondsSinceEpoch(
            int.parse(i['scheduled']) * 1000);
        return startOfWeek.millisecondsSinceEpoch >
                date.millisecondsSinceEpoch &&
            endOfNextWeek.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
      }).toList();
    }

    tableItems.value = updatedItems;
  }

  void sortItems(category, isASC) {
    List<JobModel> currentItems = tableItems;
    currentItems.sort((a, b) {
      return a[category.toString().toLowerCase()]
          .compareTo(b[category.toString().toLowerCase()]);
    });

    if (isASC) {
      tableItems.value = currentItems.reversed.toList();
    } else {
      tableItems.value = currentItems;
    }
  }

  void sortByCustomRange() {
    List<JobModel> currentItems = items;
    List<JobModel> updatedItems = [];
    DateTime prevOfStart = _startDate!.subtract(const Duration(days: 1));
    DateTime nextOfEnd = _endDate!.add(const Duration(days: 1));
    updatedItems = currentItems.where((i) {
      if (i['scheduled'].toString().isEmpty) {
        return false;
      }
      var date =
          DateTime.fromMillisecondsSinceEpoch(int.parse(i['scheduled']) * 1000);
      return nextOfEnd.millisecondsSinceEpoch > date.millisecondsSinceEpoch &&
          prevOfStart.millisecondsSinceEpoch < date.millisecondsSinceEpoch;
    }).toList();

    tableItems.value = updatedItems;
  }

  void _hideModal() {
    isDetailsPopupVisible.value = false;
  }
}
