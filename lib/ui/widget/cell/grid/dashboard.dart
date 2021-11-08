import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class DashboardCell extends StatelessWidget {
  const DashboardCell({Key? key, this.title = "", this.description = "", this.image, this.buttonTitleLeft, this.buttonTitleRight, this.count, this.height = 176, this.onPressed, this.onPressedLeft, this.onPressedRight}) : super(key: key);
  final String title;
  final String description;
  final String? image;
  final String? buttonTitleLeft;
  final String? buttonTitleRight;
  final int? count;
  final double height;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        height: 176,
        padding: EdgeInsets.fromLTRB(16, count == null ? 16 : 12, 16, 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.light_3.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: const Icon(
                          Icons.image,
                          color: AppColors.light_3,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              title,
                              style: const TextStyle(
                                color: AppColors.dark_1,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              )
                          ),
                          const SizedBox(width: 16,),
                          Text(
                              description,
                              style: const TextStyle(
                                color: AppColors.medium_3,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              )
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (count != null)
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.light_2
                    ),
                    child: Text(
                        "${count ?? 0}",
                        style: const TextStyle(
                          color: AppColors.darkest,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        )
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (buttonTitleLeft != null)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onPressedLeft,
                    child: Text(
                        buttonTitleLeft ?? "",
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        )
                    ),
                  ),
                if (buttonTitleRight != null)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onPressedRight,
                    child: Text(
                        buttonTitleRight ?? "",
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        )
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
