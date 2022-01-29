import 'package:flutter_test/flutter_test.dart';
import 'package:louzero/controller/constant/validators.dart';

void main() {
  test("Email Validation", () async {
    const email1 = 'test@gmail.com';
    const email2 = 'test.gmail.com';

    expect(Valid.email(email1), true);
    expect(Valid.email(email2), false);
  });
}