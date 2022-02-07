import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/ui/page/demo/demo.dart';
import 'package:louzero/ui/page/stub/views/stub_view_starter.dart';
import 'package:louzero/ui/page/stub/views/stub_view_counter.dart';

class StubNav extends StatelessWidget {
  const StubNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _stubs(children: [
      _stubLink('Demo Page', Demo()),
      _stubLink('Basic Prototype', StubViewHome()),
      _stubLink('Starter File', StubStarterView()),
    ]);
  }

  _stubs({List<Widget> children = const []}) {
    return Column(children: [
      const SizedBox(height: 16),
      Wrap(spacing: 16, runSpacing: 16, children: children)
    ]);
  }

  _stubLink(String label, Widget target) {
    return Buttons.flat(
      label,
      expanded: true,
      onPressed: () {
        Get.to(() => target);
      },
    );
  }
}
