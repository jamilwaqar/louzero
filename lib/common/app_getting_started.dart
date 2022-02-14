import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/utils.dart';

class AppGettingStarted extends StatefulWidget{
  const AppGettingStarted({
    this.title = "Getting Started",
    required this.description,
    required this.onCheckboxPress,
    required this.onGotItPress,
    this.confirmButtonText = "Got It",
    Key? key
  }) : super(key: key);

  final String title;
  final String description;
  final String confirmButtonText;
  final Function onCheckboxPress;
  final Function() onGotItPress;

  @override
  _AppGettingStartedState createState() => _AppGettingStartedState();
}

class _AppGettingStartedState extends State<AppGettingStarted> {
  bool _showMsg = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.primary_95,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              appIcon(Icons.lightbulb_outline, color: AppColors.primary_60),
              const SizedBox(width: 8),
              Text(widget.title,
                  style:
                  AppStyles.headerRegular.copyWith(color: AppColors.dark_3)),
            ],
          ),
          const SizedBox(height: 24),
          Text(widget.description,
              style: TextStyles.bodyM.copyWith(color: AppColors.dark_3)),
          const SizedBox(height: 24),
          _notShowMsgWidget(),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerRight,
            child: AppButton(
                label: widget.confirmButtonText,
                colorBg: AppColors.orange,
                onPressed: widget.onGotItPress
            ),
          )

        ],
      ),
    );
  }

  Widget _notShowMsgWidget() => Container(
    height: 35,
    alignment: Alignment.centerLeft,
    child: CupertinoButton(
      onPressed: (){
        setState(() {
          _showMsg = false;
        });
      },
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
              checkColor: Colors.white,
              value: _showMsg,
              activeColor: AppColors.dark_1,
              onChanged: (val) {
                setState(() {
                  _showMsg = val!;
                });
              }),
          const SizedBox(width: 8),
          const Text("Don't show this message again.",
              style: TextStyles.bodyL),
        ],
      ),
    ),
  );
}