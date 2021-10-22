import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';

class ConfirmationDialog {
  static Future showConfirmationDialog(BuildContext context, {String content = "", String cancelTitle = "Cancel", String confirmTitle = "OK"}) {
    return showDialog(
        context: context,
        useRootNavigator: false,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            content: Text(
              content,
              style: TextStyle(
                  fontFamily: "Mulish",
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: AppColors.darkest),
            ),
            actions: <Widget>[
              CupertinoButton(
                  child: Text(
                    cancelTitle,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context, false);
                  }),
              CupertinoButton(
                  child: Text(
                      confirmTitle,
                      style: const TextStyle(
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context, true);
                  })
            ],
          );
        });

  }
}