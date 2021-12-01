import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/customer_info.dart';
import 'package:louzero/ui/widget/widget.dart';

enum JobCategory {
  details,
  schedule,
  billing,
}

extension JobCategoryEx on JobCategory {
  String get label {
    switch (this) {
      case JobCategory.details:
        return "JOB DETAILS";
      case JobCategory.schedule:
        return "SCHEDULE";
      case JobCategory.billing:
        return "BILLING";
    }
  }
}

class JobDetailPage extends GetWidget<JobController> {
  JobDetailPage({Key? key}) : super(key: key);
  final _jobCategory = JobCategory.details.obs;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      child: Scaffold(
        appBar: SubAppBar(
          title: "Repair",
          centerTitle: false,
          context: context,
          leadingTxt: "Jobs",
          leadingWidth: 130,
          actions: [
            _estimate()
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
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomerInfo(
                tempCustomerModel!,
                fromJob: true,
              ),
              const SizedBox(height: 16),
              _bottomWidget()
            ],
          );
        });
  }

  Widget _estimate() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {  },
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(right: 32.0),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.lightest,
            border: Border.all(color: AppColors.dark_3),
            borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/icons/icon-calculator.png', width: 10, height: 15,),
          const SizedBox(width: 8),
          Text("Job Status: ", style: TextStyles.labelL.copyWith(color: AppColors.dark_3)),
          Text("Estimate", style: TextStyles.labelL.copyWith(color: AppColors.dark_3, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          appIcon(Icons.arrow_drop_down)
        ],
      ),
      ),
    );
  }

  Widget _bottomWidget() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.light_2, width: 1),
        color: AppColors.lightest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _jobCategoryTabBar(),
          _jobDetails(),
          const Divider(height: 24, indent: 24, endIndent: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Row(
              children: [
                Expanded(child: _categoryItem(true)),
                const SizedBox(width: 24),
                Expanded(child: _categoryItem(false)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _jobCategoryTabBar() {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Row(children: [
        Expanded(child: _tabItem(JobCategory.values[0])),
        Expanded(child: _tabItem(JobCategory.values[1])),
        Expanded(child: _tabItem(JobCategory.values[2])),
      ]),
    );
  }

  Widget _tabItem(JobCategory category) {
    return Obx(() => InkWell(
          onTap: () => _jobCategory.value = category,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      child: Text(category.label,
                          style: TextStyles.titleS
                              .copyWith(color: AppColors.dark_3)))),
              Container(
                  color: _jobCategory.value == category
                      ? AppColors.dark_3
                      : const Color(0xFFF1F2F4),
                  height: 2)
            ],
          ),
        ));
  }

  Widget _jobDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Repair",
              style: TextStyles.headLineS.copyWith(color: AppColors.dark_3)),
          const SizedBox(height: 24),
          Row(
            children: [
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Job Description",
                        style: TextStyles.bodyL.copyWith(
                            color: AppColors.dark_3,
                            fontWeight: FontWeight.bold)),
                    Text(
                        "Need to fix something imporant at this job. Maybe this request is very long? How long are these on average?",
                        style:
                            TextStyles.bodyL.copyWith(color: AppColors.dark_3),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _detailText('Job Number: ', '8520'),
                      _detailText('Job Created: ', '08/03/2021'),
                      _detailText('Created by: ', 'Allan Whitaker'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailText(String label, String val) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: TextStyles.bodyL.copyWith(color: AppColors.dark_3)),
        Text(val,
            style: TextStyles.bodyL.copyWith(
                color: AppColors.dark_3, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _categoryItem(bool isChecklists) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 128,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.light_2, width: 1),
          color: AppColors.lightest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.light_1,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: Text(isChecklists ? "Checklists" : "Pictures",
                              style: TextStyles.titleL
                                  .copyWith(color: AppColors.dark_3))),
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.light_2,
                        ),
                        child: const Text('1',
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.dark_3,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isChecklists
                        ? "Description"
                        : "Keep track of location photos, job photos, and more",
                    style: TextStyles.bodyM.copyWith(color: AppColors.dark_3),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
