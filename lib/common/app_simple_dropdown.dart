import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppSimpleDropDown extends StatefulWidget {
  const AppSimpleDropDown(
      {required this.label,
        required this.onSelected,
        this.onClear,
        required this.items,
        this.backgroundColor,
        this.textColor,
        this.iconColor,
        this.borderColor,
        this.icon,
        this.height,
        this.hasClearIcon,
        this.dividerPosition,
        this.onTap,
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
  final Function? onClear;
  final Function? onTap;
  final bool? hasClearIcon;
  final List? dividerPosition; //accept array of index eg. [1, 2]

  @override
  _AppSimpleDropDownState createState() => _AppSimpleDropDownState();
}

class _AppSimpleDropDownState extends State<AppSimpleDropDown> {
  String selectedItem = "";

  @override
  Widget build(BuildContext context) {
    _showMenu(_tapPosition) {
      final RenderBox overlay = Overlay.of(context)?.context.findRenderObject() as RenderBox;
      showMenu(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
              const BorderSide(color: AppColors.medium_2, width: 0)),
          context: context,
          position: RelativeRect.fromRect(
              _tapPosition & const Size(40, 40), // smaller rect, the touch area
              Offset.zero & overlay.size   // Bigger rect, the entire screen
          ),
          items: widget.items.map((item) {
            var index = widget.items.indexOf(item);
            return popItem(item,
                hasDivider: widget.dividerPosition != null
                    ? widget.dividerPosition?.contains(index)
                    : false);
          }).toList()
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (details) {
         if(widget.onTap != null) {
           widget.onTap!();
         }
         final top = details.globalPosition.dx - details.localPosition.dx;
         final left = details.globalPosition.dy - details.localPosition.dy + 40;
        _showMenu(Offset(top, left));
      },
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
    );
  }

  PopupMenuItem popItem(String label, {bool? hasDivider}) {
    final bool showDivider = hasDivider != null && hasDivider ? true : false;
    return PopupMenuItem(
        value: label,
        padding: const EdgeInsets.all(0),
        onTap: () {
          setState(() {
            selectedItem = label.toString();
          });
          widget.onSelected(label);
        },
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
