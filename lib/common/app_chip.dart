import 'package:flutter/material.dart';

class AppChip extends StatelessWidget {
  const AppChip({
    Key? key,
    this.color,
    required this.text,
  }) : super(key: key);
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color?.withOpacity(0.1) ?? Colors.red.withOpacity(0.15),
      labelPadding: const EdgeInsets.only(left: 16, right: 16),
      label: Text(text,
          style: TextStyle(
            fontFamily: 'Lato',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: color ?? Colors.red,
          )),
    );
  }
}
