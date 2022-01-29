import 'package:flutter/material.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppTabsBasic extends StatefulWidget {
  final List<Widget> children;
  final List<String> tabs;
  final double contentHeight;

  const AppTabsBasic({
    this.children = const [],
    this.tabs = const [],
    this.contentHeight = 300,
    Key? key,
  }) : super(key: key);

  @override
  State<AppTabsBasic> createState() => _AppTabsBasicState();
}

class _AppTabsBasicState extends State<AppTabsBasic> {
  int _selectedPage = 0;
  late PageController _pageController;

  _changePage(int pageNumber) {
    setState(() {
      _selectedPage = pageNumber;
      _pageController.animateToPage(
        pageNumber,
        duration: const Duration(milliseconds: 700),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs
        // ignore: sized_box_for_whitespace
        Container(
          height: 70,
          child: FlexRow(
              crossAxisAlignment: CrossAxisAlignment.end,
              gap: 0,
              children: widget.tabs.asMap().entries.map((entry) {
                return TabButton(
                  isFirst: entry.key == 0,
                  isLast: entry.key == widget.tabs.length - 1,
                  label: entry.value,
                  pageNumber: entry.key,
                  selectedPage: _selectedPage,
                  onPressed: () {
                    _changePage(entry.key);
                  },
                );
              }).toList()),
        ),
        // Page
        Container(
          height: widget.contentHeight,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _selectedPage = page;
              });
            },
            children: widget.children,
          ),
        ),
      ],
    );
  }
}

class TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final bool isLast;
  final bool isFirst;
  final int selectedPage;
  final int pageNumber;
  final void Function()? onPressed;
  const TabButton({
    Key? key,
    required this.label,
    this.selected = false,
    this.selectedPage = 0,
    this.pageNumber = 0,
    this.isLast = false,
    this.isFirst = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _selected = selectedPage == pageNumber;
    Color _bg = _selected ? AppColors.white : AppColors.secondary_90;
    Color _bg2 = _selected ? AppColors.secondary_90 : AppColors.white;
    double _ht = _selected ? 70 : 50;
    double _size = _selected ? 32 : 16;
    bool _isOdd = pageNumber.floor().isOdd;

    return GestureDetector(
      onTap: onPressed,
      child: Stack(children: [
        _tab(
          radiusTopLeft: isFirst ||
              isLast && _selected ||
              !_selected && !isLast ||
              !_selected && isFirst,
          radiusTopRight: _selected && isFirst || isLast,
          colorBg: _bg2,
          height: _ht,
          size: _size,
        ),
        _tab(
            colorBg: _bg,
            height: _ht,
            size: _size,
            radiusTopLeft: isFirst ||
                isLast && _selected ||
                !_selected && !isLast ||
                !_selected && isFirst,
            radiusTopRight: _selected && isFirst || isLast,
            radiusLeft: !_selected && !isFirst,
            radiusRight: !_selected && !isLast),
      ]),
    );
  }

  Widget _tab(
      {required double height,
      required Color colorBg,
      required double size,
      bool radiusTopRight = false,
      bool radiusTopLeft = false,
      bool radiusRight = false,
      bool radiusLeft = false}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastLinearToSlowEaseIn,
      height: height,
      alignment: const Alignment(0, 0),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radiusTopLeft ? 16 : 0),
          topRight: Radius.circular(radiusTopRight ? 16 : 0),
          bottomRight: Radius.circular(radiusRight ? 16 : 0),
          bottomLeft: Radius.circular(radiusLeft ? 16 : 0),
        ),
      ),
      child: Text(label,
          style: AppStyles.headerRegular.copyWith(height: .9, fontSize: size)),
    );
  }
}
