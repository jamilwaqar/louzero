import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/constants.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/controller/utils.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/base_scaffold.dart';
import 'package:louzero/ui/widget/customer_info.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:louzero/utils/utils.dart';

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
  JobDetailPage(this.jobModel, {Key? key}) : super(key: key);
  final _jobCategory = JobCategory.details.obs;
  final JobModel jobModel;

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
            // _estimate()
            _moreActionsWidget()
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
    return Container(
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
        Image.asset('assets/icons/icon-calculator.png', width: 18, height: 18,),
        const SizedBox(width: 8),
        Text("Job Status: ", style: TextStyles.labelL.copyWith(color: AppColors.dark_3)),
        Text("Estimate", style: TextStyles.labelL.copyWith(color: AppColors.dark_3, fontWeight: FontWeight.bold)),
        const SizedBox(width: 8),
        appIcon(Icons.arrow_drop_down)
      ],
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
          _jobCategoryWidget(),
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

  Widget _jobCategoryWidget() {
    return Obx(() {
      switch (_jobCategory.value) {
        case JobCategory.details:
          return _jobDetailsWidget();
        case JobCategory.schedule:
          return _jobDetailsWidget();
        case JobCategory.billing:
          return _reorderList();
      }
    }) ;
  }

  Widget _jobDetailsWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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

  _moreActionsWidget() => PopupMenuButton<OverflowMenuItem>(
      icon: _estimate(),
      iconSize: 264,
      offset: const Offset(-40, 60),
      onSelected: (item) => item.onTap(),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.white,
      itemBuilder: (_) => _appBarPopUpActions()
          .map((item) => PopupMenuItem<OverflowMenuItem>(
          value: item, child: _moreActionItem(item)))
          .toList());

  Widget _moreActionItem(OverflowMenuItem item) =>
      Row(mainAxisSize: MainAxisSize.min, children: [
        item.icon!,
        const SizedBox(width: 8),
        Text(item.title,
            style: const TextStyle(color: Colors.black87, fontSize: 16)),
        const SizedBox(width: 110),
      ]);

  List<OverflowMenuItem> _appBarPopUpActions() {
    List<JobStatus> list = [...JobStatus.values];
    return List.generate(
        list.length,
            (index) {
          String label = list[index].name.capitalizeFirst!;
          return OverflowMenuItem(
              title: label,
              icon: Image.asset(list[index].icon, width: 24, height: 24),
              onTap: () => _moreAction(list[index]));
        });
  }

  final Color _oddItemColor = const Color(0xFFF1F2F4);
  final Color _evenItemColor = const Color(0xFFF8F9FB);
  Widget _reorderList() {
    Map<String, dynamic>items = jobModel.billingLineModel.items;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: ReorderableListView(
        shrinkWrap: true,
        children: <Widget>[
          for (int index = 0; index < items.length; index++)
            Container(
              key: Key('$index'),
              width: double.infinity,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(index == 0 ? 8 : 0),
                    topRight: Radius.circular(index == 0 ? 8 : 0),
                    bottomLeft: Radius.circular(index == items.length - 1 ? 8 : 0),
                    bottomRight: Radius.circular(index == items.length - 1 ? 8 : 0)),
                color: index.isOdd ? _oddItemColor : _evenItemColor,
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  appIcon(Icons.menu, color: AppColors.medium_2),
                  const SizedBox(width: 16),
                  Expanded(child: _textField(items.keys.toList()[index])),
                  const SizedBox(width: 16),
                  Expanded(child: _textField(items[items.keys.toList()[index]])),
                  const SizedBox(width: 32),
                  InkWell(
                    onTap: () {

                    },
                    child: appIcon(Icons.delete, color: AppColors.medium_2),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {

        },
      ),
    );
  }

  Widget _textField(String label) {
    return Container(
      height: 48,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.light_3, width: 1),
          color: Colors.white
      ),
      child: Text(
        label,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.dark_3),
      ),
    );
  }

  void _moreAction(JobStatus status) {

  }
}