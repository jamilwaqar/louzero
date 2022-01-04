import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/models/inventory_item.dart';

import 'models/line_item.dart';

class JobAddNewLine extends StatefulWidget {
  final void Function(LineItem)? onCreate;
  final VoidCallback? onCancel;
  final List<InventoryItem> inventory;
  final int selectedIndex;
  const JobAddNewLine({
    Key? key,
    this.onCreate,
    this.onCancel,
    this.inventory = const [],
    this.selectedIndex = 0,
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
  final _discountAmount = TextEditingController();

  bool isDiscountOn = false;
  bool isTaxable = false;
  bool isDiscountTypePercent = false;

  int _selected = 0;

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  void _clearInputs() {
    _description.text = '';
    _count.text = '1';
    _price.text = '0';
    _subtotal.text = '0';
    _note.text = '';
    _discountDescription.text = '';
  }

  void _updateSubtotal(String val) {
    double qty = double.tryParse(_count.text) ?? 1;
    double price = double.tryParse(_price.text) ?? 0;
    double total = qty * price;
    setState(() {
      _subtotal.text = total.toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    _count.text = '1';
  }

  @override
  Widget build(BuildContext context) {
    _addLineItem() {
      String description = _description.value.text;
      String note = _note.value.text;
      double count = double.tryParse(_count.value.text) ?? 1;
      double price = double.tryParse(_price.value.text) ?? 0;
      double discount = double.tryParse(_discountAmount.value.text) ?? 0;
      String discountText = _discountDescription.value.text;
      double subtotal = price * count;

      LineItem newItem = LineItem(
          count: count,
          price: price,
          description: description,
          subtotal: subtotal,
          note: note,
          discount: discount > 0 ? discount : null,
          discountText: discountText.length > 1 ? discountText : null);

      if (newItem.description == '') {
        print('enter description please');
      } else {
        if (widget.onCreate != null) {
          widget.onCreate!(newItem);
          _clearInputs();
        }
        // clear input values

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
            if (widget.inventory.isNotEmpty)
              InventoryDropdown(
                selectedIndex: _selected,
                items: widget.inventory,
                onChanged: (InventoryItem item) {
                  setState(() {
                    int selectedIndex = widget.inventory.indexWhere(
                        (element) => element.description == item.description);
                    _selected = selectedIndex;

                    var _item = widget.inventory[selectedIndex];
                    _price.text = _item.price.toStringAsFixed(2);
                    _subtotal.text = _item.price.toStringAsFixed(2);
                    _count.text = '1';
                    _description.text = item.description;
                  });
                },
              ),
            if (widget.inventory.isEmpty)
              AppInputText(
                controller: _description,
                label: "Product Name o service name",
              ),
            AppInputText(
              controller: _count,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              onChanged: _updateSubtotal,
              label: "Qty",
            ),
            AppInputText(
              controller: _price,
              label: "Price",
              onChanged: _updateSubtotal,
            ),
            AppInputText(
              controller: _subtotal,
              readOnly: true,
              label: "SubTotal",
            )
          ],
        ),
        AppInputText(controller: _note, label: "Comment"),
        FlexRow(
          flex: const [1, 1, 1],
          children: [
            AppSwitch(
                value: isDiscountOn,
                label: 'Add Discount',
                onChanged: (v) {
                  setState(() {
                    isDiscountOn = v;
                  });
                }),
            const SizedBox(width: 90),
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
                  label: "Discount description"),
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
              AppInputText(
                controller: _discountAmount,
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
                colorBg: AppColors.secondary_20,
                label: "Save",
                onPressed: () {
                  _addLineItem();
                },
              ),
              AppButton(
                label: "Cancel",
                colorBg: Colors.transparent,
                colorText: AppColors.secondary_60,
                textOnly: true,
                onPressed: () {
                  _clearInputs();
                  if (widget.onCancel != null) {
                    widget.onCancel!();
                  }
                },
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

class name extends StatelessWidget {
  const name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InventoryDropdown extends StatelessWidget {
  InventoryDropdown(
      {Key? key,
      this.items = const [],
      this.label = 'Select',
      this.selectedIndex = 0,
      required this.onChanged})
      : super(key: key);
  final List<InventoryItem> items;
  final String label;
  final int selectedIndex;
  final Function(InventoryItem) onChanged;

  DropdownMenuItem<InventoryItem> _menuItems(InventoryItem item) {
    return DropdownMenuItem<InventoryItem>(
      value: item,
      child: Text(item.description),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.labelBold),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.secondary_80, width: 1)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<InventoryItem>(
              items: items.map(_menuItems).toList(),
              value: items[selectedIndex],
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              style: const TextStyle(color: Colors.black),
              onChanged: (val) {
                onChanged(val!);
              },
            ),
          ),
        ),
      ],
    );
  }
}
