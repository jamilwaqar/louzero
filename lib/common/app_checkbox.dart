import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    Key? key,
    this.label,
    this.onChanged,
    this.checked = false,
    this.mt = 0,
    this.mb = 10,
    this.pl = 0,
    this.pr = 0,
  }) : super(key: key);

  final bool checked;
  final Function(bool?)? onChanged;
  final String? label;
  final double mt;
  final double mb;
  final double pl;
  final double pr;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: pl, right: pr),
      margin: EdgeInsets.only(top: mt, bottom: mb),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 16,
            child: Checkbox(
                checkColor: Colors.white,
                value: checked,
                activeColor: AppColors.primary_1,
                onChanged: (val) {
                  onChanged != null ? onChanged!(val) : (val) {};
                }),
          ),
          const SizedBox(
            width: 8,
          ),
          if (label != null)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  if (onChanged != null) {
                    onChanged!(!checked);
                  }
                },
                child: Text(label!,
                    style: AppStyles.labelBold
                        .copyWith(height: 1, color: AppColors.secondary_20)),
              ),
            ),
        ],
      ),
    );
  }
}
