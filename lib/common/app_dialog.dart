import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/utility/row_split.dart';
import 'package:louzero/controller/constant/colors.dart';

import 'app_button.dart';

class AppDialog extends Dialog {
  final Widget body;
  final String title;
  final Function()? onTapCancel;
  final Function() onTapOkay;
  final String? cancelLabel;
  final String okayLabel;
  final double? width;

  const AppDialog(
      {required this.body,
      required this.title,
      this.onTapCancel,
      required this.onTapOkay,
      this.cancelLabel,
      required this.okayLabel,
      this.width,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0)), //this right here
      child: Container(
        width: width ?? 360.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(title, style: AppStyles.headlineMedium),
            const SizedBox(height: 16),
            body,
            const SizedBox(height: 24),
            RowSplit(
              right: Row(
                children: [
                  Buttons.text(cancelLabel ?? 'Cancel', onPressed: () {
                    Get.back();
                    if (onTapCancel != null) onTapCancel!();
                  }),
                  const SizedBox(width: 16),
                  Buttons.primary(okayLabel, onPressed: () {
                    Get.back();
                    onTapOkay();
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
