import 'package:flutter/material.dart';

class ChartListItem {
  final Color color;
  final String title;
  final double amount;
  final String? subtitle;
  ChartListItem({
    this.title = '',
    this.amount = 0,
    this.subtitle,
    this.color = Colors.black,
  });
}
