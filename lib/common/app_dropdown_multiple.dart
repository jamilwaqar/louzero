import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppDropdownMultiple extends StatefulWidget {
  const AppDropdownMultiple(
      {Key? key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.password = false,
      this.autofocus = false,
      this.mt = 0,
      this.mb = 24})
      : super(key: key);
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool password;
  final double mt;
  final double mb;
  final bool autofocus;
  @override
  State<AppDropdownMultiple> createState() => _AppDropdownMultipleState();
}

class _AppDropdownMultipleState extends State<AppDropdownMultiple> {
  @override
  Widget build(BuildContext context) {
    var inputContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: AppColors.light_3,
        width: 1,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.mt,
        ),
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.dark_1,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 48,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: inputContainer,
          child: DropdownSearch<String>.multiSelection(
            dropdownSearchDecoration: const InputDecoration(),
            dropdownSearchBaseStyle: TextStyles.bodyS,
            mode: Mode.MENU,
            showSearchBox: true,
            showSelectedItems: false,
            items: const [
              "Pool Cleaning",
              "Carpet Cleaning",
              "Plumbing",
              'HVAC'
            ],
            onChanged: print,
            selectedItems: const ["Plumbing"],
          ),
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }
}
