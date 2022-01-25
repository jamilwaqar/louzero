import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/widget/switch_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ScheduleCard extends GetWidget<JobController> {
  ScheduleCard({
    Key? key,
    required this.scheduleId
  }) : super(key: key);

  final String scheduleId;
  final _showScheduleDialog = false.obs;
  late final schedule = Get.find<JobController>().scheduleById(scheduleId);
  late final _noteController = TextEditingController(text: schedule?.note);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobController>(
        builder: (controller) {
          final jobModel = controller.jobModel!;
          final schedule = controller.scheduleById(scheduleId);
          if (schedule == null) return const SizedBox();
          final DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(schedule.startTime);
          final monthName = DateFormat.MMM().format(parseDate);
          final day = DateFormat.d().format(parseDate);
          return Column(
            children: [
              !_showScheduleDialog.value ?
              Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 230,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: AppColors.secondary_40,
                                borderRadius: Common.border_24.copyWith(
                                  topRight: const Radius.circular(0),
                                  bottomRight: const Radius.circular(0),
                                )),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(monthName.toUpperCase(), style: const TextStyle(
                                  fontFamily: 'Lato',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.1,
                                  color: Colors.white,
                                )),
                                const SizedBox(height: 8, ),
                                Text(day,  style: const TextStyle(
                                    fontFamily: 'Lato',
                                    fontSize: 45,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.1,
                                    color: Colors.white
                                ))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Container(
                                height: 230,
                                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                                decoration: BoxDecoration(
                                    color: AppColors.secondary_100,
                                    borderRadius: Common.border_24.copyWith(
                                      topLeft: const Radius.circular(0),
                                      bottomLeft: const Radius.circular(0),
                                    )),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(schedule.startEndTime,
                                                  style: const TextStyle(
                                                    fontFamily: 'Lato',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w900,
                                                    letterSpacing: 0.1,
                                                  )),
                                              const SizedBox(height: 16,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(schedule.note ?? '', style: const TextStyle(
                                                      fontFamily: 'Lato',
                                                      fontSize: 16,
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),),
                                        AppPopMenu(
                                          button: const [
                                            SizedBox(
                                              child: Icon(Icons.more_vert, color: AppColors.secondary_60),
                                            ),
                                          ],
                                          items: [
                                            PopMenuItem(
                                              label: 'Edit Appointment',
                                              icon: MdiIcons.pencil,
                                              onTap: () {
                                                _showScheduleDialog.value = true;
                                                controller.update();
                                              },
                                            ),
                                            PopMenuItem(
                                              label: 'Edit Notes',
                                              icon: MdiIcons.fileDocumentOutline,
                                              onTap: () {
                                                _showEditNoteDialog(jobModel, schedule);
                                              },
                                            ),
                                            PopMenuItem(
                                              label: 'Remove',
                                              icon: MdiIcons.trashCanOutline,
                                              onTap: () {
                                                jobModel.scheduleModels.removeWhere((e) => e.objectId == schedule.objectId);
                                                controller.save(jobModel);
                                              },
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 16,),
                                    const Divider(color: AppColors.secondary_80, thickness: 1,),
                                    const SizedBox(height: 16,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            AppAvatar(size: 40, url: schedule.personnelAvatar, placeHolder: AppPlaceHolder.user),
                                            const SizedBox(width: 8,),
                                            Text(schedule.personnelName, style: const TextStyle(
                                              fontFamily: 'Lato',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.1,
                                            )),
                                            const SizedBox(width: 8,),
                                            CircleAvatar(
                                              backgroundColor: AppColors.secondary_95,
                                              radius: 12,
                                              child: IconButton(
                                                iconSize: 15,
                                                padding: EdgeInsets.zero,
                                                icon: const Icon(MdiIcons.pencil),
                                                color: AppColors.secondary_30,
                                                onPressed: () {
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        NZSwitch(
                                          isOn: schedule.complete,
                                          label: "Complete",
                                          onChanged: (bool value) {
                                            schedule.complete = value;
                                            controller.save(jobModel);
                                          },
                                        )
                                      ],
                                    )
                                  ],
                                )
                            )
                        )
                      ]
                  )
              ) : const SizedBox(),
              const SizedBox(height: 8,),
              _showScheduleDialog.value ?
              AddScheduleDialog(
                jobModel: jobModel,
                schedule: schedule,
                onClose: () {
                  _showScheduleDialog.value = false;
                  controller.update();
                },
              ) : const SizedBox(),
              const SizedBox(height: 8,),
            ],
          );
        });
  }

  void _showEditNoteDialog(JobModel jobModel, ScheduleModel schedule) async {
    await Future.delayed(const Duration(milliseconds: 150));
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AppDialog(
          title: 'Update Note',
          body: AppTextField(
            label: 'Note',
            mb: 24,
            multiline: true,
            controller: _noteController,
          ),
          okayLabel: 'Update',
          onTapOkay: () {
            schedule.note = _noteController.text;
            controller.save(jobModel);
          },
        );
      },
    );
  }
}
