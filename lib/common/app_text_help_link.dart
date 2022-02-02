import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTextHelpLink extends StatelessWidget {
  const AppTextHelpLink(
      {Key? key,
      required this.label,
      required this.linkText,
      required this.onPressed,
      this.trailingText,
      this.colorLink,
      this.colorText,
      this.split = false,
      this.center = true,
      this.darkMode = false,
      this.mt = 0,
      this.mb = 0,
      this.ml = 0,
      this.mr = 0})
      : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final String linkText;
  final String? trailingText;
  final Color? colorLink;
  final Color? colorText;
  final bool split;
  final bool center;
  final bool darkMode;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    Color _textColor = colorText ?? AppColors.secondary_20;
    Color _linkColor = colorLink ?? AppColors.primary_50;

    if (darkMode && colorLink == null && colorText == null) {
      _textColor = AppColors.secondary_99;
      _linkColor = AppColors.primary_70;
    }

    TextStyle _text = AppStyles.labelRegular.copyWith(color: _textColor);
    TextStyle _link = AppStyles.labelRegular.copyWith(color: _linkColor);

    return Padding(
      padding: EdgeInsets.only(top: mt, left: ml, right: mr, bottom: mb),
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label.trim(), style: _text),
          if (split) const Spacer(),
          GestureDetector(
            onTap: onPressed,
            child: Text(' ${linkText.trim()} ', style: _link),
          ),
          if (trailingText != null) Text(trailingText!.trim(), style: _text)
        ],
      ),
    );
  }
}
