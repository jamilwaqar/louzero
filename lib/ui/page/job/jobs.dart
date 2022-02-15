import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enums.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/ui/page/job/controllers/job_list_controller.dart';
import 'package:louzero/ui/page/job/views/widget/job_datatable.dart';
import 'package:louzero/ui/page/job/views/widget/job_details_popup.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/widget/widget.dart';
import '../app_base_scaffold.dart';

class JobListPage extends GetWidget<JobListController> {
  JobListPage({Key? key}) : super(key: key);

  final TextEditingController _searchText = TextEditingController();
  late final FocusNode _searchFocus = FocusNode()..addListener(() {
    if (kDebugMode) {
      print(_searchFocus.hasFocus);
    }
    if(_searchFocus.hasFocus) {
      controller.hideModal();
    }
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobListController>(
        builder: (_) => AppBaseScaffold(
              subheader: 'All Jobs',
              onBodyTap: () {
                controller.hideModal();
              },
              onAppbarVisibilityChange: (isVisible) {
                controller.popModalHeight.value =
                    isVisible ? Get.height - 220 : Get.height - 40;
              },
              child: SizedBox(
                height: Get.height,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          AppSegmentedControl(
                            fromMax: true,
                            isStretch: true,
                            backgroundColor: AppColors.secondary_95,
                            onTap: () {
                              controller.hideModal();
                            },
                            children: {
                              JobStatus.estimate:
                                  jobStatusItem(JobStatus.estimate),
                              JobStatus.booked: jobStatusItem(JobStatus.booked),
                              JobStatus.invoiced:
                                  jobStatusItem(JobStatus.invoiced),
                              JobStatus.canceled:
                                  jobStatusItem(JobStatus.canceled),
                            },
                            onValueChanged: (JobStatus value) {
                              controller.selectedJobStatus = value;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 300,
                                height: 35,
                                child: _searchBox(),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              AppSimpleDropDown(
                                  label: "Job Type",
                                  onSelected: (value) {
                                    controller.selectedType = value;
                                  },
                                  onTap: () {
                                    controller.hideModal();
                                  },
                                  onClear: () {
                                    controller.selectedType = '';
                                  },
                                  items: Get.find<AuthController>().user.jobTypes),
                              const SizedBox(
                                width: 8,
                              ),
                              AppSimpleDropDown(
                                  label: "Duration",
                                  backgroundColor: Colors.white,
                                  onClear: () {
                                    controller.selectedDuration.value = null;
                                    controller.sortByDuration();
                                  },
                                  onTap: () {
                                    controller.hideModal();
                                  },
                                  onSelected: (value) {
                                    try{
                                      JobDurationFilter filter = JobDurationFilter.values.firstWhere((element) => element.label == value);
                                      controller.selectedDuration.value = filter;
                                      controller.showCustomDateRange.value =
                                      false;
                                      controller.sortByDuration();
                                    } catch(e) {
                                      if (kDebugMode) {
                                        print(e.toString());
                                        controller.selectedDuration.value = null;
                                        controller.sortByDuration();
                                      }
                                    }
                                  },
                                  dividerPosition: const [4, 5],
                                  items: JobDurationFilter.values
                                      .map((e) => e.label)
                                      .toList()),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('${controller.selectedJobStatus.label} Jobs ',
                                        style: const TextStyle(
                                          fontFamily: 'Barlow',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondary_20,
                                        )),
                                    Text(
                                      '(${controller.tableItems.length})',
                                      style: const TextStyle(
                                        fontFamily: 'Barlow',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.secondary_50,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text('Total: ',
                                        style: TextStyle(
                                          fontFamily: 'Barlow',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondary_20,
                                        )),
                                    Text('\$${controller.total}',
                                        style: const TextStyle(
                                          fontFamily: 'Barlow',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondary_50,
                                        ))
                                  ],
                                ),
                              ]),
                          const AppDivider(),
                          const SizedBox(
                            height: 8,
                          ),
                          Flexible(
                              flex: 1,
                              child: JobDataTable(
                                  models: controller.tableItems,
                                  onSortTap: (category, isAsc) {
                                    controller.sortItems(category, isAsc);
                                  },
                                  onMoreButtonTap: () {
                                    controller.isDetailsPopupVisible.value =
                                        true;
                                  })),
                          const SizedBox(
                            height: 32,
                          )
                        ],
                      ),
                    ),
                    Obx(()=> controller.showCustomDateRange.value
                        ? Positioned(
                        right: 0,
                        top: 140,
                        width: MediaQuery.of(context).size.width,
                        child: DelayedWidget(
                          animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                          child: _customDateRangeModel(),
                        ))
                        : const SizedBox()),
                    Obx(()=> controller.isDetailsPopupVisible.value
                        ? Positioned(
                        height: controller.popModalHeight.value != 0
                            ? controller.popModalHeight.value
                            : Get.height - 220,
                        width: 370,
                        right: 20,
                        top: 20,
                        child: DelayedWidget(
                          animation: DelayedAnimations.SLIDE_FROM_RIGHT,
                          child: GestureDetector(
                            onTap: () {},
                            child: JobDetailsPopup(
                              onPopupClose: () {
                                controller.isDetailsPopupVisible.value =
                                false;
                              },
                            ),
                          ),
                        ))
                        : const SizedBox())
                  ],
                ),
              ),
            ));
  }

  Widget jobStatusItem(JobStatus status) {
    return AppSegmentItem(
      text: '${status.label} (${controller.jobModels
          .where((e) => e.status == status)
          .toList().length})',
      icon: status.icon,
    );
  }

  Widget _searchBox() {
    return Stack(
      children: [
        TextField(
          controller: _searchText,
          onChanged: (text) {
            controller.searchItems(text);
          },
          focusNode: _searchFocus,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.orange,
            contentPadding: const EdgeInsets.only(top: 0.0, bottom: 0, left: 8.0),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.secondary_90, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.secondary_90, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.secondary_90, width: 1.0),
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
        ),
        const Positioned(
            right: 10,
            top: 5,
            child: Icon(Icons.search)
        )
      ],
    );
  }

  Widget _customDateRangeModel() => AppCard(
      children: [
        const Text('Custom Date Range', style: AppStyles.headerRegular,),
        const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Text('From: ', style: AppStyles.labelBold,),
                Text(controller.startDate != null ? DateFormat('MMM, dd yyyy').format(controller.startDate!) : "", style: AppStyles.labelRegular,),
              ],
            ),
            Row(
              children: [
                const Text('To: ', style: AppStyles.labelBold,),
                Text(controller.endDate != null ? DateFormat('MMM, dd yyyy').format(controller.endDate!) : "", style: AppStyles.labelRegular,),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16,),
        NZCalendar(
          onDateSelected: (date){
            if (kDebugMode) {
              print('date selected');
            }
          },
          startDate: controller.startDate,
          endDate: controller.endDate,
          selectRange: true,
          onRangeSelected: (start, end) {
              controller.startDate = start;
              controller.endDate = end;
              controller.diffInDays = DateTime.parse(end.toString()).difference(start).inDays;
              controller.update();
          },
        ),
        const SizedBox(height: 32,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${controller.diffInDays} days selected", style: AppStyles.labelBold,),
            Row(
              children: [
                LZTextButton(
                  "Cancel",
                  textColor: AppColors.secondary_20,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    controller.showCustomDateRange.value = false;
                    if(controller.startDate == null && controller.endDate == null) {
                      controller.selectedDuration.value = null;
                      controller.sortByDuration();
                    }
                  },
                ),
                const SizedBox(width: 32,),
                AppButton(
                    label: "Apply",
                    onPressed: () async {
                      controller.sortByCustomRange();
                      controller.showCustomDateRange.value = false;
                    }
                )
              ],
            )
          ],
        )
      ]
  );
}