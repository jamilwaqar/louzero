import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/page/job/add_job.dart';
import 'package:louzero/ui/page/job/job_detail.dart';
import 'package:louzero/ui/widget/appbar_action.dart';
import 'package:louzero/ui/widget/widget.dart';

class JobListPage extends GetWidget<JobController> {
  const JobListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Jobs",
          context: context,
          leadingTxt: "Home",
          actions: [
            AppBarAction(
                label: 'Add New',
                onPressed: () => Get.to(()=> AddJobPage()))
          ],
        ),
        backgroundColor: Colors.transparent,
        body: _body(),
      ),
    );
  }


  Widget _body() {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        itemCount: controller.jobModels.length,
        itemBuilder: (context, index) {
          JobModel model = controller.jobModels[index];
          return DashboardCell(
            title: model.status,
            description: "",
            count: 0,
            buttonTitleLeft: "",
            buttonTitleRight: "",
            onPressed: ()=> Get.to(()=> JobDetailPage(controller.jobModels[index])),
            onPressedLeft: () {},
            onPressedRight: () {},
          );
        });
  }
}
