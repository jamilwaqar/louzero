import 'package:flutter/material.dart';
import 'package:louzero/common/app_textfield.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';

import 'app_avatar.dart';

class AppAdvancedTextField extends StatelessWidget {
  const AppAdvancedTextField({
    Key? key,
    this.controller,
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
    this.leadingImage,
    this.autofocus,
    this.onClear,
    this.onChange,
    this.onTap,
  }) : super(key: key);
  final bool isUnderlined = true;
  final TextEditingController? controller;
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
  final bool? autofocus;
  final Function? onClear;
  final Function? onChange;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (isDropdown == true) {
              showDialog(
                  useRootNavigator: true,
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return _OptionsDialog(
                      options: items!,
                      onChange: (value) {onChange!(value);}
                    );
                  });
            } else {
              if (onTap != null) {
                onTap!();
              }
            }
          },
          child: AppTextField(
            label: label,
            controller: controller,
            enabled: false,
          ),
          // isReadOnly: onTap != null,
          // leftPadding: leftPadding,
          // rightPadding: rightPadding,
          // label: label,
          // controller: controller,
          // isUnderlined: isUnderlined,
        ),
        leadingImage != null ?
        Positioned(
            left: 0.0,
            top: 10.0,
            child: AppAvatar(size: 40, url: leadingImage, placeHolder: AppPlaceHolder.user),
        ) : const SizedBox(),
        isDropdown == true
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
        leftIcon != null
            ? Positioned(
                left: 0.0,
                top: 15.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    leftIcon,
                    color: leftIconColor ?? AppColors.secondary_40,
                  ),
                ),
              )
            : const SizedBox(),
        rightIcon != null
            ? Positioned(
                right: 10.0,
                top: 12.0,
                child: SizedBox(
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    rightIcon,
                    color: rightIconColor ?? AppColors.secondary_40,
                  ),
                ),
              )
            : const SizedBox(),
        showClearIcon == true
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
                      onClear!();
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
