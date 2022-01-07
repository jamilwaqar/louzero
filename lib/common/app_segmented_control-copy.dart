import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    Key? key,
    required this.itemList,
    required this.value,
    this.width,
    required this.onTap
  }) : super(key: key);
  final List<String> itemList;
  final int value;
  final double? width;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 300,
      child: CupertinoSlidingSegmentedControl(
          groupValue: value,
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.blue.shade200,
          thumbColor: Colors.red,
          children: <int, Widget>{
            0: Container(
              padding: const EdgeInsets.all(15),
              child: const Text('One'),
            ),
            1: Text('Two'),
            2: Text('Three')
          },
          onValueChanged: (value){
            onTap(value);
          }
      ),
    );
  }
}