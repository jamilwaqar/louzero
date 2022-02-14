import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/base_controller.dart';
import 'package:louzero/models/customer_models.dart';
import 'package:louzero/models/job_models.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/job_controller.dart';

class JobDataTable extends StatefulWidget{
  const JobDataTable({
    Key? key,
    required this.onSortTap,
    required this.models,
    this.onMoreButtonTap
  }) : super(key: key);

  final List<JobModel> models;
  final Function onSortTap;
  final Function? onMoreButtonTap;

  @override
  _JobDataTable createState() => _JobDataTable();
}

class _JobDataTable extends State<JobDataTable> {
  bool isASC = true;
  String category = "id";
  final colors = {
    "Repair" : "1864CD",
    "Service" : "C52B54",
    "Pool Opening" : "C52B54",
    "Spa Opening" : "C52B54"
  };
  bool isPopupVisible = false;

  void sortItems() {
    widget.onSortTap(category, isASC);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          _tableHeader(),
          const SizedBox(height: 20,),
          Flexible(
            flex: 1,
            child: ListView.builder(
              itemCount: widget.models.length,
                itemBuilder: (BuildContext context,int index){
                  return  _tableRow(widget.models[index]);
                }
            ),
          )
        ],
      )
    );
  }

  Widget _tableHeader() {
    return Row(
        children: [
          const SizedBox(width: 15,),
          Expanded(
              flex: 1,
              child: FlexRow(
                flex: const [2, 7, 4, 3, 2],
                children: [
                  _headerButtons('ID'),
                  _headerButtons('Customer'),
                  _headerButtons('Type'),
                  _headerButtons('Scheduled'),
                  _headerButtons('Total'),
                ],
              ))
        ]
    );
  }

  Widget _headerButtons(text) {
    bool isActive = category.toString().toLowerCase() == text.toString().toLowerCase();


    return GestureDetector(
      onTap: () {
        setState(() {
          category = text;
          isASC = !isASC;
        });

        sortItems();
      },
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(text.toString(), style: isActive ? const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              color: AppColors.secondary_20,
              fontWeight: FontWeight.w700,
            ) : const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              color: AppColors.secondary_40,
              fontWeight: FontWeight.w700,
            )),
            const SizedBox(width: 4,),
            text.toString().isNotEmpty && isActive
                ?
            Container(
              margin: const EdgeInsets.only(top: 3),
              child:  const Icon(FontAwesomeIcons.sort, size: 13,),
            )
                : const SizedBox()


          ],
        ),
      ),
    );
  }

  Widget _tableRow(JobModel item) {
    final String color = "0xFF${colors[item.jobType]?? "C52B54"}";
    CustomerModel customerModel =
    Get.find<BaseController>().customerModelById(item.customerId!)!;
    String ds = "";
    if(item.scheduledAt != null) {
      ds = DateFormat('MMM, dd yyyy').format(item.scheduledAt!);
    }

    return GestureDetector(
      onTap: (){
        Get.put(JobController()).jobModel = widget.models[0];
        widget.onMoreButtonTap!();
      },
      child: Container(
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Row(
            children: [
              Container(
                width: 5,
                height: 95,
                decoration: BoxDecoration(
                    color: Color(int.parse(color)),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0)
                    )
                ),
              ),
              const SizedBox(width: 10,),
              Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: FlexRow(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      flex: const [2, 7, 4, 3, 2],
                      children: [
                        Text("#${item.jobId}", style: AppStyles.labelRegular,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(customerModel.companyName, style: AppStyles.labelBold,),
                            const SizedBox(height: 8,),
                            Text(customerModel.serviceAddress.fullAddress, style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 14,
                            ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppChip(
                                text: item.jobType,
                                color: Color(int.parse(color))
                            ),
                          ],
                        ),
                        Text(ds, style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                        )),
                        Text("\$${item.totalCost}", style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                        )),
                        // AppIconButton(
                        //     icon: Icons.more_vert,
                        //     iconSize: 25,
                        //     colorBg: Colors.transparent,
                        //     onTap: () {
                        //       Get.find<JobController>().jobModel = widget.models[0];
                        //       widget.onMoreButtonTap!();
                        //     }
                        // ),
                      ],
                    ),
                  )
              )
            ],
          )
      ),
    );
  }
}