import 'package:flutter/material.dart';
import 'package:louzero/common/app_header_icon.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/utils.dart';

abstract class Ui {
  static Widget text(String label,
      {Color color = AppColors.secondary_20, bool link = false}) {
    Color _color = link ? AppColors.primary_30 : color;
    return Text(
      label,
      style: AppStyles.labelRegular.copyWith(height: 1.65, color: _color),
    );
  }

  static Widget block({List<Widget> children = const []}) {
    return Row(
      children: [
        SizedBox(width: 32),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...children,
            const SizedBox(height: 24),
          ],
        ),
      ],
    );
  }

  static Widget headingSM(
    String label, {
    IconData icon = Icons.chevron_right,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 24,
          alignment: const Alignment(-1, 0),
          child: appIcon(icon, color: AppColors.secondary_70),
        ),
        Text(label,
            style: AppStyles.headerRegular
                .copyWith(fontSize: 16, color: AppColors.secondary_30)),
      ],
    );
  }

  static Widget headingLG(String label, IconData icon,
      {VoidCallback? ontap, double mb = 24, IconData? trailingIcon}) {
    return AppHeaderIcon(
      label.toUpperCase(),
      iconStart: icon,
      icon: trailingIcon,
      onTap: ontap,
      mb: mb,
      style: AppStyles.headerRegular
          .copyWith(color: AppColors.secondary_30, fontSize: 20),
    );
  }
}
