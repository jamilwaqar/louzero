import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/base_controller.dart';

const pixelRatio = 2.0;
const screenSize = Size(1620 * pixelRatio, 2160 * pixelRatio);

Widget makeTestableWidget({required Widget child, required WidgetTester tester}) {
  tester.binding.window.physicalSizeTestValue = screenSize;
  Get.put(BaseController());

  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MediaQuery(
      child: child,
      data: const MediaQueryData(
        size: screenSize,
        textScaleFactor: 1.0
      ),
    ),
    theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Roboto"),
  );
}