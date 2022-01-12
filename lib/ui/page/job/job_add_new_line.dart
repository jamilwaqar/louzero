import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/models/inventory_item.dart';
import 'package:uuid/uuid.dart';

class JobAddNewLine extends StatefulWidget {
  final Uuid uuid = const Uuid();
  final void Function()? onCreate;
  final VoidCallback? onCancel;
  final BillingLineModel? initialData;
  final List<InventoryItem>? inventory;
  final int selectedIndex;
  final bool isTextInput;
  final String jobId;
  const JobAddNewLine({
    Key? key,
    this.onCreate,
    this.onCancel,
    required this.jobId,
    this.isTextInput = false,
    this.inventory = const [],
    this.selectedIndex = 0,
    this.initialData,
  }) : super(key: key);

  @override
  State<JobAddNewLine> createState() => _JobAddNewLineState();
}

class _JobAddNewLineState extends State<JobAddNewLine> {
  final _controller = Get.put(LineItemController());

  final _description = TextEditingController();
  final _count = TextEditingController();
  final _price = TextEditingController();
  final _subtotal = TextEditingController();
  final _note = TextEditingController();
  final _discountDescription = TextEditingController();
  final _discountAmount = TextEditingController();

  String inventoryId = '';
  bool hasDiscount = false;
  bool isTaxable = false;

  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    super.dispose();
    _description.dispose();
    _count.dispose();
    _price.dispose();
    _subtotal.dispose();
    _note.dispose();
    _discountDescription.dispose();
    _discountAmount.dispose();
  }

  String prettify(double d) {
    // removes trailing zeros
    return d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');
  }

  void setCount(double d) {
    _count.text = prettify(d);
  }

  void setPrice(double d) {
    _price.text = d.toStringAsFixed(2);
  }

  void setSubtotal(double d) {
    _subtotal.text = d.toStringAsFixed(2);
  }

  void setDescription(String text) {
    _description.text = text;
  }

  void _initializeData() {
    if (!widget.isTextInput) {
      var _item = _controller.inventory[widget.selectedIndex];
      setPrice(_item.price);
      setSubtotal(_item.price);
      setCount(1);
      setDescription(_item.description);
    }
  }

  int getInventoryIndex(BillingLineModel item) {
    var idx =
        _controller.inventory.indexWhere((el) => el.id == item.inventoryId);
    return idx >= 0 ? idx : 0;
  }

  void _clearInputs() {
    _description.text = '';
    _count.text = '1';
    _price.text = '0';
    _subtotal.text = '0';
    _note.text = '';
    _discountDescription.text = '';
  }

  void _updateSubtotal([String? val]) {
    double qty = double.tryParse(_count.text) ?? 1;
    double price = double.tryParse(_price.text) ?? 0;
    double total = qty * price;
    setState(() {
      _subtotal.text = total.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    _onSubmit() {
      var description = _description.text;
      var note = _note.text;
      var count = double.tryParse(_count.text) ?? 1;
      var price = double.tryParse(_price.text) ?? 0;
      var discount = double.tryParse(_discountAmount.text) ?? 0;
      var discountText = _discountDescription.text;
      var subtotal = double.parse((price * count).toStringAsFixed(2));

      BillingLineModel newItem = BillingLineModel(
        jobId: widget.jobId,
        objectId: const Uuid().v4(),
        quantity: count,
        price: price,
        description: description,
        subtotal: subtotal,
        note: note,
        discountAmount: discount,
        discountDescription: discountText.length > 1 ? discountText : null,
        inventoryId: inventoryId,
      );

      if (newItem.description?.isEmpty ?? true) {
        // print('enter description please');
      } else {
        if (widget.onCreate != null) {
          _controller.addLineItem(newItem);
          widget.onCreate!();
          _clearInputs();
        }
        // clear input values

      }
    }

    void _onInventoryChange(InventoryItem item) {
      setState(() {
        int selectedIndex = _controller.inventory
            .indexWhere((element) => element.description == item.description);
        _selected = selectedIndex;
        var _item = _controller.inventory[selectedIndex];
        _price.text = _item.price.toStringAsFixed(2);
        _subtotal.text = _item.price.toStringAsFixed(2);
        _count.text = '1';
        _description.text = item.description;
        inventoryId = item.id;
      });
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
            if (!widget.isTextInput)
              InventoryDropdown(
                selectedIndex: _selected,
                items: _controller.inventory,
                onChanged: _onInventoryChange,
              ),
            if (widget.isTextInput)
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
                value: hasDiscount,
                label: 'Add Discount',
                onChanged: (v) {
                  setState(() {
                    hasDiscount = v;
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
        if (hasDiscount)
          const SizedBox(
            height: 16,
          ),
        if (hasDiscount)
          FlexRow(
            flex: const [2, 0, 1],
            children: [
              AppInputText(
                  controller: _discountDescription,
                  label: "Discount description"),
              Column(
                children: [
                  SizedBox(height: 24),
                  AppSegmentedToggle(
                      itemList: ["%", "\$"],
                      onChange: (value) {
                        print('value changed: $value');
                      })
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
                  _onSubmit();
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

class InventoryDropdown extends StatelessWidget {
  const InventoryDropdown(
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
