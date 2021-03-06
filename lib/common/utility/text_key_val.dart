import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class TextKeyVal extends StatelessWidget {
  final String _key;
  final String val;
  final double size;
  final double gap;
  final bool split;
  final TextStyle? keyStyle;
  final TextStyle? valStyle;

  const TextKeyVal(
    this._key,
    this.val, {
    this.size = 14,
    this.gap = 8,
    this.keyStyle,
    this.valStyle,
    this.split = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle s1 = keyStyle ?? AppStyles.labelRegular.copyWith(fontSize: size);
    TextStyle s2 = valStyle ?? AppStyles.labelBold.copyWith(fontSize: size);
    return Row(
      mainAxisAlignment:
          split ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,
      children: [
        Text(_key, style: s1),
        SizedBox(width: gap),
        Text(
          val,
          style: s2,
        )
      ],
    );
  }
}
