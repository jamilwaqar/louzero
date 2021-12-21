import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

import 'app_card.dart';

class AppCardTabs extends StatelessWidget {
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

  final Color _labelColor = AppColors.secondary_30;
  final Color _borderFocus = AppColors.orange;
  final Color _borderBlur = AppColors.secondary_90;
  final Color _backgroundTabs = AppColors.secondary_99;
  final double _borderWidth = 2;

  Tab _tab(String text) {
    String _label = uppercase ? text.toUpperCase() : text;
    return Tab(
      child: Text(
        _label,
        style: appStyles.header_small,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
        mt: 24,
        pl: 0,
        pr: 0,
        pt: 0,
        pb: 0,
        radius: radius,
        children: [
          DefaultTabController(
            length: 3,
            // ignore: sized_box_for_whitespace
            child: Container(
              height: height,
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: _backgroundTabs.withOpacity(0.5),
                      border: Border(
                          bottom: BorderSide(
                              color: _borderBlur, width: _borderWidth)),
                    ),
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                              width: _borderWidth, color: _borderFocus),
                          insets: const EdgeInsets.symmetric(horizontal: 0)),
                      labelColor: _labelColor,
                      indicatorColor: _borderFocus,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      tabs: tabNames.map((name) {
                        return _tab(name);
                      }).toList(),
                    ),
                  ),
                  Expanded(
                      child: TabBarView(
                    children: children,
                  ))
                ],
              ),
            ),
          )
        ]);
  }
}
