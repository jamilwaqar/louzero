import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import '../../../app_base_scaffold.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/common/common.dart';
import '../controllers/starter_controller.dart';

class StarterPage extends GetView<StubStarterController> {
  const StarterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(StubStarterController());
    return AppBaseScaffold(
      subheader: 'Starter View',
      child: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        const SizedBox(height: 32),
        _myWidget(),
      ],
    );
  }

  Widget _myWidget() {
    return const AppCard(children: [
      Text("Widget Implementation Here.", style: AppStyles.headerRegular),
    ]);
  }
}
