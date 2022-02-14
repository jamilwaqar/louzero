import 'package:get/get.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/models/job_models.dart';

enum JobDurationFilter {
  yesterday, today, tomorrow, thisWeek, nextWeek, customRange
}

extension JobDurationFilterEx on JobDurationFilter {
  String get label {
    switch(this) {
      case JobDurationFilter.yesterday:
        return 'Yesterday';
      case JobDurationFilter.today:
        return 'Today';
      case JobDurationFilter.tomorrow:
        return 'Tomorrow';
      case JobDurationFilter.thisWeek:
        return 'This Week';
      case JobDurationFilter.nextWeek:
        return 'Next Week';
      case JobDurationFilter.customRange:
        return 'Custom Range';
    }
  }
}

class JobListController extends GetxController {
  final baseController = Get.find<BaseController>();

  List<JobModel> get jobModels => baseController.jobs;

  final selectedStatus = Rx<JobStatus>(JobStatus.estimate);
  final selectedType = "".obs;
  final selectedDuration = Rx<JobDurationFilter?>(null);
  final isDetailsPopupVisible = false.obs;
  final showCustomDateRange = false.obs;
  DateTime? startDate;
  DateTime? endDate;
  int diffInDays = 0;
  final popModalHeight = 0.0.obs;

  final RxList<JobModel> tableItems = <JobModel>[].obs;

  @override
  void onInit() {
    tableItems.value = jobModels.where((element) => element.status == selectedStatus.value).toList();
    super.onInit();
  }



  void searchItems(text) {
    tableItems.clear();
    if (text.toString().isNotEmpty) {
      List<JobModel> currentItems = jobModels;
      List<JobModel> updatedItems = currentItems.where((i) {
        final searchText = text.toString().toLowerCase();
        return i.jobType.toLowerCase().contains(searchText) /*||
            i['customer'].toString().toLowerCase().contains(searchText) ||
            i['address'].toString().toLowerCase().contains(searchText)*/;
      }).toList();
      tableItems.value = [...updatedItems];
    } else {
      tableItems.value = [...jobModels];
    }
  }

  void sortByType() {
    List<JobModel> currentItems = tableItems;
    List<JobModel> updatedItems = currentItems
        .where((i) =>
            i.jobType.toString().toLowerCase() ==
            selectedType.toString().toLowerCase())
        .toList();

    if (selectedType.isNotEmpty) {
      tableItems.value = [...updatedItems];
    } else {
      tableItems.value = [...tableItems];
    }
  }

  void sortByDuration() {
    if (selectedDuration.value == null) {
      tableItems.value = [...jobModels];
      return;
    }
    List<JobModel> currentItems = jobModels;
    List<JobModel> updatedItems = [];
    switch(selectedDuration.value!) {
      case JobDurationFilter.yesterday:
        updatedItems =
            currentItems.where((i) => i.scheduledAt?.isYesterday ?? false).toList();
        break;
      case JobDurationFilter.today:
        updatedItems =
            currentItems.where((i) => i.scheduledAt?.isToday ?? false).toList();
        break;
      case JobDurationFilter.tomorrow:
        updatedItems =
            currentItems.where((i) => i.scheduledAt?.isTomorrow ?? false).toList();
        break;
      case JobDurationFilter.thisWeek:
        updatedItems =
            currentItems.where((i) => i.scheduledAt?.isInThisWeek ?? false).toList();
        break;
      case JobDurationFilter.nextWeek:
        updatedItems =
            currentItems.where((i) => i.scheduledAt?.isInNextWeek ?? false).toList();
        break;
      case JobDurationFilter.customRange:
        showCustomDateRange.value = true;
        break;
    }
    tableItems.value = updatedItems;
  }

  void sortItems(category, isASC) {
    List<JobModel> currentItems = tableItems;
    // currentItems.sort((a, b) {
    //   return a[category.toString().toLowerCase()]
    //       .compareTo(b[category.toString().toLowerCase()]);
    // });

    if (isASC) {
      tableItems.value = currentItems.reversed.toList();
    } else {
      tableItems.value = currentItems;
    }
  }

  void sortByCustomRange() {
    List<JobModel> currentItems = jobModels;
    List<JobModel> updatedItems = [];
    DateTime prevOfStart = startDate!.subtract(const Duration(days: 1));
    DateTime nextOfEnd = endDate!.add(const Duration(days: 1));
    updatedItems = currentItems.where((i) {
      if (i.scheduledAt == null) {
        return false;
      }
      return nextOfEnd.millisecondsSinceEpoch >
              i.scheduledAt!.millisecondsSinceEpoch &&
          prevOfStart.millisecondsSinceEpoch <
              i.scheduledAt!.millisecondsSinceEpoch;
    }).toList();
    tableItems.value = updatedItems;
  }

  void hideModal() {
    isDetailsPopupVisible.value = false;
  }
}
