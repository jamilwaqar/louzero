import 'package:flutter/material.dart';
import 'package:louzero/common/app_avatar.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/controller/api/api_manager.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/widget/switch_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ScheduleCard extends StatelessWidget{
  ScheduleCard({
    Key? key,
    required this.schedule
  }) : super(key: key);

  final ScheduleModel schedule;

  late final isComplete = schedule.complete.obs;
  final showScheduleDialog = false.obs;

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateTime.fromMillisecondsSinceEpoch(schedule.startTime);
    final monthName = DateFormat.MMM().format(parseDate);
    final day = DateFormat.d().format(parseDate);

    return Column(
      children: [
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
                                    flex: 5,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(schedule.time,
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
                                  Expanded(
                                    flex: 1,
                                    child: Align(
                                        alignment: Alignment.topRight,
                                        child: AppPopMenu(
                                          buttonAlignment: MainAxisAlignment.end,
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
                                                showScheduleDialog.value = true;
                                              },
                                            ),
                                            PopMenuItem(
                                              label: 'Manage Notes',
                                              icon: MdiIcons.fileDocumentOutline,
                                              onTap: () {
                                              },
                                            ),
                                            PopMenuItem(
                                              label: 'Remove',
                                              icon: MdiIcons.trashCanOutline,
                                              onTap: () {
                                              },
                                            ),
                                          ],
                                        )
                                    ),
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
                                  FutureBuilder<UserModel?>(
                                      future: APIManager.fetchUser(schedule.personId),
                                    builder: (_, AsyncSnapshot<UserModel?> snapshot) {
                                        if (!snapshot.hasData) return Container();
                                        UserModel user = snapshot.data!;
                                      return Row(
                                        children: [
                                          AppAvatar(size: 20, url: user.avatar, placeHolder: AppPlaceHolder.user),
                                          const SizedBox(width: 8,),
                                          Text(user.fullName, style: const TextStyle(
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
                                      );
                                    }
                                  ),
                                  Obx(()=> NZSwitch(
                                    isOn: isComplete.value,
                                    label: "Complete",
                                    onChanged: (bool value) {
                                      isComplete.value = value;
                                    },
                                  ))
                                ],
                              )
                            ],
                          )
                      )
                  )
                ]
            )
        ),
        const SizedBox(height: 8,),
        showScheduleDialog.value ?
        AddScheduleDialog(
          schedule: schedule,
          onClose: () {
            showScheduleDialog.value = false;
          },
        ) : const SizedBox(),
        const SizedBox(height: 8,),
      ],
    );
  }
}
