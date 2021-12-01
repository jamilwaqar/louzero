import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.iconStart = Icons.radio_button_off,
    this.iconEnd = Icons.chevron_right_sharp,
    this.colorBg = AppColors.light_1,
    this.mt = 0,
    this.mb = 0,
    this.mr = 0,
    this.ml = 0,
  }) : super(key: key);

  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final IconData iconStart;
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
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        leading: SizedBox(
          height: double.infinity,
          child: Icon(iconStart),
        ),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(title),
        ),
        subtitle: subtitle != null
            ? Transform.translate(
                offset: const Offset(-16, 0),
                child: Text(subtitle!),
              )
            : null,
        trailing: SizedBox(
          height: double.infinity,
          child: Icon(iconEnd),
        ),
        tileColor: colorBg,
      ),
    );
  }
}
