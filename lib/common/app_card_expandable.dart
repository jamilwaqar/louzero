import 'package:flutter/material.dart';
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
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: widget.title,
            subtitle: widget.subtitle,
            trailing: const SizedBox.shrink(),
            tilePadding: const EdgeInsets.all(0),
            childrenPadding: const EdgeInsets.all(0),
            children: widget.children,
          ),
        )
      ],
    );
  }
}
