import 'dart:math';

import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/ui/page/app_base_scaffold.dart';
import 'app_card.dart';

class AppCardTabs extends StatefulWidget {
  const AppCardTabs({
    Key? key,
    required this.children,
    required this.length,
    required this.tabNames,
    this.height = 400,
    this.radius = 8,
    this.uppercase = true,
  }) : super(key: key);

  final bool uppercase;
  final int length;
  final double height;
  final double radius;
  final List<Widget> children;
  final List<String> tabNames;

  @override
  State<AppCardTabs> createState() => _AppCardTabsState();
}

class _AppCardTabsState extends State<AppCardTabs> {
  final Color _labelColor = AppColors.secondary_30;
  final Color _borderFocus = AppColors.orange;
  final Color _borderBlur = AppColors.secondary_90;
  final Color _backgroundTabs = AppColors.secondary_99;
  int _selectedTab = 0;

  final double _borderWidth = 2;

  Tab _tab(String text) {
    String _label = widget.uppercase ? text.toUpperCase() : text;
    return Tab(
      child: Text(
        _label,
        style: AppStyles.headerSmall,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.length,
      child: AppCard(mx: 0, px: 0, py: 0, my: 0, children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: _backgroundTabs.withOpacity(0.5),
            border: Border(bottom: BorderSide(color: _borderBlur, width: 2)),
          ),
          child: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTab = index;
              });
            },
            indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 2, color: _borderFocus),
                insets: const EdgeInsets.symmetric(horizontal: 0)),
            labelColor: _labelColor,
            indicatorColor: _borderFocus,
            padding: const EdgeInsets.symmetric(horizontal: 0),
            tabs: widget.tabNames.map((name) {
              return _tab(name);
            }).toList(),
          ),
        ),
        widget.children[_selectedTab]
      ]),
    );
  }
}
