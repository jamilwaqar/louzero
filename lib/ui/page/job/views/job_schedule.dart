import 'package:flutter/material.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_card_tabs.dart';
import 'package:louzero/common/app_placeholder.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/page/job/views/widget/schedule_card.dart';

class JobSchedule extends StatefulWidget{
  const JobSchedule({Key? key}) : super(key: key);

  @override
  _JobScheduleState createState() => _JobScheduleState();
}

class _JobScheduleState extends State<JobSchedule> {
  late List schedules = [
    {
      "id": 1,
      "personnel": {
        "name": "Personnel Name",
        "image": "https://semantic-ui.com/images/avatar/large/elliot.jpg",
      },
      "hoursToComplete": 2,
      "note": "These are a few additional details about what needs to be done today. ",
      "date": "2022-01-04 00:00:00.000Z",
      "startTime": "1:33 PM",
      "endTime": "2:33 PM",
      "isAnytime": false,
      "isCompleted": false
    }
  ];
  late bool isAddScheduleOpen = false;

  @override
  Widget build(BuildContext context) {
    return AppTabPanel(
      children: [
        const Text('Schedule', style: AppStyles.headerRegular),
        if (schedules.isEmpty && !isAddScheduleOpen)
          const AppPlaceholder(
            title: 'No Appointments Yet',
            subtitle: "You haven't schedules any appointments for this job yet.",
          ),
        const SizedBox(height: 10,),
        Column(
          children: schedules.map((schedule) =>
              ScheduleCard(schedule: schedule)).toList(),
        ),
        Visibility(
            visible: isAddScheduleOpen,
            child: AddScheduleDialog(
              onClose: () {
                setState(() {
                  isAddScheduleOpen = false;
                });
              },
            )
        ),
        Visibility(
            visible: !isAddScheduleOpen,
            child: Align(
              alignment: Alignment.centerLeft,
              child: AppAddButton(
                "Add to Schedule",
                iconColor: AppColors.primary_1,
                onPressed: () {
                  setState(() {
                    isAddScheduleOpen = true;
                  });
                },
              ),
            )
        ),
        const SizedBox(height: 32,),
      ],
    );
  }
}