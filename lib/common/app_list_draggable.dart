import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppListDraggable extends StatefulWidget {
  const AppListDraggable({
    Key? key,
    required this.items,
    this.oddRowColor = AppColors.lightest,
    this.evenRowColor = AppColors.light_1,
    this.selectedColor = AppColors.medium_3,
    this.mt = 10.0,
    this.mb = 20.0,
  }) : super(key: key);
  final List<String> items;
  final Color oddRowColor;
  final Color selectedColor;
  final Color evenRowColor;
  final double mt; // margin top (defalt:10)
  final double mb; // margin bottom (default:20)
  @override
  _AppListDraggableState createState() => _AppListDraggableState();
}

class _AppListDraggableState extends State<AppListDraggable> {
  void removeItem(int indexToRemove) {
    setState(() {
      widget.items.removeAt(indexToRemove);
    });
  }

  @override
  Widget build(BuildContext context) {
    const draggableItemTextStyle = TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: AppColors.dark_1,
      fontFamily: 'Roboto',
    );

    return Column(
      children: [
        SizedBox(
          height: widget.mt,
        ),
        ReorderableListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          buildDefaultDragHandles: false,
          children: <Widget>[
            for (int index = 0; index < widget.items.length; index++)
              Container(
                key: Key('$index'),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: index.isOdd ? widget.oddRowColor : widget.evenRowColor,
                  borderRadius:
                      getDraggableItemBorderRadius(index, widget.items.length),
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 56,
                      padding: const EdgeInsets.only(
                        left: 8,
                        right: 12,
                      ),
                      child: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(
                          Icons.drag_handle,
                        ),
                      ),
                    ),
                    Text(
                      widget.items[index],
                      style: draggableItemTextStyle,
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.edit,
                              color: AppColors.dark_1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              removeItem(index);
                            },
                            child: const Icon(
                              Icons.delete,
                              color: AppColors.dark_1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
          ],
          onReorder: (int oldIndex, int newIndex) {
            setState(
              () {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final String item = widget.items.removeAt(oldIndex);
                widget.items.insert(newIndex, item);
              },
            );
          },
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }

  BorderRadiusGeometry? getDraggableItemBorderRadius(int index, int maxItems) {
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    }

    if (index == (maxItems - 1)) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
  }
}
