import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';

class TopLeftButton extends StatelessWidget {
  final Function() onPressed;
  final IconData iconData;
  final double size;
  final Color bgColor;
  const TopLeftButton({required this.onPressed, required this.iconData, this.size = 24, this.bgColor = AppColors.light_4, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(size/2.0)
          ),
          child: Icon(iconData, color: AppColors.medium_2, size: 16,),
        ));
  }
}
