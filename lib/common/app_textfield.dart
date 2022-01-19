import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String initialValue;
  final double height;
  final bool autofocus;
  final int minLines;
  final int maxLines;
  final bool multiline;
  final double mb;
  final bool enabled;
  final void Function(String)? onChanged;

  const AppTextField({
    this.controller,
    this.label,
    this.enabled = true,
    this.initialValue = '',
    this.height = 48,
    this.autofocus = false,
    this.multiline = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.mb = 16,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
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

  Widget _input() {
    return TextFormField(
      enabled: widget.enabled,
      initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      style: AppStyles.labelBold
          .copyWith(height: 1.5, fontSize: 16, color: AppColors.secondary_20),
      minLines: 1,
      onChanged: widget.onChanged,
      maxLines: widget.multiline ? null : widget.maxLines,
      decoration: AppStyles.inputDefault.copyWith(
        labelText: widget.label,
        fillColor: _color,
        isDense: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.mb),
      child: _input(),
    );
  }
}
