import 'package:flutter/widgets.dart';

class AuthLayout extends StatelessWidget {
  final List<Widget> children;
  const AuthLayout({this.children = const [], Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(
          height: 100,
          width: double.infinity,
        ),
        Image.asset("assets/icons/general/logo_icon_lg.png"),
        const SizedBox(
          height: 56,
        ),
        ...children
      ],
    );
  }
}
