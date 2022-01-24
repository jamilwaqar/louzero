import 'package:flutter/material.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/controller/constant/colors.dart';

class PopMenuItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  final bool? hasDivider;
  final bool? showIcon;
  const PopMenuItem({
    required this.label,
    this.icon,
    this.hasDivider,
    this.showIcon,
    this.onTap,
  });
}

class AppPopMenu extends StatelessWidget {
  final List<PopMenuItem> items;
  final List<Widget> button;
  final Color colorIcon;
  final Offset? offset;
  final Function(dynamic)? onSelected;
  AppPopMenu({
    Key? key,
    this.items = const [],
    this.button = const [],
    this.offset,
    this.colorIcon = AppColors.primary_60,
    this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: onSelected,
        offset: offset ?? const Offset(0, 0),
        child: Row(children: [
          if (button.isEmpty) const Icon(Icons.more_vert),
          if (button.isNotEmpty) ...button
        ]),
        elevation: 2,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: AppColors.medium_2, width: 0)),
        itemBuilder: (BuildContext context) => items.map((item) {
              return popItem(item.label,
                  onTap: item.onTap, icon: item.icon ?? Icons.chevron_right);
            }).toList());
  }

  PopupMenuItem popItem(String label,
      {IconData icon = Icons.chevron_right, VoidCallback? onTap, bool? hasDivider, bool? showIcon}) {
    print('hasDivider $hasDivider');
    return PopupMenuItem(
        value: label,
        onTap: onTap,
        child: Row(
          children: [
            hasDivider != null && hasDivider ? const Divider(thickness: 2, color: Colors.red,) : const SizedBox(),
            showIcon != null && showIcon ? Icon(icon, color: colorIcon) : const SizedBox(),
            const SizedBox(width: 8),
            Text(label)
          ],
        ));
  }
}
