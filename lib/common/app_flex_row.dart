import 'package:flutter/material.dart';

class AppFlexRow extends StatelessWidget {
  AppFlexRow({
    Key? key,
    this.children = const <Widget>[],
    this.flex = const <int>[],
    this.mt = 0,
    this.mb = 0,
  }) : super(key: key);

  final double mt;
  final double mb;
  final List<int> flex;
  final List<Widget> children;
  final List<Widget> items = [];

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      for (var i = 0; i < children.length; i++) {
        int _flex = flex.asMap().containsKey(i) ? flex[i] : 1;

        items.add(Expanded(flex: _flex, child: children[i]));
        if (i < children.length - 1) {
          items.add(const SizedBox(width: 16));
        }
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.toList(),
    );
  }
}
