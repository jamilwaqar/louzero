import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_add_button.dart';
import 'package:louzero/common/app_button.dart';
import 'package:louzero/common/app_divider.dart';
import 'package:louzero/common/app_icon_button.dart';
import 'package:louzero/common/utility/flex_row.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class JobDetailsPopup extends GetWidget<JobController>{
  JobDetailsPopup({required this.onPopupClose, Key? key}) : super(key: key);
  final Function onPopupClose;
  final colors = {
    "Repair" : "1864CD",
    "Service" : "C52B54",
    "Pool Opening" : "C52B54",
    "Spa Opening" : "C52B54"
  };


  @override
  Widget build(BuildContext context) {
    final currentJob = controller.jobModel;
    int statusColor = 0xFF4087E8;
    if(currentJob?.jobType != null && colors[currentJob?.jobType] != null) {
      statusColor = int.parse("0xFF${colors[currentJob?.jobType]}");
    }

    return Container(
        decoration: BoxDecoration(
          color: AppColors.secondary_100,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Color(statusColor),
                  ),
                  child: Text(currentJob?.jobType ?? "",  style: TextStyle(
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
                          Text("#${currentJob?.jobId ?? ""}", style: const TextStyle(
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
                              Text(currentJob?.status ?? "", style: const TextStyle(
                                fontFamily: 'Lato',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF008484),
                              ),)
                            ],
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 80,
                                child:  Text('Total:', style: AppStyles.labelBold),
                              ),
                              Text("0", style: TextStyle(
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
                        child: Text("DDDDDD", style: AppStyles.headerRegular,),
                      ),
                      const SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(MdiIcons.mapMarker,  size: 20, color: Color(0xFF7CA0E7),),
                          const SizedBox(width: 8,),
                          Expanded(child: Text('3486 Archwood Ave.,  Vancouver, WA 98665', textAlign: TextAlign.left, style: AppStyles.labelRegular,))
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
                                  Text('Appintments', textAlign: TextAlign.left, style: AppStyles.labelBold,),
                                  const SizedBox(height: 8,),
                                  FlexRow(
                                    children: [
                                      Text('Oct 12, 2021', style: AppStyles.labelRegular,),
                                      Text('Any Time', style: AppStyles.labelRegular,)
                                    ],
                                  ),
                                  const SizedBox(height: 8,),
                                  FlexRow(
                                    children: [
                                      Text('Oct 12, 2021', style: AppStyles.labelRegular,),
                                      Text('Any Time', style: AppStyles.labelRegular,)
                                    ],
                                  )
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
                                  Text('Job Description', style: AppStyles.labelBold,),
                                  const SizedBox(height: 8,),
                                  Text('Need to fix something important at this job. It’s pretty complex so be prepared for that complexity. ', style: AppStyles.labelRegular,),
                                  const SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      Text('Last updated ', style: AppStyles.labelRegular,),
                                      Text('October 7, 2021', style: AppStyles.labelBold,)
                                    ],
                                  ),
                                  Text('By Alan Whitaker', style: AppStyles.labelRegular,)
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
                        onPressed: (){},
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
                        onPressed: (){},
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
                        onPressed: (){},
                      ),
                      const Spacer(),
                      Buttons.appBar(
                        'Job Status: Repair',
                        icon: MdiIcons.calculator,
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