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
      this.textCapitalization,
      this.onChanged,
      this.password = false,
      this.autofocus = false,
<<<<<<< HEAD
      this.required = false,
      this.colorTx = AppColors.dark_3,
      this.colorBd = AppColors.light_3,
      this.colorBg = AppColors.lightest,
=======
      this.height = 48,
>>>>>>> dev
      this.mt = 0,
      this.mb = 16})
      : super(key: key);

  final String label;
  final Color colorBg;
  final Color colorBd;
  final Color colorTx;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final bool password;
  final bool required;
  final double mt;
  final double mb;
  final bool autofocus;
  final double height;
  final void Function(String)? onChanged;

  @override
  _AppInputTextState createState() => _AppInputTextState();
}

class _AppInputTextState extends State<AppInputText> {
  @override
  Widget build(BuildContext context) {
    var reqText = widget.required ? '*' : '';
    var inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: widget.colorTx,
    );
    var inputContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: widget.colorBg,
      border: Border.all(
        color: widget.colorBd,
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
          widget.label + reqText,
          style: const TextStyle(
            color: AppColors.dark_2,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: widget.height,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: inputContainer,
          child: TextFormField(
            autofocus: widget.autofocus,
            controller: widget.controller,
            keyboardAppearance: Brightness.light,
            keyboardType: widget.keyboardType,
            textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
            obscureText: widget.password,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: widget.onChanged,
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
