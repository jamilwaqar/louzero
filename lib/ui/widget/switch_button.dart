import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:flutter_switch/flutter_switch.dart';

class NZSwitch extends StatelessWidget {
  final bool isOn;
  final String label;
  final ValueChanged<bool> onChanged;

  const NZSwitch(
      {Key? key,
      required this.isOn,
      required this.label,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlutterSwitch(
          width: 48,
          height: 24,
          inactiveColor: AppColors.secondary_90,
          activeColor: AppColors.primary_80,
          activeToggleColor: AppColors.orange,
          inactiveToggleColor: AppColors.white,
          toggleSize: 22.0,
          value: isOn,
          // borderRadius: 30.0,
          padding: 2.0,
          onToggle: onChanged,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppStyles.labelRegular
              .copyWith(fontSize: 16, fontWeight: FontWeight.w400, height: 1.3),
        )
      ],
    );
  }
}
