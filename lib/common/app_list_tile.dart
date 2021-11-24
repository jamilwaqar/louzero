import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.colorBg = AppColors.light_1,
    this.iconStart = Icons.radio_button_off,
    this.iconEnd = Icons.chevron_right_sharp,
    this.mt = 0,
    this.mb = 0,
    this.mr = 0,
    this.ml = 0,
  }) : super(key: key);

  final IconData iconStart;
  final String title;
  final String subtitle;
  final IconData iconEnd;
  final Color colorBg;
  final double mt;
  final double mb;
  final double ml;
  final double mr;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 0, right: 0, top: 0, bottom: 0),
      elevation: 0,
      child: ListTile(
        leading: SizedBox(
          height: double.infinity,
          child: Icon(iconStart),
        ),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(title),
        ),
        subtitle: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(subtitle),
        ),
        trailing: SizedBox(
          height: double.infinity,
          child: Icon(iconEnd),
        ),
        tileColor: colorBg,
      ),
    );
  }
}
