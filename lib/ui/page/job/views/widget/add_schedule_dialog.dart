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
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/company_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/controllers/schedule_controller.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/widget/dialog/warning_dialog.dart';
import 'package:louzero/ui/widget/time_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddScheduleDialog extends GetWidget<ScheduleController> {

  final Function() onClose;
  final ScheduleModel? schedule;

  AddScheduleDialog({
    Key? key,
    required this.onClose,
    this.schedule,
  }) : super(key: key);

  late final bool _isEdit = schedule != null;
  late final _user = Get.find<AuthController>().user;
  final jobController = Get.find<JobController>();
  late final _personnelController = TextEditingController(text: _isEdit ? schedule!.personnelName : _user.fullName);
  late final _noteController = TextEditingController(text: _isEdit ? schedule!.note : jobController.jobModel!.description);
  late final _startTimeController = TextEditingController(text: schedule?.start.time);
  late final _endTimeController = TextEditingController(text: schedule?.end.time);
  late final companyUsers = Get.find<BaseController>().activeCompanyUsers;

  late final _isAnyTimeOfVisit = (schedule?.anyTimeVisit ?? false).obs;
  late final _selectedDate = (schedule?.start ?? DateTime.now()).obs;

  @override
  Widget build(BuildContext context) {
    final bool hasPersonnelText = _personnelController.text.isNotEmpty;
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
          items: companyUsers.map((e) => e.userName).toList(),
          leadingImage: hasPersonnelText ? (_isEdit ? schedule?.personnelAvatar : _user.avatar) : null,
          leftPadding: hasPersonnelText ? 50 : 15,
          showClearIcon: hasPersonnelText,
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
            Obx(()=> Opacity(
              opacity: _isAnyTimeOfVisit.value ? 0.4 : 1,
              child: AppAdvancedTextField(
                controller: _startTimeController,
                label: 'Start Time',
                rightIcon: MdiIcons.clock,
                onTap: () {
                  if (_isAnyTimeOfVisit.value) return;
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
            )),
            Obx(()=> Opacity(
              opacity: _isAnyTimeOfVisit.value ? 0.4 : 1,
              child: AppAdvancedTextField(
                controller: _endTimeController,
                label: 'End Time',
                rightIcon: MdiIcons.clock,
                onTap: () {
                  if (_isAnyTimeOfVisit.value) return;
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
            )),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Obx(()=> AppCheckbox(
                checked: _isAnyTimeOfVisit.value,
                label: "Any time on day of visit",
                onChanged: (value) {
                  _isAnyTimeOfVisit.value = value!;
                  if (value) {
                    _startTimeController.text = '12:00 AM';
                    _endTimeController.text = '12:00 AM';
                  }
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
              onPressed: () async {
                if (_startTimeController.text.isEmpty && !_isAnyTimeOfVisit.value) {
                  WarningMessageDialog.showDialog(Get.context!, 'Invalid Start time');
                  return;
                }
                int start = controller.convertMilliseconds(_startTimeController.text, _selectedDate.value);
                int end = controller.convertMilliseconds(_endTimeController.text, _selectedDate.value);
                CompanyUserModel selectedUser = companyUsers.firstWhere((user) => user.userName == _personnelController.text);
                ScheduleModel newSchedule = ScheduleModel(
                  objectId: schedule?.objectId,
                    startTime: start,
                    endTime: end,
                    personnelName: selectedUser.userName,
                    personnelId: selectedUser.userId,
                    note: _noteController.text,
                    complete: schedule?.complete ?? false,
                    anyTimeVisit: _isAnyTimeOfVisit.value,
                    personnelAvatar: selectedUser.avatar, jobId: jobController.jobModel!.objectId!);
                await controller.save(newSchedule);
                onClose();
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
}