import 'package:flutter/material.dart';

class AppLabeledLine extends StatelessWidget {
  const AppLabeledLine({
    Key? key,
    required this.label,
    this.height = 10,
  }) : super(key: key);

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),

      Text(label),

      Expanded(
        child: Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: Divider(
              color: Colors.black,
              height: height,
            )),
      ),
    ]);
  }
}