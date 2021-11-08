import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class SideMenuCell extends StatelessWidget {
  const SideMenuCell({Key? key, required this.title, this.icon, this.count, this.onPressed}) : super(key: key);

  final String title;
  final Widget? icon;
  final int? count;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 48,
        padding: const EdgeInsets.only(left: 4, right: 24),
        child: Row(
          children: [
            Container(
              width: 64,
              alignment: Alignment.center,
              child: icon,
            ),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: AppColors.dark_1,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ),
            if (count != null)
              Container(
                width: 40,
                height: 24,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.medium_3,
                ),
                child: Text(
                  "${count ?? 0}",
                  style: const TextStyle(
                    color: AppColors.lightest,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
