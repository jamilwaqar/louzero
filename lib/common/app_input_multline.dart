import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppInputMultiLine extends StatefulWidget {
  final TextEditingController? controller;
  final double height;
  final bool autofocus;
  const AppInputMultiLine({
    this.controller,
    this.height = 139,
    this.autofocus = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AppInputMultiLine> createState() => _AppInputMultiLineState();
}

class _AppInputMultiLineState extends State<AppInputMultiLine> {
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
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      style: AppStyles.labelBold
          .copyWith(height: 1.7, fontSize: 16, color: AppColors.secondary_20),
      minLines: 1,
      maxLines: null,
      decoration: InputDecoration(
        labelStyle:
            const TextStyle(fontFamily: 'Lato', color: AppColors.secondary_40),
        fillColor: _color,
        filled: true,
        labelText: 'Add Note',
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
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
