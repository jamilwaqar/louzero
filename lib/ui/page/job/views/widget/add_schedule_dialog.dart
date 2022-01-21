import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_advanced_textfield.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_checkbox.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/app_labeled_line.dart';
import 'package:louzero/common/utility/flex_row.dart';
import 'package:louzero/common/utility/row_split.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/models/user_models.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/widget/time_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:uuid/uuid.dart';

class AddScheduleDialog extends GetWidget<JobController> {

  AddScheduleDialog({
    Key? key,
    required this.jobModel,
    required this.onClose,
    this.schedule,
  }) : super(key: key);

  final JobModel jobModel;
  final Function() onClose;
  final ScheduleModel? schedule;

  late final TextEditingController _personnelController = TextEditingController(text: schedule?.personnelName);
  late final TextEditingController _noteController = TextEditingController(text: schedule?.note);
  late final TextEditingController _startTimeController = TextEditingController(text: schedule?.start.time);
  late final TextEditingController _endTimeController = TextEditingController(text: schedule?.end.time);
  late final List<UserModel>companyUsers = controller.baseController.activeCountryUsers;

  final _isAnyTimeOfVisit = false.obs;
  final _selectedDate = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    final leadingImage = schedule?.personnelAvatar;

    return AppCard(
      ml: 0,
      mr: 0,
      radius: 24,
      children: [
        RowSplit(
            left: Text(schedule != null ? 'Edit Schedule' : 'Add New Schedule', style: AppStyles.headerRegular),
            right: AppIconButton(
              colorBg: Colors.transparent,
              onTap: onClose,
            )),
        const SizedBox(height: 24,),
        AppAdvancedTextField(
          controller: _personnelController,
          label: 'Personnel',
          isDropdown: true,
          items: companyUsers.map((e) => e.fullName).toList(),
          leadingImage: leadingImage?.toString(),
          leftPadding: _personnelController.text.isNotEmpty ? 50 : 15,
          showClearIcon: _personnelController.text.isNotEmpty,
          onChange: (value) {
            _personnelController.text = value;
          },
          onClear: () {
            _personnelController.text = "";
          },
        ),
        const SizedBox(height: 10,),
        AppAdvancedTextField(
          controller: _noteController,
          label: 'Note',
        ),
        const SizedBox(height: 32,),
        Align(
          alignment: Alignment.center,
          child: AppAddButton(
            "Find a Time",
            iconData: MdiIcons.calendar,
            iconColor: AppColors.primary_1,
            onPressed: () {  print('d');},
          ),
        ),
        const SizedBox(height: 32,),
        const AppLabeledLine(label: "OR"),
        const SizedBox(height: 16,),
        NZCalendar(
          selectedDate: schedule?.start,
          onDateSelected: (value){ _selectedDate.value = value;},
        ),
        const SizedBox(height: 24,),
        FlexRow(
          flex: const [2, 2, 3],
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAdvancedTextField(
              controller: _startTimeController,
              label: 'Start Time',
              rightIcon: MdiIcons.clock,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NZTimePicker(onChange: (time) {
                      _startTimeController.text = time;
                    });
                  },
                );
              },
            ),
            AppAdvancedTextField(
              controller: _endTimeController,
              label: 'End Time',
              rightIcon: MdiIcons.clock,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NZTimePicker(onChange: (time) {
                      _endTimeController.text = time;
                    },);
                  },
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Obx(()=> AppCheckbox(
                checked: _isAnyTimeOfVisit.value,
                label: "Any time on day of visit",
                onChanged: (value) {
                  _isAnyTimeOfVisit.value = value!;
                },
              )),
            )
          ],
        ),
        const SizedBox(height: 24,),
        const Divider(thickness: 2, color: AppColors.secondary_95,),
        const SizedBox(height: 24,),
        Row(
          children: [
            AppButton(
              label: "Save Appointment",
              onPressed: () {
                int start = _convertMilliseconds(_startTimeController.text);
                int end = _convertMilliseconds(_endTimeController.text);
                UserModel selectedUser = companyUsers.firstWhere((user) => user.fullName == _personnelController.text);
                ScheduleModel newSchedule = ScheduleModel(
                  objectId: schedule?.objectId ?? const Uuid().v4(),
                    startTime: start,
                    endTime: end,
                    personnelName: selectedUser.fullName,
                    personnelId: selectedUser.objectId!,
                    personnelAvatar: selectedUser.avatar);
                if (schedule != null) {
                  jobModel.scheduleModels.removeWhere((e) => e.objectId == schedule!.objectId);
                }
                jobModel.scheduleModels.add(newSchedule);
                controller.save(jobModel);
              },
            ),
            const SizedBox(width: 32,),
            LZTextButton(
              "Cancel",
              textColor: AppColors.secondary_20,
              fontWeight: FontWeight.w500,
              onPressed: onClose,
            )
          ],
        )
      ],
    );
  }

  int _convertMilliseconds(String date) {
    String filter = date.toLowerCase().replaceAll('am', '').replaceAll('pm', '');
    List<String>ar = filter.split(':');
    bool pm = date.toLowerCase().contains('pm');
    int hr =  int.parse(ar[0]);
    if (pm) hr += 12;
    int min = int.parse(ar[1]);
    DateTime dateTime = _selectedDate.value;
    DateTime start = DateTime(dateTime.year, dateTime.month, dateTime.day, hr, min);
    return start.millisecondsSinceEpoch;
  }
}