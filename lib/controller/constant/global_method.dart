import 'dart:math';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';

int verificationCode() {
  return Random().nextInt(900000)+ 100000;
}

void countryPicker(BuildContext context, Function(Country) onSelect) {
  showCountryPicker(
    context: context,
    showPhoneCode: true,
    onSelect: onSelect,
  );
}