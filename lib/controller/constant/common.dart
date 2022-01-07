import 'package:flutter/material.dart';

abstract class Common {
  static const Radius radius_4 = Radius.circular(4.0);
  static const Radius radius_8 = Radius.circular(8.0);
  static const Radius radius_16 = Radius.circular(16.0);
  static const Radius radius_24 = Radius.circular(20.0);
  static const Radius radius_99 = Radius.circular(999.0);

  static const BorderRadius border_4 = BorderRadius.all(Common.radius_4);
  static const BorderRadius border_8 = BorderRadius.all(Common.radius_8);
  static const BorderRadius border_16 = BorderRadius.all(Common.radius_16);
  static const BorderRadius border_24 = BorderRadius.all(Common.radius_24);
  static const BorderRadius border_99 = BorderRadius.all(Common.radius_99);
}
