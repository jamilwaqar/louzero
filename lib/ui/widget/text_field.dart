import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class LZTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool enabled;
  const LZTextField({Key? key, required this.controller, required this.label, this.enabled = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.bodyL,
        ),
        const SizedBox(height: 4,),
        Container(
          height: 48,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.light_3, width: 1)
          ),
          child: TextFormField(
            enabled: enabled,
            controller: controller,
            keyboardAppearance: Brightness.light,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: AppColors.dark_3),
          ),
        ),
      ],
    );
  }
}
