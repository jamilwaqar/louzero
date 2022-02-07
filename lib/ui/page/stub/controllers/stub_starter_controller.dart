import 'package:get/get.dart';

class StubStarterController extends GetxController {
  var _count = 0.obs;

  int get count => _count.value;

  set count(int amt) {
    _count.value = amt;
  }
}
