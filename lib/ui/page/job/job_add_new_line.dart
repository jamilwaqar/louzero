import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';

import 'models/line_item.dart';

class JobAddNewLine extends StatefulWidget {
  final void Function(LineItem)? onCreate;
  const JobAddNewLine({
    Key? key,
    this.onCreate,
  }) : super(key: key);

  @override
  State<JobAddNewLine> createState() => _JobAddNewLineState();
}

class _JobAddNewLineState extends State<JobAddNewLine> {
  final c = Get.put(LineItemController());
  Size? size;
  final _description = TextEditingController();
  final _count = TextEditingController();
  final _price = TextEditingController();
  final _subtotal = TextEditingController();
  final _note = TextEditingController();
  final _discountDescription = TextEditingController();
  // final TextEditingController _discountAmount = TextEditingController();

  bool isDiscountOn = false;
  bool isTaxable = false;
  bool isDiscountTypePercent = false;
  @override
  Widget build(BuildContext context) {
    _addLineItem() {
      String description = _description.value.text;
      String note = _note.value.text;
      double count = double.tryParse(_count.value.text) ?? 1;
      double price = double.tryParse(_price.value.text) ?? 0;
      double subtotal = price * count;

      LineItem newItem = LineItem(
        count: count,
        price: price,
        description: description,
        subtotal: subtotal,
        note: note,
      );

      if (newItem.description == '') {
        print('enter description please');
      } else {
        if (widget.onCreate != null) {
          widget.onCreate!(newItem);
        }
      }
    }

    return AppCard(
      ml: 0,
      mr: 0,
      radius: 24,
      children: [
        RowSplit(
            left: const Text("Add New Line", style: AppStyles.headerRegular),
            right: AppIconButton(
              colorBg: Colors.transparent,
              onTap: () {
                // ignore: avoid_print
                print('Add this line');
              },
            )),
        FlexRow(
          flex: const [5, 1, 2, 2],
          children: [
            AppInputText(
              controller: _description,
              label: "Product Name o service name",
            ),
            AppInputText(
              controller: _count,
              label: "Qty",
            ),
            AppInputText(
              controller: _price,
              label: "Price",
            ),
            AppInputText(
              controller: _subtotal,
              label: "SubTotal",
            )
          ],
        ),
        AppInputText(controller: _note, label: "Comment"),
        FlexRow(
          flex: const [2, 1],
          children: [
            AppSwitch(
                value: isDiscountOn,
                label: 'Add Discount',
                onChanged: (v) {
                  setState(() {
                    isDiscountOn = v;
                  });
                }),
            AppCheckbox(
              label: 'Taxable',
              checked: isTaxable,
              onChanged: (val) {
                setState(() {
                  isTaxable = val!;
                });
              },
            ),
          ],
        ),
        if (isDiscountOn)
          const SizedBox(
            height: 16,
          ),
        if (isDiscountOn)
          FlexRow(
            flex: const [2, 0, 1],
            children: [
              AppInputText(
                  controller: _discountDescription,
                  label: "Product Name or service name"),
              Column(
                children: const [
                  SizedBox(height: 24),
                  Text("Discount Switch Here.")
                  // DiscountTypeSwitch(
                  //   firstLabel: '\$',
                  //   secondLabel: '%',
                  //   isOn: isDiscountTypePercent,
                  //   onTap: (value) {
                  //     setState(() {
                  //       isDiscountTypePercent = !value;
                  //     });
                  //   },
                  // ),
                ],
              ),
              const AppInputText(
                label: 'Amount',
              )
            ],
          ),
        const SizedBox(height: 16),
        RowSplit(
          align: 'center',
          left: Row(
            children: [
              AppButton(
                color: AppColors.secondary_20,
                label: "Save",
                onPressed: () {
                  _addLineItem();
                },
              ),
              AppButton(
                label: "Cancel",
                color: Colors.transparent,
                colorText: AppColors.secondary_60,
                textOnly: true,
                onPressed: () {},
              )
            ],
          ),
          right: const TextKeyValIcon(
            kkey: 'Sold By',
            val: 'Allen Whitaker',
          ),
        ),
      ],
    );
  }
}

class AppSwitch extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool value;
  final String label;

  const AppSwitch(
      {Key? key, required this.value, required this.label, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primary_1,
          // thumbColor: Colors.white,
        ),
        const SizedBox(
          width: 2,
        ),
        Text(label, style: AppStyles.labelBold),
      ],
    );
  }
}
