import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
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
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            // title: Text('Select Stuff'),
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text('Content'),
                  Text('More Content'),
                  Text('Even More Content'),
                ],
              ),
            ),
            actions: [
              AppButton(
                label: "Done",
                primary: false,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  final List<SelectItem> items = const [
    SelectItem(id: '1', label: 'Residential', value: 'res', selected: false),
    SelectItem(id: '1', label: 'Comercial', value: 'com', selected: true),
    SelectItem(id: '1', label: 'Industrial', value: 'ind', selected: true),
    SelectItem(id: '1', label: 'Public', value: 'pub', selected: false),
    SelectItem(id: '1', label: 'Government', value: 'gov', selected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _selectButton(),
        Expanded(
          child: ListView(
            children: items.map((item) {
              return SelectListTile(
                isSelected: item.selected,
                item: item,
                onSelectItem: onSelectItem,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _selectButton() => MaterialButton(
      child: ListTile(
          title: Text('Open Dialog'),
          trailing: Icon(Icons.arrow_drop_down),
          tileColor: AppColors.light_2,
          shape: RoundedRectangleBorder(
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
    const _style = TextStyle(
      color: AppColors.darkest,
    );
    return ListTile(
      leading: Icon(isSelected ? iconSelected : iconUnselected),
      title: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(item.label, style: _style),
      ),
      onTap: () => onSelectItem(item),
    );
  }
}
