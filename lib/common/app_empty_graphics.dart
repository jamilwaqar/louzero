import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppEmptyGraphics extends StatelessWidget{
  const AppEmptyGraphics({
    required this.title,
    required this.description,
    Key? key
  }) : super(key: key);

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF6F8FA), Colors.white]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: AppStyles.headerRegular.copyWith(color: AppColors.secondary_80),),
          const SizedBox(height: 32,),
          Text(description, style: AppStyles.labelRegular.copyWith(color: AppColors.secondary_50),),
        ],
      ),
    );
  }

}