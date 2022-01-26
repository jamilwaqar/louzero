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
  final _isAddScheduleOpen = false.obs;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Schedule', style: AppStyles.headerRegular),
                if (_scheduleModels.isEmpty && !_isAddScheduleOpen.value)
                  const AppPlaceholder(
                    title: 'No Appointments Yet',
                    subtitle:
                        "You haven't schedules any appointments for this job yet.",
                  ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: _scheduleModels
                      .map((schedule) => ScheduleCard(
                            schedule: schedule,
                            jobModel: jobModel,
                          ))
                      .toList(),
                ),
                Visibility(
                    visible: _isAddScheduleOpen.value,
                    child: AddScheduleDialog(
                      jobModel: jobModel,
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
