import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppSimpleDropDown extends StatefulWidget {
  const AppSimpleDropDown(
      {required this.label,
      required this.onSelected,
      required this.items,
      this.backgroundColor,
      this.textColor,
      this.iconColor,
      this.borderColor,
      this.icon,
      this.height,
      this.hasClearIcon,
      this.dividerPosition,
      Key? key})
      : super(key: key);
  final List items;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final Color? borderColor;
  final Icon? icon;
  final double? height;
  final Function onSelected;
  final bool? hasClearIcon;
  final List? dividerPosition; //accept array of index eg. [1, 2]

  @override
  _AppSimpleDropDownState createState() => _AppSimpleDropDownState();
}

class _AppSimpleDropDownState extends State<AppSimpleDropDown> {
  String selectedItem = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedItem = value.toString();
              });
              widget.onSelected(value);
            },
            offset: const Offset(0, 40),
            child: Row(
              children: [
                Container(
                  height: widget.height ?? 35,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      color: widget.backgroundColor ?? Colors.transparent,
                      border: Border.all(
                          color: widget.borderColor ?? AppColors.secondary_90,
                          width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(selectedItem.isNotEmpty
                          ? selectedItem
                          : widget.label),
                      const SizedBox(
                        width: 8,
                      ),
                      selectedItem.isNotEmpty
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedItem = "";
                                });
                                widget.onSelected("");
                              },
                              child: const Icon(
                                MdiIcons.closeCircle,
                                size: 18,
                                color: Colors.grey,
                              ),
                            )
                          : const SizedBox(),
                      const Icon(
                        MdiIcons.menuDown,
                        size: 20,
                      )
                    ],
                  ),
                )
              ],
            ),
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: AppColors.medium_2, width: 0)),
            itemBuilder: (BuildContext context) => widget.items.map((item) {
                  var index = widget.items.indexOf(item);
                  return popItem(item,
                      hasDivider: widget.dividerPosition != null
                          ? widget.dividerPosition?.contains(index)
                          : false);
                }).toList())
      ],
    );
  }

  PopupMenuItem popItem(String label, {bool? hasDivider}) {
    final bool showDivider = hasDivider != null && hasDivider ? true : false;
    return PopupMenuItem(
        value: label,
        padding: const EdgeInsets.all(0),
        child: Container(
          // width: 200,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: showDivider
                        ? (widget.borderColor ?? AppColors.secondary_90)
                        : Colors.transparent,
                    width: 1)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(label),
                  const SizedBox(
                    width: 32,
                  ),
                  Icon(
                    MdiIcons.check,
                    size: 20,
                    color: (selectedItem == label)
                        ? AppColors.success
                        : Colors.transparent,
                  )
                ],
              )
            ],
          ),
        ));
  }
}
