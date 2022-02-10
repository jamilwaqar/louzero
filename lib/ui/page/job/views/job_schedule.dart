import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_placeholder.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/job/controllers/schedule_controller.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/page/job/views/widget/schedule_card.dart';

class JobSchedule extends GetWidget<ScheduleController> {
  JobSchedule({Key? key}) : super(key: key);

  final _isAddScheduleOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScheduleController>(
        builder: (controller) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Schedule', style: AppStyles.headerRegular),
                if (controller.scheduleModels.isEmpty &&
                    !_isAddScheduleOpen.value)
                  const AppPlaceholder(
                    title: 'No Appointments Yet',
                    subtitle:
                        "You haven't schedules any appointments for this job yet.",
                  ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: controller.scheduleModels
                      .map((schedule) =>
                          ScheduleCard(scheduleId: schedule.objectId!))
                      .toList(),
                ),
                Visibility(
                    visible: _isAddScheduleOpen.value,
                    child: AddScheduleDialog(
                      onClose: () {
                        _isAddScheduleOpen.value = false;
                        controller.update();
                      },
                    )),
                Visibility(
                    visible: !_isAddScheduleOpen.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AppAddButton(
                        "Add to Schedule",
                        iconColor: AppColors.primary_1,
                        onPressed: () {
                          _isAddScheduleOpen.value = true;
                          controller.update();
                        },
                      ),
                    )),
                const SizedBox(height: 32),
              ],
            ));
  }
}
