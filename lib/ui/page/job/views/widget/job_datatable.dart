import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:louzero/common/app_chip.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/bindings/job_binding.dart';
import 'package:louzero/models/job_models.dart';
import 'package:louzero/ui/page/job/controllers/line_item_controller.dart';
import 'package:louzero/ui/page/job/views/jobs_home.dart';
import 'package:get/get.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/ui/page/job/views/widget/job_details_popup.dart';

class JobDataTable extends StatefulWidget{
  const JobDataTable({
    Key? key,
    required this.items,
    required this.onSortTap,
    required this.models,
    this.onMoreButtonTap
  }) : super(key: key);

  final List items;
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
      child: Stack(
        children: [
          Column(
            children: [
              _tableHeader(),
              const SizedBox(height: 20,),
              SizedBox(
                child: Column(
                  children: [
                    for (var rowItem in widget.items)
                      _tableRow(rowItem)
                  ],
                ),
              )
            ],
          ),
        ],
      )
    );
  }

  Widget _tableHeader() {
    return Container(
        child: Row(
            children: [
              const SizedBox(width: 15,),
              Expanded(
                  flex: 1,
                  child: FlexRow(
                    flex: const [2, 7, 4, 3, 2, 1],
                    children: [
                      _headerButtons('ID'),
                      _headerButtons('Customer'),
                      _headerButtons('Type'),
                      _headerButtons('Scheduled'),
                      _headerButtons('Total'),
                      _headerButtons(''),
                    ],
                  ))
            ]
        )
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

  Widget _tableRow(item) {
    final String color = "0xFF${colors[item['type']]}";
    String ds = "";
    if(item['scheduled'].toString().isNotEmpty) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(item['scheduled']) * 1000);
      ds = DateFormat('MMM, dd yyyy').format(date);
    }

    return GestureDetector(
      onTap: (){
        Get.find<JobController>().jobModel = widget.models[0];
        Get.put(LineItemController());
        Get.to(() => JobsHome());
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
                      flex: const [2, 7, 4, 3, 2, 1],
                      children: [
                        Text("#${item['id']}", style: AppStyles.labelRegular,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['customer'], style: AppStyles.labelBold,),
                            const SizedBox(height: 8,),
                            Text(item['address'], style: const TextStyle(
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
                                text: item['type'],
                                color: Color(int.parse(color))
                            ),
                          ],
                        ),
                        Text(ds, style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                        )),
                        Text("\$${item['total']}", style: const TextStyle(
                          fontFamily: 'Lato',
                          fontSize: 14,
                        )),
                        AppIconButton(
                            icon: Icons.more_vert,
                            iconSize: 25,
                            colorBg: Colors.transparent,
                            onTap: () {
                              Get.find<JobController>().jobModel = widget.models[0];
                              widget.onMoreButtonTap!();
                            }
                        ),
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