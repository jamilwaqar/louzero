import 'package:flutter/widgets.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_card.dart';
import 'package:louzero/controller/constant/colors.dart';

class StubCounter extends StatelessWidget {
  final Function()? onPressed;
  final int count;

  const StubCounter({
    Key? key,
    this.onPressed,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      my: 48,
      maxWidth: 200,
      color: AppColors.secondary_70,
      children: [
        Column(
          children: [
            Text(
              '$count',
              style: AppStyles.headerAppBar.copyWith(fontSize: 90),
            ),
            const SizedBox(
              height: 16,
            ),
            Buttons.submit('Add Item',
                expanded: true,
                colorBg: AppColors.secondary_40,
                onPressed: onPressed),
          ],
        )
      ],
    );
  }
}
