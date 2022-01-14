import 'package:flutter/cupertino.dart';
import 'dart:math';

class AppSegmentedToggle extends StatefulWidget {
  const AppSegmentedToggle({
    Key? key,
    required this.itemList,
    this.width,
    required this.onChange,
    this.isVertical
  }) : super(key: key);
  final List<String> itemList;
  final double? width;
  final Function onChange;
  final bool? isVertical;

  @override
  _AppSegmentedToggleState createState() => _AppSegmentedToggleState();
}
class _AppSegmentedToggleState extends State<AppSegmentedToggle> {
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
        quarterTurns: widget.isVertical == true ? 1 : 0,
        child: SizedBox(
          width: widget.width ?? 120,
          child: CupertinoSlidingSegmentedControl(
              groupValue: selectedItem,
              backgroundColor: const Color(0xFFF1F3F5),
              children: <int, Widget>{
                for (final item in widget.itemList.asMap().entries)
                  item.key: _segmentItem(item.value, widget.isVertical),
              },
              onValueChanged: (value){
                setState(() {
                  selectedItem = value as int;
                });
                widget.onChange(widget.itemList[selectedItem]);
              }
          ),
        )
    );
  }

  Widget _segmentItem(text, isVertical) => Container(
    padding: isVertical == true ? const EdgeInsets.only(top: 15, bottom: 15) : const EdgeInsets.all(15),
    child: RotatedBox(quarterTurns: isVertical == true ? -1 : 0, child: Text(text),),
  );
}