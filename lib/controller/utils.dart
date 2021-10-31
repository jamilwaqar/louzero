import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/state/auth_state.dart';

class Utils {
  static final Utils _singleton = Utils._internal();
  factory Utils() {
    return _singleton;
  }
  Utils._internal() {
    // Initialize
  }

  bool get isIOS => Platform.isIOS;
  EdgeInsets safeArea(BuildContext context) => MediaQuery.of(context).padding;
  double safePaddingTop(BuildContext context) => MediaQuery.of(context).padding.top;
  double safePaddingBottom(BuildContext context) => MediaQuery.of(context).padding.bottom;
  Size screenSize(BuildContext context) => MediaQuery.of(context).size;

  Future initialize() async {
    AuthStateManager().initializeManager();
  }
}

Icon appIcon(IconData iconData, {Color? color}) {
  return Icon(iconData, size: 24, color: color ?? AppColors.icon);
}