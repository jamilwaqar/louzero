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
  final bool? isReadOnly;
  final bool? isUnderlined;
  final double? leftPadding;
  final double? rightPadding;
  final Function? onTap;

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
    this.isUnderlined = false,
    this.leftPadding = 15.0,
    this.rightPadding = 0.0,
    this.onTap,
    this.isReadOnly,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _textFieldFocus = FocusNode();
  Color _color = AppColors.secondary_99;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    if(widget.controller != null) {
      setState(() {
        textController = widget.controller!;
      });
    }

    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.transparent;
        });
      } else {
        if(textController.text.isNotEmpty && widget.isUnderlined == true) {
          setState(() {
            _color = Colors.transparent;
          });
        }
        else{
          setState(() {
            _color = AppColors.secondary_99;
          });
        }
      }
    });

    if(textController.text.isNotEmpty && widget.isUnderlined == true) {
      setState(() {
        _color = Colors.transparent;
      });
    }
    super.initState();
  }

  // Widget _input() {
  //   return TextFormField(
  //     enabled: widget.enabled,
  //     initialValue: widget.initialValue.isNotEmpty ? widget.initialValue : null,
  //     focusNode: _textFieldFocus,
  //     autofocus: widget.autofocus,
  //     controller: widget.controller,
  //     style: AppStyles.labelBold
  //         .copyWith(height: 1.5, fontSize: 16, color: AppColors.secondary_20),
  //     minLines: 1,
  //     onChanged: widget.onChanged,
  //     maxLines: widget.multiline ? null : widget.maxLines,
  //     decoration: AppStyles.inputDefault.copyWith(
  //       labelText: widget.label,
  //       fillColor: _color,
  //       isDense: true,
  //     ),
  //   );
  // }
  //
  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(bottom: widget.mb),
  //     child: _input(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final bool isTransparent =  (textController.text.isNotEmpty && widget.isUnderlined == true);

    return TextField(
      cursorHeight: 16,
      cursorColor: AppColors.secondary_70,
      cursorWidth: 2,
      focusNode: _textFieldFocus,
      autofocus: widget.autofocus,
      controller: textController,
      style: AppStyles.labelBold
          .copyWith(height: 1.7, fontSize: 16, color: AppColors.secondary_20),
      minLines: 1,
      maxLines: null,
      readOnly: widget.isReadOnly == true,
      onTap: (){widget.onTap != null ? widget.onTap!() : print('tapped');},
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(left: widget.leftPadding!, right: widget.rightPadding!, top: 10.0, bottom: 10.0),
        labelStyle:
        const TextStyle(fontFamily: 'Lato', color: AppColors.secondary_40),
        fillColor: isTransparent ? Colors.transparent : _color,
        filled: true,
        labelText: widget.label,
        border: const UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: isTransparent ? Colors.grey : Colors.transparent),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.orange),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
}
