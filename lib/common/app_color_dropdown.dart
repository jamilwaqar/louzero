import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:quiver/iterables.dart';

class AppColorDropdown extends StatefulWidget{
  const AppColorDropdown({
    required this.items,
    required this.onColorSelected,
    Key? key
  }) : super(key: key);
  final List<Color> items;
  final Function onColorSelected;

  @override
  _AppColorDropdownState createState() => _AppColorDropdownState();
}

class _AppColorDropdownState extends State<AppColorDropdown> {
  Color selectedItem = Colors.transparent;
  List<List<Color>> colorItems = [];

  @override
  void initState() {
    listToMatrix();
    super.initState();
  }

  listToMatrix() {
    var pairs = partition(widget.items, 5);
    print('pa $pairs');
    setState(() {
      colorItems = pairs.toList();
    });
  }

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
                color: selectedItem == Colors.transparent ? Colors.transparent : selectedItem,
                border: Border.all(
                    color: selectedItem == Colors.transparent  ? AppColors.secondary_90 : selectedItem,
                    width: 1),
                borderRadius: BorderRadius.circular(50)),
            child: selectedItem == Colors.transparent  ? const Icon(MdiIcons.chevronDown) : Row(
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
        return colorItems.map((colors) => colorMenuItems(colors)).toList();
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
            children: colors.map((color) {
              return _colorBox(color);
            }).toList(),
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
            color: color as Color
        ),
      ),
    );
  }

}