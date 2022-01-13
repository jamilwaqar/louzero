import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppContactInfoLine extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hint;
  final String text;
  final Color colorLabel;
  final Color colorText;
  final Color colorIcon;
  const AppContactInfoLine({
    required this.label,
    required this.text,
    required this.hint,
    this.icon = Icons.chevron_right,
    this.colorIcon = AppColors.secondary_70,
    this.colorLabel = AppColors.secondary_30,
    this.colorText = AppColors.secondary_20,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              alignment: const Alignment(-1, -1),
              child: Icon(icon, size: 18, color: colorIcon),
            ),
            Text(label,
                style: AppStyles.headerRegular
                    .copyWith(fontSize: 16, color: colorLabel)),
          ],
        ),
        const SizedBox(height: 8),
        if (text.isNotEmpty)
          Row(
            children: [
              const SizedBox(width: 24),
              Text(text,
                  style: AppStyles.labelRegular.copyWith(color: colorText)),
            ],
          ),
        if (text.isEmpty)
          Row(
            children: [
              const SizedBox(width: 24),
              Text(hint,
                  style: AppStyles.labelRegular
                      .copyWith(color: AppColors.secondary_60)
                      .copyWith(fontSize: 14)),
            ],
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}
