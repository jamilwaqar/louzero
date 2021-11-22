import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/controller/constant/colors.dart';

class AppInputInlineForm extends StatefulWidget {
  const AppInputInlineForm({
    Key? key,
    required this.controller,
    required this.label,
    required this.btnLabel,
    this.autofocus = false,
    this.colorTx = AppColors.dark_3,
    this.colorBd = AppColors.light_3,
    this.colorBg = AppColors.lightest,
    this.colorBtnBg = AppColors.lightest,
    this.mt = 0,
    this.mb = 16,
    this.onPressed,
  }) : super(key: key);

  final String label;
  final String btnLabel;
  final Color colorBg;
  final Color colorBd;
  final Color colorTx;
  final Color colorBtnBg;
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final double mt;
  final double mb;
  final bool autofocus;

  @override
  _AppInputInlineFormState createState() => _AppInputInlineFormState();
}

class _AppInputInlineFormState extends State<AppInputInlineForm> {
  String newItemString = "";

  @override
  void initState() {
    super.initState();
    initTextEditingControllerListeners();
  }

  void initTextEditingControllerListeners() {
    widget.controller.addListener(onInputEdit);
  }

  void onInputEdit() {
    setState(() {
      newItemString = widget.controller.text;
    });
  }

  void clearInput() {
    setState(() {
      newItemString = '';
      widget.controller.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    var btnWidth = MediaQuery.of(context).size.width * 0.50;

    var inputText = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: widget.colorTx,
    );

    var inputContainer = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: widget.colorBg,
      border: Border.all(
        color: widget.colorBd,
        width: 1,
      ),
    );

    const textStyle = TextStyle(
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: AppColors.dark_2,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.mt,
        ),
        Text(
          widget.label,
          style: const TextStyle(
            color: AppColors.dark_2,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              height: 48,
              width: btnWidth,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: inputContainer,
              child: TextFormField(
                autofocus: widget.autofocus,
                controller: widget.controller,
                keyboardAppearance: Brightness.light,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: inputText,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: FloatingActionButton.extended(
                backgroundColor: widget.colorBtnBg,
                elevation: 0,
                extendedTextStyle: textStyle,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: widget.colorBd, width: 1.0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                onPressed:
                    widget.controller.text.isEmpty && widget.onPressed != null
                        ? null
                        : () {
                            widget.onPressed!();
                            clearInput();
                          },
                label: Text(
                  widget.btnLabel,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: newItemString.isNotEmpty
                        ? AppColors.dark_2
                        : AppColors.light_2,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: widget.mb,
        )
      ],
    );
  }
}
