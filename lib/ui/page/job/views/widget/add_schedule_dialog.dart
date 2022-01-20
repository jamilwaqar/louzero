import 'package:flutter/material.dart';
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
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/widget/buttons/text_button.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/widget/time_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddScheduleDialog extends StatefulWidget{
  const AddScheduleDialog({
    Key? key,
    required this.onClose,
    this.schedule,
  }) : super(key: key);
  final Function onClose;
  final ScheduleModel? schedule;

  @override
  _AddScheduleDialogState createState() => _AddScheduleDialogState();
}

class _AddScheduleDialogState extends State<AddScheduleDialog> {

  late final TextEditingController _personnelController = TextEditingController(text: widget.schedule?.personnelName);
  late final TextEditingController _noteController = TextEditingController(text: widget.schedule?.note);
  late final TextEditingController _startTimeController = TextEditingController(text: widget.schedule?.start.time);
  late final TextEditingController _endTimeController = TextEditingController(text: widget.schedule?.end.time);

  String personnel = "";
  String hoursToComplete = "";
  String note = "";
  String date = "";
  String startTime = "";
  String endTime = "";
  bool isAnyTimeOfVisit = false;


  @override
  Widget build(BuildContext context) {
    final leadingImage = (widget.schedule != null && widget.schedule!.personnelAvatar != null)
        ? widget.schedule!.personnelAvatar
        : "https://semantic-ui.com/images/avatar/large/elliot.jpg";
    return AppCard(
      ml: 0,
      mr: 0,
      radius: 24,
      children: [
        RowSplit(
            left: const Text("Add New Schedule", style: AppStyles.headerRegular),
            right: AppIconButton(
              colorBg: Colors.transparent,
              onTap: () {
                widget.onClose();
              },
            )),
        const SizedBox(height: 24,),
        AppAdvancedTextField(
          controller: _personnelController,
          label: 'Personnel',
          isDropdown: true,
          items: const ["User 1", "User 2", "User 3"],
          leadingImage: _personnelController.text.isNotEmpty ? leadingImage.toString() : null,
          leftPadding: _personnelController.text.isNotEmpty ? 50 : 15,
          showClearIcon: _personnelController.text.isNotEmpty,
          onChange: (value) {
            setState(() {
              personnel = value;
              _personnelController.text = value;
            });
          },
          onClear: () {
            setState(() {
              personnel = "";
              _personnelController.text = "";
            });
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
          selectedDate: widget.schedule?.start,
          onDateSelected: (value){ print('date has been changed $value');},
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
                      setState(() {
                        startTime = time;
                        _startTimeController.text = time;
                      });
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
                      setState(() {
                        endTime = time;
                        _endTimeController.text = time;
                      });
                    },);
                  },
                );
              },
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: AppCheckbox(
                checked: isAnyTimeOfVisit,
                label: "Any time on day of visit",
                onChanged: (value) {
                  setState(() {
                    isAnyTimeOfVisit = value!;
                  });
                },
              ),
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
              onPressed: () {},
            ),
            const SizedBox(width: 32,),
            LZTextButton(
              "Cancel",
              textColor: AppColors.secondary_20,
              fontWeight: FontWeight.w500,
              onPressed: () {
                widget.onClose();
              },
            )
          ],
        )
      ],
    );
  }

}