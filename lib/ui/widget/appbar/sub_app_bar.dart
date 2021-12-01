import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/page_navigation/navigation_controller.dart';
import 'package:louzero/ui/widget/appbar_action.dart';

class SubAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final String leadingTxt;
  final bool hasActions;
  final BuildContext context;
  final Function()? onPressed;
  final bool centerTitle;
  final double leadingWidth;

  const SubAppBar(
      {required this.title,
        required this.context,
        this.actions,
        this.leading,
        this.leadingTxt = '',
        this.hasActions = true,
        this.centerTitle = true,
        this.leadingWidth = 200,
        this.onPressed, Key? key})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      title: Text(title, style: TextStyles.headLineM.copyWith(color: AppColors.dark_3)),
      centerTitle: centerTitle,
      leading: leading ?? _leading,
      leadingWidth: leadingWidth,
      actions: actions ?? (hasActions ? [_cancel] : null),
    );
  }

  Widget get _leading {
    return InkWell(
      onTap: ()=> Get.back(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 32),
          const Icon(Icons.arrow_back, color: AppColors.icon),
          const SizedBox(width: 8),
          Text(leadingTxt, style: TextStyles.titleM),
        ],
      ),
    );
  }

  Widget get _cancel {
    return AppBarAction(
        label: 'Cancel', onPressed: () => NavigationController().pop(context));
  }
}