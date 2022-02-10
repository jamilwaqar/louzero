import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppColorDropdown extends StatefulWidget{
  const AppColorDropdown({
    required this.items,
    required this.onColorSelected,
    Key? key
  }) : super(key: key);
  final List<List<int>> items;
  final Function onColorSelected;

  @override
  _AppColorDropdownState createState() => _AppColorDropdownState();
}

class _AppColorDropdownState extends State<AppColorDropdown> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) {},
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
          const BorderSide(color: AppColors.medium_2, width: 0)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: selectedItem == 0 ? Colors.transparent : Color(selectedItem),
                border: Border.all(
                    color: selectedItem == 0 ? AppColors.secondary_90 : Color(selectedItem),
                    width: 1),
                borderRadius: BorderRadius.circular(50)),
            child: selectedItem == 0 ? const Icon(MdiIcons.chevronDown) : Row(
              children: const [
                Icon(MdiIcons.check, color: Colors.white,),
                SizedBox(width:24,),
                Icon(MdiIcons.chevronDown, color: Colors.white,)
              ],
            ),
          )
        ],
      ),
      itemBuilder: (BuildContext context) {
        return widget.items.map((colors) => colorMenuItems(colors)).toList();
      },
    );
  }

  PopupMenuItem colorMenuItems(List colors) {
    return PopupMenuItem(
      height: 50,
      value: null,
      padding: const EdgeInsets.all(0),
      onTap: () {
      },
      child: Container(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: colors.map((color) => _colorBox(color)).toList(),
          )),
    );
  }

  Widget _colorBox(color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = color;
        });
        widget.onColorSelected(color);
        Navigator.of(context).pop();
      },
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(top: 4, left: 2, right: 2, bottom: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(color)
        ),
      ),
    );
  }

}