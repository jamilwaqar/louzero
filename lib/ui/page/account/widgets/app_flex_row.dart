import 'package:flutter/widgets.dart';

class AppFlexRow extends StatelessWidget {
  const AppFlexRow({
    Key? key,
    required this.children,
    this.mt = 0,
    this.mb = 0,
  }) : super(key: key);

  final List<Widget> children;
  final double mt;
  final double mb;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
