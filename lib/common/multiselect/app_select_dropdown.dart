import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/controller/constant/colors.dart';

class SelectItem {
  final String label;
  final String id;
  final String value;
  final bool selected;
  const SelectItem(
      {required this.label,
      required this.id,
      required this.value,
      required this.selected});
}

class AppSelectDropdown extends StatefulWidget {
  const AppSelectDropdown({Key? key}) : super(key: key);

  @override
  State<AppSelectDropdown> createState() => _AppSelectDropdownState();
}

class _AppSelectDropdownState extends State<AppSelectDropdown> {
  Future<void> OpenDialog() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('Select Stuff'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            contentPadding: EdgeInsets.only(left: 0, right: 0, top: 32),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 350,
                child: Column(
                  children: items.map((item) {
                    return SelectListTile(
                      isSelected: item.selected,
                      item: item,
                      onSelectItem: onSelectItem,
                    );
                  }).toList(),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16, top: 16),
                child: AppButton(
                  label: "Done",
                  primary: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16, right: 16, top: 16),
                child: AppButton(
                  label: "Cancel",
                  primary: false,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        });
  }

  final List<SelectItem> items = const [
    SelectItem(id: '23', label: 'Residential', value: 'res', selected: false),
    SelectItem(id: '24', label: 'Comercial', value: 'com', selected: true),
    SelectItem(id: '25', label: 'Industrial', value: 'ind', selected: true),
    SelectItem(id: '26', label: 'Public', value: 'pub', selected: false),
    SelectItem(id: '27', label: 'Government', value: 'gov', selected: false),
    SelectItem(id: '28', label: 'Entertainment', value: 'res', selected: false),
    SelectItem(id: '29', label: 'Non Profit', value: 'com', selected: true),
    SelectItem(id: '31', label: 'Rural', value: 'pub', selected: false),
    SelectItem(id: '32', label: 'Scientific', value: 'gov', selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_selectButton()],
    );
  }

  Widget _selectButton() => MaterialButton(
      padding: EdgeInsets.all(0),
      child: ListTile(
          title: Text('Open Dialog'),
          trailing: Icon(Icons.arrow_drop_down),
          horizontalTitleGap: 0,
          tileColor: AppColors.lightest,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColors.light_3),
            borderRadius: BorderRadius.circular(8.0),
          ),
          onTap: () {
            OpenDialog();
          }),
      onPressed: () {});

  void onSelectItem(SelectItem item) {
    print('Selected:');
    inspect(item);
  }
}

class SelectListTile extends StatelessWidget {
  final SelectItem item;
  final bool isSelected;
  final ValueChanged<SelectItem> onSelectItem;
  final IconData? iconSelected;
  final IconData? iconUnselected;

  const SelectListTile({
    Key? key,
    required this.item,
    required this.isSelected,
    required this.onSelectItem,
    this.iconSelected = Icons.check_circle,
    this.iconUnselected = Icons.add_circle_outline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _style = TextStyle(color: AppColors.darkest, fontSize: 18);
    return Column(
      children: [
        ListTile(
          contentPadding:
              EdgeInsets.only(left: 32, right: 32, top: 0, bottom: 0),
          leading: Icon(
            isSelected ? iconSelected : iconUnselected,
            color: AppColors.dark_1,
          ),
          title: Transform.translate(
            offset: const Offset(-16, 0),
            child: Text(item.label, style: _style),
          ),
          onTap: () => onSelectItem(item),
        ),
        AppDivider(mb: 0, mt: 0, color: AppColors.light_1)
      ],
    );
  }
}
