import 'package:flutter/material.dart';

class RowSplit extends StatelessWidget {
  final Widget? left;
  final Widget? right;
  final String align;
  final String space;

  const RowSplit({
    this.left,
    this.right,
    this.align = 'start',
    this.space = 'center',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CrossAxisAlignment _align = CrossAxisAlignment.start;

    if (align == 'end') {
      _align = CrossAxisAlignment.end;
    }
    if (align == 'center') {
      _align = CrossAxisAlignment.center;
    }
    if (align == 'start') {
      _align = CrossAxisAlignment.start;
    }

    return Row(
      crossAxisAlignment: _align,
      children: [
        if (space == 'end') const Spacer(),
        if (left != null)
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [left!],
          ),
        if (space == 'center') const Spacer(),
        if (right != null)
          Wrap(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [right!],
          ),
        if (space == 'start') const Spacer(),
      ],
    );
  }
}
