import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class PopMenuItem {
  final String label;
  final IconData? icon;
  final VoidCallback? onTap;
  const PopMenuItem({
    required this.label,
    this.icon,
    this.onTap,
  });
}

class AppPopMenu extends StatelessWidget {
  final List<PopMenuItem> items;
  final List<Widget> button;
  final Color colorIcon;
  final MainAxisAlignment? buttonAlignment;
  const AppPopMenu(
      {Key? key,
        this.items = const [],
        this.button = const [],
        this.buttonAlignment,
        this.colorIcon = AppColors.primary_60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        child: Row(
            mainAxisAlignment: buttonAlignment ?? MainAxisAlignment.center,
            children: [
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
      {IconData icon = Icons.chevron_right, VoidCallback? onTap}) {
    return PopupMenuItem(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: colorIcon),
            const SizedBox(width: 8),
            Text(label)
          ],
        ));
  }
}
