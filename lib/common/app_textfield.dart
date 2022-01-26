import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  final bool password;
  final bool enabled;
  final bool expands;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final void Function()? onTap;
  final List<String>? options;
  final double mb;
  final IconData? iconStart;
  final IconData? iconEnd;

  const AppTextField({
    this.controller,
    this.label,
    this.enabled = true,
    this.initialValue = '',
    this.height = 48,
    this.required = false,
    this.password = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.onTap,
    this.options,
    this.autofocus = false,
    this.multiline = false,
    this.expands = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.mb = 16,
    this.iconStart,
    this.iconEnd,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _textFieldFocus = FocusNode();
  Color _color = AppColors.secondary_99;
  Color _borderColor = Colors.transparent;
  Icon? _status;
  AutovalidateMode _validateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    _setIcons();

    if (_hasValue()) {
      _color = Colors.transparent;
      _borderColor = AppColors.secondary_90;
    }

    void _validate() {
      if (widget.validator != null) {
        if (!_hasError()) {
          _validateMode = AutovalidateMode.disabled;
          _status = Icon(Icons.check, color: AppColors.success);
        } else {
          _validateMode = AutovalidateMode.always;
          _color = AppColors.errorTint;
          _borderColor = AppColors.errorText;
          _status =
              Icon(MdiIcons.alertCircleOutline, color: AppColors.errorText);
        }
      }
    }

    _textFieldFocus.addListener(() {
      if (!_textFieldFocus.hasFocus) {
        setState(() {
          _color = _hasValue() ? Colors.transparent : AppColors.secondary_99;
          _borderColor =
              _hasValue() ? AppColors.secondary_90 : Colors.transparent;
          _validate();
        });
      } else {
        setState(() {
          _color = Colors.transparent;
        });
      }
    });
    super.initState();
  }

  void _setIcons() {
    if (widget.validator != null && widget.iconEnd == null && _hasValue()) {
      setState(() {
        _status = Icon(Icons.check, color: AppColors.success);
      });
    }

    if (widget.iconEnd != null) {
      setState(() {
        _status = Icon(widget.iconEnd);
      });
    }
  }

  bool _hasError() {
    if (widget.validator != null && widget.controller != null) {
      String? error = widget.validator!.call(widget.controller!.text);
      return error != null && error.isNotEmpty;
    }
    return false;
  }

  bool _hasValue() {
    if (widget.controller != null) {
      return widget.controller!.text.isNotEmpty;
    }
    return false;
  }

  dynamic getIcon() {
    if (widget.iconEnd != null) {
      return Icon(
        widget.iconEnd,
        color: Colors.black,
      );
    }

    if (_hasValue() && widget.iconEnd == null) {
      return _status;
    }
    return null;
  }

  Widget _input() {
    return TextFormField(
      onTap: widget.onTap,
      enableIMEPersonalizedLearning: false,
      enabled: widget.enabled,
      initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: _validateMode,
      onSaved: widget.onSaved,
      obscureText: widget.password,
      keyboardType:
          widget.multiline ? TextInputType.multiline : widget.keyboardType,
      onChanged: (val) {
        if (widget.onChanged != null) {
          widget.onChanged!(val);
        }
        if (widget.validator != null && !_hasError()) {
          setState(() {
            _status = Icon(Icons.check, color: AppColors.success);
          });
        }
      },
      style: AppStyles.labelBold.copyWith(
          height: 1.5,
          fontSize: 16,
          color: AppColors.secondary_20,
          fontWeight: FontWeight.w700),
      expands: widget.expands,
      // minLines: 1,
      maxLines: widget.multiline || widget.expands ? null : widget.maxLines,
      decoration: AppStyles.inputDefault.copyWith(
        labelText: widget.label,
        suffixIcon: getIcon(),
        alignLabelWithHint: widget.expands,
        labelStyle: AppStyles.labelBold.copyWith(
            height: 1,
            fontSize: 16,
            color: AppColors.secondary_40,
            fontWeight: FontWeight.w700),
        fillColor: _color,
        isDense: true,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _borderColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _borderColor),
        ),
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
