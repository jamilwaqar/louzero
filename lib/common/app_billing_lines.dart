import 'package:flutter/material.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LineItem {
  final String description;
  final double count;
  final double price;
  final double subtotal;
  final String? note;

  const LineItem({
    required this.description,
    required this.count,
    required this.price,
    required this.subtotal,
    this.note,
  });

  LineItem copy({
    String? description,
    double? count,
    double? price,
    double? subtotal,
  }) =>
      LineItem(
        description: description ?? this.description,
        count: count ?? this.count,
        price: price ?? this.price,
        subtotal: subtotal ?? this.subtotal,
      );
}

class AppBillingLines extends StatelessWidget {
  final List<LineItem> data;
  AppBillingLines({Key? key, this.data = const []}) : super(key: key);

  final TextStyle style =
      AppStyles.labelRegular.copyWith(fontWeight: FontWeight.w600);

  String prettify(double d) =>
      d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: ReorderableListView(
          onReorder: (a, b) {},
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ...data.asMap().entries.map((entry) {
              LineItem item = entry.value;
              int index = entry.key;
              double pad = item.note != null ? 16 : 4;
              return Container(
                key: ValueKey(item),
                color: index % 2 == 0
                    ? AppColors.secondary_100
                    : AppColors.secondary_95,
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: pad, bottom: pad),
                  dense: true,
                  key: ValueKey(item),
                  title: Column(children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _description(item),
                          _quantity(item),
                          _price(item),
                          _subtotal(item),
                          _actions(),
                        ]),
                  ]),
                ),
              );
            }).toList(),
          ]),
    );
  }

  Widget _description(LineItem item) {
    return Expanded(
      flex: 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // DRAG HANDLE
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            SizedBox(
              width: 48,
              child: Icon(
                Icons.menu,
                size: 21,
                color: AppColors.secondary_60,
              ),
            ),
          ]),
          // DESCRIPTION DATA
          Flexible(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item.description,
                    style: style,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (item.note != null)
                    Text(item.note!,
                        style: style.copyWith(
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                            fontSize: 14))
                ]),
          )
        ],
      ),
    );
  }

  Widget _quantity(LineItem item) {
    return Expanded(
      flex: 1,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              prettify(item.count),
              style: style.copyWith(fontWeight: FontWeight.w400),
            ),
          ]),
    );
  }

  Widget _price(LineItem item) {
    return Expanded(
      flex: 1,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          item.price.toString().padRight(4, "0"),
          style: style.copyWith(fontWeight: FontWeight.w400),
        ),
      ]),
    );
  }

  Widget _subtotal(LineItem item) {
    return Expanded(
      flex: 1,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          item.subtotal.toStringAsFixed(2).padRight(5, "0"),
          style: style,
        ),
      ]),
    );
  }

  Widget _actions() {
    return const AppPopMenu(
      button: [
        SizedBox(
          width: 48,
          child: Icon(Icons.more_vert, size: 21, color: AppColors.secondary_60),
        ),
      ],
      items: [
        PopMenuItem(label: 'Edit', icon: MdiIcons.pencil),
        PopMenuItem(label: 'Duplicate', icon: MdiIcons.contentDuplicate),
        PopMenuItem(label: 'Remove', icon: MdiIcons.trashCan)
      ],
    );
  }
}
