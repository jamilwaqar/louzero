import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/mock_data.dart';
import 'package:louzero/ui/page/stub/counter/controllers/counter_controller.dart';
import 'package:louzero/ui/page/stub/counter/models/mockJob.dart';
import 'package:louzero/ui/page/stub/counter/widgets/simple_counter.dart';

import '../../../app_base_scaffold.dart';

class CounterPage extends GetView<StubController> {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StubController());
    return AppBaseScaffold(
      subheader: 'Basic Counter',
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _counter(),
        _listOfStuff(),
      ],
    );
  }

  Widget _counter() {
    return Obx(() {
      return SimpleCounter(
        count: controller.count,
        onPressed: controller.increment,
      );
    });
  }

  Widget _listOfStuff() {
    List<MockJob> items = controller.items;
    return Column(
      children: items.map((item) {
        return AppCard(
          mb: 0,
          children: [
            Text(item.name, style: AppStyles.headerDialog),
            const AppDivider(),
            _text(item.fullName!, color: AppColors.orange),
            _text(item.address),
            _text(item.jobType),
            _text(item.date!),
            const AppDivider(),
            _text('Total: ${MockData.formatPrice(item.total!)}',
                color: AppColors.black),
          ],
        );
      }).toList(),
    );
  }

  Widget _text(String text, {Color color = AppColors.secondary_30}) {
    var _style = AppStyles.labelBold.copyWith(color: color);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: _style),
    );
  }
}
