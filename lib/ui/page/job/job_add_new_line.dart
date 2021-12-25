import 'package:flutter/material.dart';
import 'package:louzero/common/app_billing_lines.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/common/app_checkbox.dart';
import 'package:louzero/common/app_flex_row.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/app_input_text.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
  // final c = Get.put(JobBillingController());
  Size? size;
  final TextEditingController _productName = TextEditingController();
  final TextEditingController _qty = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _subtotal = TextEditingController();
  final TextEditingController _comment = TextEditingController();
  final TextEditingController _discountDescription = TextEditingController();
  // final TextEditingController _discountAmount = TextEditingController();

  bool isDiscountOn = false;
  bool isTaxable = false;
  bool isDiscountTypePercent = false;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      ml: 0,
      mr: 0,
      radius: 24,
      children: [
        SplitRow(
          children: [
            const Text("Add New Line", style: AppStyles.headerRegular),
            AppIconButton(
              colorBg: Colors.transparent,
              onTap: () {
                // ignore: avoid_print
                print('Add this line');
              },
            )
          ],
        ),
        AppFlexRow(
          flex: const [5, 1, 2, 2],
          children: [
            AppInputText(
              controller: _productName,
              label: "Product Name o service name",
            ),
            AppInputText(
              controller: _qty,
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
        AppInputText(controller: _comment, label: "Comment"),
        AppFlexRow(
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
          AppFlexRow(
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
        SplitRow(
          children: [
            Row(
              children: [
                AppButton(
                  color: AppColors.secondary_20,
                  label: "Save",
                  onPressed: () {},
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
            const AppBylineIcon(
              prefix: 'Sold By',
              label: 'Allen Whitaker',
            ),
          ],
        ),
      ],
    );
  }
}

class SplitRow extends StatelessWidget {
  final List<Widget> children;

  const SplitRow({
    Key? key,
    this.children = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
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

class AppBylineIcon extends StatelessWidget {
  final String label;
  final String prefix;
  final IconData icon;
  final Color colorIcon;
  final Color color;
  final VoidCallback? onTap;

  const AppBylineIcon({
    Key? key,
    required this.label,
    this.prefix = 'By',
    this.color = AppColors.secondary_20,
    this.colorIcon = AppColors.secondary_20,
    this.icon = MdiIcons.pencil,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          prefix,
          style: AppStyles.labelRegular.copyWith(color: color),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          label,
          style: AppStyles.labelBold.copyWith(color: color),
        ),
        const SizedBox(
          width: 5,
        ),
        GestureDetector(
            onTap: onTap,
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: colorIcon.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 15, color: colorIcon)))
      ],
    );
  }
}
