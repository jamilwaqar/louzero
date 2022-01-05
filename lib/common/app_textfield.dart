import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTexfield extends StatefulWidget {
  final String? label;
  final TextEditingController? controller;
  final double height;
  final bool autofocus;
  const AppTexfield({
    this.label,
    this.controller,
    this.height = 139,
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTexfield> createState() => _AppTexfieldState();
}

class _AppTexfieldState extends State<AppTexfield> {
  final _textFieldFocus = FocusNode();
  Color _color = AppColors.secondary_99;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.transparent;
        });
      } else {
        setState(() {
          _color = AppColors.secondary_99;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorHeight: 16,
      cursorColor: AppColors.secondary_70,
      cursorWidth: 2,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      style: AppStyles.labelBold
          .copyWith(height: 1.7, fontSize: 16, color: AppColors.secondary_20),
      minLines: 1,
      maxLines: null,
      decoration: InputDecoration(
        isDense: true,
        labelStyle:
            const TextStyle(fontFamily: 'Lato', color: AppColors.secondary_40),
        fillColor: _color,
        filled: true,
        labelText: widget.label,
        border: UnderlineInputBorder(),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
}
