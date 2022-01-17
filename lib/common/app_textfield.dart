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
  final bool required;
  final bool enabled;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final List<String>? options;
  final double mb;
  const AppTextField({
    this.controller,
    this.label,
    this.initialValue = '',
    this.height = 48,
    this.required = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.options,
    this.autofocus = false,
    this.multiline = false,
    this.enabled = true,
    this.minLines = 1,
    this.maxLines = 1,
    this.mb = 16,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _textFieldFocus = FocusNode();
  Color _color = AppColors.secondary_99;
  Color _borderColor = Colors.transparent;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = _hasError() ? AppColors.errorTint : Colors.transparent;
        });
      } else {
        setState(() {
          _color = _hasValue() ? Colors.transparent : AppColors.secondary_99;
          _borderColor =
              _hasValue() ? AppColors.secondary_70 : Colors.transparent;

          if (_hasError()) {
            _color = AppColors.errorTint;
          }
        });
      }
    });
    super.initState();
  }

  bool _hasError() {
    // if (widget.validator != null && widget.controller != null) {
    //   if (widget.controller!.text.isNotEmpty) {
    //     String? error = widget.validator!.call(widget.controller!.text);
    //     return error != null && error.isNotEmpty;
    //   }
    // }
    return false;
  }

  bool _hasValue() {
    if (widget.controller != null) {
      return widget.controller!.text.isNotEmpty;
    }
    return false;
  }

  Widget _input() {
    return TextFormField(
      initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      style: AppStyles.labelBold.copyWith(
          height: 1.5,
          fontSize: 16,
          color: AppColors.secondary_20,
          fontWeight: FontWeight.w700),
      minLines: 1,
      maxLines: widget.multiline ? null : widget.maxLines,
      decoration: AppStyles.inputDefault.copyWith(
          suffixIcon:
              _hasValue() ? Icon(Icons.check, color: Colors.green) : null,
          labelText: widget.label,
          labelStyle: AppStyles.labelBold.copyWith(
              height: 1.5,
              fontSize: 16,
              color: AppColors.secondary_40,
              fontWeight: FontWeight.w700),
          fillColor: _color,
          isDense: true,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: _borderColor),
          )),
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
