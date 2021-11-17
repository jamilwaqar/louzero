import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppDropDown extends StatelessWidget {
  const AppDropDown(
      {Key? key,
      this.initValue,
      required this.itemList,
      required this.onChanged,
      this.hint,
      this.label})
      : super(key: key);

  final String? initValue;
  final List<String> itemList;
  final String? hint;
  final String? label;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(label!, style: TextStyles.bodyL),
        if (label != null)
          const SizedBox(
            height: 4,
          ),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.light_3, width: 1)),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: AppColors.dark_3,
                  ),
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: hint,
                ),
                isEmpty: initValue == null || initValue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: initValue,
                    isDense: true,
                    onChanged: onChanged,
                    items: itemList.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
