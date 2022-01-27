import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  test("Email Validation", () async {
    const email1 = 'test@gmail.com';
    const email2 = 'test.gmail.com';

    // TODO: It should be changed it to the actual function of Login page (Josh is working on it).
    expect(GetUtils.isEmail(email1), true);
    expect(GetUtils.isEmail(email2), false);
  });
}