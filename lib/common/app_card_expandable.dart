import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'app_card.dart';

class AppCardExpandable extends StatefulWidget {
  final Widget title;
  final Widget? subtitle;
  final List<Widget> children;
  const AppCardExpandable({
    Key? key,
    required this.title,
    this.subtitle,
    this.children = const [],
  }) : super(key: key);

  @override
  State<AppCardExpandable> createState() => _AppCardExpandableState();
}

class _AppCardExpandableState extends State<AppCardExpandable> {
  @override
  Widget build(BuildContext context) {
    return AppCard(
      ml: 0,
      mr: 0,
      pt: 8,
      pb: 8,
      radius: 24,
      children: [
        _theme(
            child: ExpansionTile(
          title: widget.title,
          subtitle: widget.subtitle,
          trailing: const SizedBox.shrink(),
          tilePadding: const EdgeInsets.all(0),
          childrenPadding: const EdgeInsets.all(0),
          children: widget.children,
        ))
      ],
    );
  }

  Widget _theme({required Widget child}) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ListTileTheme(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          minLeadingWidth: 0,
          selectedColor: AppColors.orange,
          dense: true,
          child: child),
    );
  }
}
