import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationController {
  static final NavigationController _singleton = NavigationController._internal();
  factory NavigationController() {
    return _singleton;
  }
  NavigationController._internal() {
    // Initialize
  }

  final notifierInitLoading = ValueNotifier(false);

  void pushTo(BuildContext context, {required Widget child}) {
    String name = child.toString();
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            settings: RouteSettings(name: "/$name"),
            child: child));
  }
  void pop(BuildContext context, {int delay = 0}) {
    if (delay == 0) {
      Navigator.pop(context);
    } else {
      Future.delayed(Duration(seconds: delay))
          .then((value) => Navigator.pop(context));
    }
  }

  void popToFirst(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      return route.isFirst;
    });
  }

  void loading({bool isLoading = true, int delay = 0}) {
    if (delay == 0) {
      notifierInitLoading.value = isLoading;
    } else {
      Future.delayed(Duration(milliseconds: delay))
          .then((value) => notifierInitLoading.value = isLoading);
    }
  }
}
