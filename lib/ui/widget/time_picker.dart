import 'package:flutter/material.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_segmented_toggle.dart';
import 'package:louzero/common/app_text_body.dart';
import 'package:louzero/controller/constant/colors.dart';

class NZTimePicker extends StatefulWidget{
  const NZTimePicker({
    Key? key,
    required this.onChange
  }) : super(key: key);

  final Function onChange;

  @override
  _NZTimePickerState createState() => _NZTimePickerState();
}

class _NZTimePickerState extends State<NZTimePicker> {
  final TextEditingController _hourController = TextEditingController();
  final TextEditingController _minuteController = TextEditingController();
  final FocusNode _minuteFocusNode = FocusNode();
  final FocusNode _hourFocusNode = FocusNode();
  Color _minuteBgColor = const Color(0xFFF1F3F5);
  Color _minuteBorderColor = const Color(0xFFF1F3F5);
  Color _hourBgColor = const Color(0xFFF1F3F5);
  Color _hourBorderColor = const Color(0xFFF1F3F5);
  String _timeMeridian = "";

  void focusNextInput(value) {
    if(int.parse(value) > 12) {
      _hourController.text = "";
      return;
    }

    if(value[0] != null && int.parse(value[0]) > 1 ){
      FocusScope.of(context).nextFocus();
    }

    if(value.length == 2) {
      FocusScope.of(context).nextFocus();
    }
  }

  void validateInput(value) {
    if(int.parse(value) > 60) {
      _minuteController.text = "";
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    _hourFocusNode.addListener(() {
      setState(() {
        if(_hourFocusNode.hasFocus) {
          _hourBgColor = Colors.white;
          _hourBorderColor =  AppColors.primary_1;
        }
        else{
          if(_hourController.text.isNotEmpty) {
            _hourBgColor = Colors.white;
            _hourBorderColor =  AppColors.secondary_30;
          }
          else{
            _hourBgColor = const Color(0xFFF1F3F5);
            _hourBorderColor =  const Color(0xFFF1F3F5);
          }
        }
      });
    });

    _minuteFocusNode.addListener(() {
      setState(() {
        if(_minuteFocusNode.hasFocus) {
          _minuteBgColor = Colors.white;
          _minuteBorderColor =  AppColors.primary_1;
        }
        else{
          if(_hourController.text.isNotEmpty) {
            _minuteBgColor = Colors.white;
            _minuteBorderColor =  AppColors.secondary_30;
          }
          else{
            _minuteBgColor = const Color(0xFFF1F3F5);
            _minuteBorderColor =  const Color(0xFFF1F3F5);
          }
        }
      });
    });

    void updateTime() {
      final time = "${_hourController.text}:${_minuteController.text} $_timeMeridian";
      print('time $time');
      Navigator.of(context).pop();
      widget.onChange(time);
    }


    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Container(
        width: 380.0,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Align(
              alignment: Alignment.centerLeft,
              child: AppTextBody('Enter Time', color: AppColors.secondary_20,),
            ),
            const SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _TextField(
                        autofocus: true,
                        backgroundColor : _hourBgColor,
                        borderColor: _hourBorderColor,
                        focusNode: _hourFocusNode,
                        controller: _hourController,
                        onChange: (value){focusNextInput(value);},
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                const SizedBox(
                  width: 15,
                  child: Text(":", style: TextStyle(
                      fontSize: 55.0,

                    fontFamily: 'Roboto',
                    letterSpacing: -0.75,
                  ),)
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      _TextField(
                        backgroundColor : _minuteBgColor,
                        borderColor: _minuteBorderColor,
                        focusNode: _minuteFocusNode,
                        controller: _minuteController,
                        onChange: (value){validateInput(value);},
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                    flex: 1,
                    child: AppSegmentedToggle(
                        width: 90,
                        isVertical: true,
                        itemList: const ["AM", "PM"],
                        onChange: (value){
                          setState(() {
                            _timeMeridian = value;
                          });
                        }
                    )
                )

              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: const [
                Expanded(
                  flex: 2,
                  child: AppTextBody('Hour'),
                ),
                SizedBox(width: 10,),
                SizedBox(
                    width: 15,
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 2,
                  child: AppTextBody('Minute'),
                ),
                SizedBox(width: 10,),
                Expanded(
                  flex: 1,
                  child: Text(""),
                )
              ]
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 AppButton(
                    label: 'Cancel',
                    primary: false,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    colorBg: AppColors.secondary_60),
                 const SizedBox(width: 10,),
                 AppButton(
                     label: 'Ok',
                     width: 80,
                     colorBg: AppColors.orange,
                   onPressed: () {
                     updateTime();
                   },
                 ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    Key? key,
    required this.controller,
    required this.onChange,
    required this.focusNode,
    required this.backgroundColor,
    required this.borderColor,
    this.autofocus
  }) : super(key: key);
  final TextEditingController controller;
  final Function onChange;
  final FocusNode focusNode;
  final Color backgroundColor;
  final Color borderColor;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus == null ? false : true,
      controller: controller,
      focusNode: focusNode,
      onChanged: (value){onChange(value);},
      maxLength: 2,
      style: const TextStyle(
        fontSize: 35.0,
        color: AppColors.secondary_30,
        fontFamily: 'Roboto',
        letterSpacing: -0.75,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 2.0)
        ),
        counterText: '',
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor, width: 2.0)
        ),
      ),
    );
  }
}