import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppBarAction extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const AppBarAction({required this.label, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label, style: TextStyles.titleM),
      ),
    );
  }
}
