import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/common/app_placeholder.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/page/job/views/widget/schedule_card.dart';

class JobSchedule extends GetWidget<JobController> {

  JobSchedule(this.jobModel, {Key? key}) : super(key: key);

  final JobModel jobModel;
  late final List<ScheduleModel> _scheduleModels = jobModel.scheduleModels;
  // late List schedules = [
  //   {
  //     "id": 1,
  //     "personnel": {
  //       "name": "Personnel Name",
  //       "image": "https://semantic-ui.com/images/avatar/large/elliot.jpg",
  //     },
  //     "hoursToComplete": 2,
  //     "note": "These are a few additional details about what needs to be done today. ",
  //     "date": "2022-01-04 00:00:00.000Z",
  //     "startTime": "1:33 PM",
  //     "endTime": "2:33 PM",
  //     "isAnytime": false,
  //     "isCompleted": false
  //   }
  // ];
  final isAddScheduleOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> AppTabPanel(
      children: [
        const Text('Schedule', style: AppStyles.headerRegular),
        if (_scheduleModels.isEmpty && !isAddScheduleOpen.value)
          const AppPlaceholder(
            title: 'No Appointments Yet',
            subtitle: "You haven't schedules any appointments for this job yet.",
          ),
        const SizedBox(height: 10,),
        Column(
          children: _scheduleModels.map((schedule) =>
              ScheduleCard(schedule: schedule)).toList(),
        ),
        Visibility(
            visible: isAddScheduleOpen.value,
            child: AddScheduleDialog(
              onClose: () {
                isAddScheduleOpen.value = false;
              },
            )
        ),
        Visibility(
            visible: !isAddScheduleOpen.value,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppAddButton(
                "Add to Schedule",
                iconColor: AppColors.primary_1,
                onPressed: () {
                  isAddScheduleOpen.value = true;
                },
              ),
            )
        ),
        const SizedBox(height: 32,),
      ],
    ));
  }
}