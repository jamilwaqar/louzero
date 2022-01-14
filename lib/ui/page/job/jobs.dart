import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/widget/widget.dart';
import '../app_base_scaffold.dart';
import 'views/jobs_home.dart';

class JobListPage extends GetWidget<JobController> {
  const JobListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'All Jobs (dev in progress)',
      child: _body(),
    );
  }


  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        itemCount: controller.jobModels.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          JobModel model = controller.jobModels[index];
          return DashboardCell(
            title: model.jobType,
            description: "",
            count: 0,
            buttonTitleLeft: "",
            buttonTitleRight: "",
            onPressed: ()=> Get.to(()=> JobsHome(controller.jobModels[index])),
            onPressedLeft: () {},
            onPressedRight: () {},
          );
        });
  }
}
