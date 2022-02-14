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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 57,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(0),
          //    border: Border.all(color: AppColors.light_3, width: 1),
          // ),
          child: FormField<String>(
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  labelText: label,
                  labelStyle: AppStyles.labelBold.copyWith(
                      height: 1,
                      fontSize: 16,
                      color: AppColors.secondary_40,
                      fontWeight: FontWeight.w700),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.secondary_90),
                  ),
                  errorStyle:
                      const TextStyle(color: Colors.redAccent, fontSize: 16.0),
                  hintText: hint,
                ),
                isEmpty: initValue == null || initValue == '',
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: initValue,
                    isDense: false,
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
