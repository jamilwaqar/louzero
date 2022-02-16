import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/utility/flex_row.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/enum/enum_ex.dart';
import 'package:louzero/controller/extension/extensions.dart';
import 'package:louzero/controller/get/auth_controller.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/controller/get/customer_controller.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/customer/customer.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/controllers/schedule_controller.dart';
import 'package:louzero/ui/page/job/views/jobs_home.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JobDetailsPopup extends GetWidget<JobController> {
  JobDetailsPopup({required this.onPopupClose, Key? key}) : super(key: key);
  late final JobModel model = controller.jobModel!;
  final Function onPopupClose;
  final colors = {
    "Repair" : "1864CD",
    "Service" : "C52B54",
    "Consulting" : "C52B54",
    "Spa Opening" : "C52B54"
  };
  late final CustomerModel customerModel =
  Get.find<BaseController>().customerModelById(model.customerId!)!;

  @override
  Widget build(BuildContext context) {
    int statusColor = 0xFF4087E8;
    if(colors[model.jobType] != null) {
      statusColor = int.parse("0xFF${colors[model.jobType]}");
    }

    return Container(
        decoration: BoxDecoration(
          color: AppColors.secondary_100,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const[
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            )
          ],
        ),
        width: 370.0,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color(statusColor),
                  ),
                  child: Text(model.jobType,  style: const TextStyle(
                    fontFamily: 'Lato',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, right: 16),
                  child: AppIconButton(
                    onTap: () {
                      onPopupClose();
                    },
                  ),
                )
              ],
            ),
            Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 80,
                            child:  Text('Job ID:', style: AppStyles.labelBold,),
                          ),
                          Text("#${model.jobId}", style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF008484),
                          ),)
                        ],
                      ),
                      const SizedBox(height: 8,),
                      FlexRow(
                        flex: const [1, 1],
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                child:  Text('Status:', style: AppStyles.labelBold),
                              ),
                              Text(model.status.label, style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF008484),
                              ),)
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 80,
                                child:  Text('Total:', style: AppStyles.labelBold),
                              ),
                              Text(model.totalCost.toStringAsFixed(2), style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF008484),
                              ),)
                            ],
                          )
                        ],
                      ),
                      const AppDivider(),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(customerModel.companyName, style: AppStyles.headerRegular,),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(MdiIcons.mapMarker,  size: 20, color: Color(0xFF7CA0E7),),
                          const SizedBox(width: 8,),
                          Expanded(child: Text(customerModel.serviceAddress.fullAddress, textAlign: TextAlign.left, style: AppStyles.labelRegular,))
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(MdiIcons.calendar, size: 20, color: Color(0xFF7CA0E7)),
                          const SizedBox(width: 8,),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Appointments',
                                textAlign: TextAlign.left,
                                style: AppStyles.labelBold,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              GetBuilder<JobController>(
                                builder: (controller) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    itemBuilder: (_, index) {
                                      ScheduleModel model = controller.scheduleModels[index];
                                      return FlexRow(
                                        children: [
                                          Text(
                                            model.start.simpleDate,
                                            style: AppStyles.labelRegular,
                                          ),
                                          Text(
                                            model.startEndTime,
                                            style: AppStyles.labelRegular,
                                          )
                                        ],
                                      );
                                    },
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.scheduleModels.length,
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(MdiIcons.briefcase, size: 20, color: Color(0xFF7CA0E7)),
                          const SizedBox(width: 8,),
                          Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Job Description', style: AppStyles.labelBold,),
                                  const SizedBox(height: 8,),
                                  Text(model.description, style: AppStyles.labelRegular,),
                                  const SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      const Text('Last updated ', style: AppStyles.labelRegular,),
                                      Text(controller.jobModel!.updatedAt.simpleDate, style: AppStyles.labelBold,)
                                    ],
                                  ),
                                  Text('By ${Get.find<AuthController>().user.fullName}', style: AppStyles.labelRegular,)
                                ],
                              )
                          )
                        ],
                      ),
                      const SizedBox(height: 32,),
                      AppButton(
                        width: 300,
                        borderColor: AppColors.secondary_95,
                        colorBg: AppColors.secondary_95,
                        colorText: AppColors.secondary_20,
                        icon: MdiIcons.plusCircle,
                        colorIcon: AppColors.orange,
                        label: 'Add Appointment',
                        onPressed: (){
                          Get.put(JobController()).jobModel = model;
                          Get.put(LineItemController());
                          Get.put(ScheduleController());
                          Get.to(() => JobsHome());
                          onPopupClose();
                        },
                      ),
                      const SizedBox(height: 8,),
                      AppButton(
                        width: 300,
                        borderColor: AppColors.secondary_95,
                        colorBg: AppColors.secondary_95,
                        colorText: AppColors.secondary_20,
                        icon: MdiIcons.arrowTopRight,
                        colorIcon: AppColors.orange,
                        label: 'View Job Profile',
                        onPressed: (){
                          Get.put(JobController()).jobModel = model;
                          Get.put(LineItemController());
                          Get.put(ScheduleController());
                          Get.to(() => JobsHome());
                          onPopupClose();
                        },
                      ),
                      const SizedBox(height: 8,),
                      AppButton(
                        width: 300,
                        borderColor: AppColors.secondary_95,
                        colorBg: AppColors.secondary_95,
                        colorText: AppColors.secondary_20,
                        icon: MdiIcons.arrowTopRight,
                        colorIcon: AppColors.orange,
                        label: 'View Customer Profile',
                        onPressed: (){
                          Get.put(CustomerController()).customerModel = customerModel;
                          Get.to(() => const CustomerProfilePage());
                          onPopupClose();
                        },
                      ),
                      const Spacer(),
                      Buttons.appBar(
                        'Job Status: ${model.status.label}',
                        icon: model.status.icon,
                      )
                    ],
                  ),
                )
            )
          ],
        )
    );
  }

}