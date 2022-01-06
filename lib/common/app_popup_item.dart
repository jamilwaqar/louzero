import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppPopupMenuItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final int index;

  const AppPopupMenuItem(
      {required this.index,
      required this.iconData,
      required this.label,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem(
      child: SizedBox(
        width: 200,
        height: 50,
        child: Row(
          children: [
            Icon(
              iconData,
              color: AppColors.icon,
            ),
            const SizedBox(width: 10),
            Text(label,
                style: const TextStyle(
                  color: AppColors.icon,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                )),
          ],
        ),
      ),
      value: index,
    );
  }
}
