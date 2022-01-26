import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'app_card.dart';

class AppCardTabs extends StatefulWidget {
  final bool uppercase;
  final int length;
  final double height;
  final double radius;
  final List<Widget> children;
  final List<String> tabNames;
  final double px;
  final double py;
  final double mx;
  final double mt;
  final double mb;

  const AppCardTabs({
    Key? key,
    required this.children,
    required this.length,
    required this.tabNames,
    this.height = 400,
    this.radius = 8,
    this.uppercase = true,
    this.px = 24, // content padding : left/right
    this.py = 16, // content padding : top/bottom
    this.mt = 0,
    this.mb = 0,
    this.mx = 0,
  }) : super(key: key);

  @override
  State<AppCardTabs> createState() => _AppCardTabsState();
}

class _AppCardTabsState extends State<AppCardTabs> {
  final Color _labelColor = AppColors.secondary_30;
  final Color _borderFocus = AppColors.orange;
  final Color _borderBlur = AppColors.secondary_90;
  final Color _backgroundTabs = AppColors.secondary_99;
  int _selectedTab = 0;

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
      child: AppCard(
          mb: widget.mb,
          mt: widget.mt,
          mx: widget.mx,
          px: 0,
          py: 0,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: _backgroundTabs.withOpacity(0.5),
                border:
                    Border(bottom: BorderSide(color: _borderBlur, width: 2)),
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
            Padding(
              padding: EdgeInsets.only(
                  top: widget.py,
                  bottom: widget.py,
                  left: widget.px,
                  right: widget.px),
              child: widget.children[_selectedTab],
            )
          ]),
    );
  }
}
