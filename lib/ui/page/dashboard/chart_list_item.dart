import 'package:flutter/material.dart';

class chartListItem {
  final Color color;
  final String title;
  final double amount;
  final String? subtitle;
  chartListItem({
    this.title = '',
    this.amount = 0,
    this.subtitle,
    this.color = Colors.black,
  });
}
