import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';

import 'app_avatar.dart';

class AppAdvancedTextField extends StatefulWidget {
  const AppAdvancedTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.rightPadding = 15.0,
    this.leftPadding = 15.0,
    this.leftIcon,
    this.rightIcon,
    this.leftIconColor,
    this.rightIconColor,
    this.items,
    this.showClearIcon = false,
    this.isDropdown = false,
    this.multiline = false,
    this.maxLines,
    this.leadingImage,
    this.autofocus,
    this.onClear,
    this.onChange,
    this.onTap,
  }) : super(key: key);
  final bool isUnderlined = true;
  final TextEditingController controller;
  final String label;
  final double? leftPadding;
  final double? rightPadding;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Color? leftIconColor;
  final Color? rightIconColor;
  final List? items;
  final Uri? leadingImage;
  final bool? showClearIcon;
  final bool? isDropdown;
  final bool? multiline;
  final bool? autofocus;
  final int? maxLines;
  final Function? onClear;
  final Function? onChange;
  final Function? onTap;

  @override
  _AppAdvancedTextFieldState createState() => _AppAdvancedTextFieldState();
}

class _AppAdvancedTextFieldState extends State<AppAdvancedTextField> {
  final _textFieldFocus = FocusNode();
  Color _color = AppColors.secondary_99;
  late TextEditingController textController = widget.controller;
  final bool isUnderlined = true;

  @override
  void initState() {
    _textFieldFocus.addListener(() {
      if (_textFieldFocus.hasFocus) {
        setState(() {
          _color = Colors.transparent;
        });
      } else {
        if (textController.text.isNotEmpty && isUnderlined == true) {
          setState(() {
            _color = Colors.transparent;
          });
        } else {
          setState(() {
            _color = AppColors.secondary_99;
          });
        }
      }
    });

    if (textController.text.isNotEmpty && isUnderlined == true) {
      setState(() {
        _color = Colors.transparent;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTransparent =
        (textController.text.isNotEmpty && isUnderlined == true);
    print('widget.leadingImage ${widget.leadingImage}');
    return Stack(
      children: [
        TextField(
          cursorHeight: 16,
          cursorColor: AppColors.secondary_70,
          cursorWidth: 2,
          focusNode: _textFieldFocus,
          autofocus: widget.autofocus ?? false,
          controller: textController,
          style: AppStyles.labelBold.copyWith(
              height: 1.5, fontSize: 16, color: AppColors.secondary_20),
          minLines: 1,
          onChanged: (value) {
            widget.onTap != null ? widget.onChange!(value) : print('changed');
          },
          maxLines: widget.multiline == null ? null : widget.maxLines,
          readOnly: widget.isDropdown == true,
          onTap: () {
            if (widget.isDropdown == true) {
              showDialog(
                  useRootNavigator: true,
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _OptionsDialog(
                        options: widget.items!,
                        onChange: (value) {
                          widget.onChange!(value);
                        });
                  });
            } else {
              if (widget.onTap != null) {
                widget.onTap!();
              }
            }
          },
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
                left: widget.leftPadding!,
                right: widget.rightPadding!,
                top: 10.0,
                bottom: 10.0),
            labelStyle: const TextStyle(
                fontFamily: 'Lato', color: AppColors.secondary_40),
            fillColor: isTransparent ? Colors.transparent : _color,
            filled: true,
            labelText: widget.label,
            border: const UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: isTransparent ? Colors.grey : Colors.transparent),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.orange),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),
        ),
        widget.leadingImage != null
            ? Positioned(
                left: 0.0,
                top: 10.0,
                child: AppAvatar(
                    size: 40,
                    url: widget.leadingImage,
                    placeHolder: AppPlaceHolder.user),
              )
            : const SizedBox(),
        widget.isDropdown == true
            ? const Positioned(
                right: 10.0,
                top: 15.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.secondary_40,
                  ),
                ),
              )
            : const SizedBox(),
        widget.leftIcon != null
            ? Positioned(
                left: 0.0,
                top: 15.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    widget.leftIcon,
                    color: widget.leftIconColor ?? AppColors.secondary_40,
                  ),
                ),
              )
            : const SizedBox(),
        widget.rightIcon != null
            ? Positioned(
                right: 10.0,
                top: 12.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    widget.rightIcon,
                    color: widget.rightIconColor ?? AppColors.secondary_40,
                  ),
                ),
              )
            : const SizedBox(),
        widget.showClearIcon == true
            ? Positioned(
                right: 55.0,
                top: 26.0,
                child: CircleAvatar(
                  backgroundColor: AppColors.secondary_40,
                  radius: 10,
                  child: IconButton(
                    iconSize: 16,
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.clear),
                    color: Colors.white,
                    onPressed: () {
                      widget.onClear!();
                    },
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class _OptionsDialog extends StatelessWidget {
  @override
  _OptionsDialog({Key? key, required this.options, required this.onChange})
      : super(key: key);

  List options;
  Function onChange;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        content: Container(
          padding: const EdgeInsets.all(16),
          width: 300.0,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: options.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(options[index]),
                onTap: () {
                  Navigator.of(context).pop();
                  onChange(options[index]);
                },
              );
            },
          ),
        ));
  }
}
