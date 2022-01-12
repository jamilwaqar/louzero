import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/job_models.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppBillingLines extends StatelessWidget {
  final List<BillingLineModel> data;
  final Function(String)? onEdit;
  final Function(String)? onDelete;
  final Function(String)? onDuplicate;
  final Function(int, int)? onReorder;

  const AppBillingLines({
    Key? key,
    this.onEdit,
    this.onDelete,
    this.onDuplicate,
    this.onReorder,
    this.data = const [],
  }) : super(key: key);

  final TextStyle style = AppStyles.labelRegular;

  String prettify(double d) =>
      d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: ReorderableListView(
          onReorder: (a, b) {
            // print('reorder');
            // print('$a, $b');
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            ...data.asMap().entries.map((entry) {
              BillingLineModel item = entry.value;
              int index = entry.key;
              double pad = item.note != null ? 16 : 4;
              bool hasDiscount =
                  item.discountAmount > 0 && item.discountDescription != null;
              return Container(
                key: ValueKey('${item.objectId}-$index'),
                color: index % 2 == 0
                    ? AppColors.secondary_100
                    : AppColors.secondary_95,
                child: ListTile(
                  contentPadding: EdgeInsets.only(top: pad, bottom: pad),
                  dense: true,
                  key: ValueKey(item.objectId),
                  title: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _description(item),
                            _quantity(item),
                            _price(item),
                            _subtotal(item),
                            _actions(item.objectId!),
                          ]),
                      //Discount line
                      if (hasDiscount) ..._discount(item),
                    ],
                  ),
                ),
              );
            }).toList(),
          ]),
    );
  }

  List<Widget> _discount(BillingLineModel item) {
    return [
      const AppDivider(mt: 16, mb: 16, mr: 48, ml: 48),
      Padding(
        padding: const EdgeInsets.only(left: 48, right: 48),
        child: RowSplit(
          left: Text(item.discountDescription!, style: style.copyWith(fontSize: 14)),
          right: Text('- \$${item.discountAmount.toStringAsFixed(2)}', style: style),
        ),
      )
    ];
  }

  Widget _description(BillingLineModel item) {
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
                  if (item.note != null && item.note!.isNotEmpty)
                    const SizedBox(
                      height: 4,
                    ),
                  if (item.note != null && item.note!.isNotEmpty)
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

  Widget _quantity(BillingLineModel item) {
    return Expanded(
      flex: 1,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              prettify(item.quantity),
              style: style.copyWith(fontWeight: FontWeight.w400),
            ),
          ]),
    );
  }

  Widget _price(BillingLineModel item) {
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

  Widget _subtotal(BillingLineModel item) {
    double subtotal = item.quantity * item.price;
    return Expanded(
      flex: 1,
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Text(
          subtotal.toStringAsFixed(2).padRight(5, "0"),
          style: style,
        ),
      ]),
    );
  }

  Widget _actions(String id) {
    return AppPopMenu(
      button: const [
        SizedBox(
          width: 48,
          child: Icon(Icons.more_vert, size: 21, color: AppColors.secondary_60),
        ),
      ],
      items: [
        PopMenuItem(
            label: 'Edit',
            icon: MdiIcons.pencil,
            onTap: () {
              if (onEdit != null) {
                onEdit!(id);
              }
            }),
        PopMenuItem(
          label: 'Duplicate',
          icon: MdiIcons.contentDuplicate,
          onTap: () {
            if (onDuplicate != null) {
              onDuplicate!(id);
            }
          },
        ),
        PopMenuItem(
          label: 'Remove',
          icon: MdiIcons.trashCan,
          onTap: () {
            if (onDelete != null) {
              onDelete!(id);
            }
          },
        )
      ],
    );
  }
}
