import 'package:flutter/material.dart';

class OverflowMenuItem {
  final String title;
  final Function onTap;
  final Widget? icon;

  OverflowMenuItem({
    required this.title,
    required this.onTap,
    this.icon
  });
}