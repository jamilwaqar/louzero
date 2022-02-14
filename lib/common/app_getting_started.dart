import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/utils.dart';

class AppGettingStarted extends StatefulWidget{
  const AppGettingStarted({
    required this.description,
    required this.onCheckboxPress,
    required this.onGotItPress,
    Key? key
  }) : super(key: key);

  final String description;
  final Function onCheckboxPress;
  final Function() onGotItPress;

  @override
  _AppGettingStartedState createState() => _AppGettingStartedState();
}

class _AppGettingStartedState extends State<AppGettingStarted> {
  final _showMsg = false.obs;

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
              Text('Getting Started',
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
          _gotItButton(),
        ],
      ),
    );
  }

  Widget _notShowMsgWidget() => Container(
    height: 35,
    alignment: Alignment.centerLeft,
    child: CupertinoButton(
      onPressed: (){
        widget.onCheckboxPress(_showMsg.value);
      },
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(
                () => Checkbox(
                checkColor: Colors.white,
                value: _showMsg.value,
                activeColor: AppColors.dark_1,
                onChanged: (val) {
                  _showMsg.value = val!;
                }),
          ),
          const SizedBox(width: 8),
          const Text("Don't show this message again.",
              style: TextStyles.bodyL),
        ],
      ),
    ),
  );

  Widget _gotItButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            width: 83,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "Got it",
              style: TextStyles.labelL.copyWith(color: Colors.white),
            ),
          ),
          onPressed: widget.onGotItPress),
    );
  }
}