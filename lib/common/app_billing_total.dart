import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'app_divider.dart';

class AppBillingTotal extends StatelessWidget {
  const AppBillingTotal({Key? key, this.subtotal = 0.0, this.tax = 0.0})
      : super(key: key);
  final double subtotal;
  final double tax;

  double _getTaxAmount() => subtotal * tax / 100;
  double _getTotalAmount() => subtotal + _getTaxAmount();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const SizedBox(
          height: 16,
        ),
        _lineItem('Subtotal', subtotal, style: AppStyles.labelRegular),
        _lineItem('Tax', _getTaxAmount(),
            borderWidth: 2, style: AppStyles.labelRegular),
        _lineItem('Total', _getTotalAmount(),
            borderWidth: 0, style: AppStyles.headerRegular),
      ],
    );
  }

  Widget _lineItem(
    String label,
    double amount, {
    TextStyle style = AppStyles.labelBold,
    double borderWidth = 1,
  }) {
    return Row(children: [
      const Spacer(),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [Text(label, style: style)],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 48),
                      child: Text(
                          '\$' + amount.toStringAsFixed(2).padRight(4, "0"),
                          style: style),
                    )
                  ],
                ),
              )
            ]),
            if (borderWidth != 0)
              AppDivider(
                mt: 16,
                mb: 16,
                size: borderWidth,
              )
          ],
        ),
      ),
    ]);
  }
}
