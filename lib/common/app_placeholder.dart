import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppPlaceholder extends StatelessWidget {
  const AppPlaceholder({
    Key? key,
    this.title = '',
    this.subtitle = '',
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 224, maxHeight: 224),
      width: double.infinity,
      margin: EdgeInsets.only(top: 16, bottom: 16),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                title,
                style: AppStyles.headerRegular
                    .copyWith(color: AppColors.secondary_80),
              ),
            ),
          ),
          Text(
            subtitle,
            style: AppStyles.labelRegular,
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F8FA), Colors.white]),
      ),
    );
  }
}
