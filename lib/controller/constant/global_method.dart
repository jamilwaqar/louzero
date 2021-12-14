import 'dart:math';

int verificationCode() {
  return Random().nextInt(900000)+ 100000;
}