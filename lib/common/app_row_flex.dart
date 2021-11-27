import 'package:flutter/material.dart';

// wraps children in Flexible widgets in a row
// accepts a list of integers which define flex values for each child in order of array

class AppRowFlex extends StatelessWidget {
  const AppRowFlex({
    Key? key,
    required this.children,
    this.flex = const [],
    this.mt = 0,
    this.mb = 16,
    this.mr = 0,
    this.ml = 0,
  }) : super(key: key);
  final List<Widget> children;
  final List<int> flex;
  final double mt;
  final double mb;
  final double mr;
  final double ml;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: mt, bottom: mb, left: ml, right: mr),
      child: Row(
        children: children.asMap().entries.map((entry) {
          return Flexible(
            flex: entry.key < flex.length ? flex[entry.key] : 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: entry.value,
            ),
          );
        }).toList(),
      ),
    );
  }
}
