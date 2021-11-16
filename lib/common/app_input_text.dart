import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppInputText extends StatefulWidget {
  const AppInputText(
      {Key? key,
      required this.controller,
      required this.label,
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
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    const inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.dark_3,
    );
    var inputContainer = BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.light_3,
          width: 1,
        ));

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
          child: TextFormField(
            autofocus: widget.autofocus,
            controller: widget.controller,
            keyboardAppearance: Brightness.light,
            keyboardType: widget.keyboardType,
            obscureText: widget.password,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: inputText,
          ),
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }
}
