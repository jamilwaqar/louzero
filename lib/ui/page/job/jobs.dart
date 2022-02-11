import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/ui/page/job/views/widget/job_datatable.dart';
import 'package:louzero/ui/page/job/views/widget/job_details_popup.dart';
import 'package:louzero/ui/widget/calendar.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../app_base_scaffold.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({Key? key}) : super(key: key);

  @override
  _JobListPageState createState() => _JobListPageState();
}

class _JobListPageState extends State<JobListPage> {
  @override
  void initState() {
    setState(() {
      tableItems = items;
    });
    _searchFocus.addListener(() {
      print(_searchFocus.hasFocus);
      if(_searchFocus.hasFocus) {
        _hideModal();
      }
    });
    super.initState();
  }

  final TextEditingController _searchText = TextEditingController();
  final FocusNode _searchFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return AppBaseScaffold(
      subheader: 'All Jobs',
      onBodyTap: () {
        _hideModal();
      },
      onAppbarVisibilityChange: (isVisible) {
        setState(() {
          _popModalHeight = isVisible ? MediaQuery.of(context).size.height - 220 : MediaQuery.of(context).size.height - 40;
        });
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Column(
                children: [
                  const SizedBox(height: 32,),
                  AppSegmentedControl(
                    fromMax: true,
                    isStretch: true,
                    backgroundColor: AppColors.secondary_95,
                    onTap: () {
                      _hideModal();
                    },
                    children: const {
                      1: AppSegmentItem(
                        text: 'Estimate (99)',
                        icon: MdiIcons.calculator,
                      ),
                      2: AppSegmentItem(
                        text: 'Booked (97)',
                        icon: MdiIcons.calendar,
                      ),
                      3: AppSegmentItem(
                        text: 'Invoiced',
                        icon: MdiIcons.currencyUsd,
                      ),
                      4: AppSegmentItem(
                        text: 'Canceled',
                        icon: MdiIcons.cancel,
                      ),
                    },
                    onValueChanged: (int value) {
                      print(value);
                    },
                  ),
                  const SizedBox(height: 16,),
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        height: 35,
                        child:  _searchBox(),
                      ),
                      const SizedBox(width: 16,),
                      AppSimpleDropDown(
                          label: "Job Type",
                          onSelected: (value) {
                            setState(() {
                              _selectedType = value;
                            });
                            sortByType();
                          },
                          onTap: () {
                            _hideModal();
                          },
                          items: const ['Repair', 'Service', 'Pool Opening', 'Spa Opening']
                      ),
                      const SizedBox(width: 8,),
                      AppSimpleDropDown(
                          label: "Duration",
                          backgroundColor: Colors.white,
                          onClear: () {
                            setState(() {
                              showCustomDateRange = false;
                              _selectedDuration = "";
                              _endDate = null;
                              _startDate = null;
                              diffInDays = 0;
                            });
                          },
                          onTap: () {
                            _hideModal();
                          },
                          onSelected: (value) {
                            setState(() {
                              _selectedDuration = value;
                              showCustomDateRange = false;
                            });
                            sortByDuration();
                          },
                          dividerPosition: const [4, 5],
                          items: const ['Yesterday', 'Today', 'Tomorrow', 'This Week', 'Next Week', 'Custom Range']
                      ),
                    ],
                  ),
                  const SizedBox(height: 24,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Text('Booked Jobs ', style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary_20,
                            )),
                            Text('(97)', style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary_50,
                            ),)
                          ],
                        ),
                        Row(
                          children: const [
                            Text('Total: ', style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary_20,
                            )),
                            Text('\$78,302.00', style: TextStyle(
                              fontFamily: 'Barlow',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondary_50,
                            ))
                          ],
                        ),
                      ]
                  ),
                  const AppDivider(),
                  const SizedBox(height: 8,),
                  Flexible(flex: 1,
                      child: JobDataTable(
                          items: tableItems, //replace items with jobmodels from controller
                          models: Get.find<JobController>().jobModels, //this is temporary will be removed later
                          onSortTap: (category, isAsc) {
                            sortItems(category, isAsc);
                          },
                          onMoreButtonTap: () {
                            setState(() {
                              isDetailsPopupVisible = true;
                            });
                          }
                      )
                  ),
                  const SizedBox(height: 32,)
                ],
              ),
            ),

            showCustomDateRange ?
            Positioned(
                right: 0,
                top: 140,
                width: MediaQuery.of(context).size.width,
                child: DelayedWidget(
                  animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
                  child: _customDateRangeModel(),
                )
            )
                :
            const SizedBox(),

            isDetailsPopupVisible ?
            Positioned(
                height: _popModalHeight != 0 ? _popModalHeight : MediaQuery.of(context).size.height - 220,
                width: 370,
                right: 20,
                top: 20,
                child: DelayedWidget(
                  animation: DelayedAnimations.SLIDE_FROM_RIGHT,
                  child: GestureDetector(
                    onTap: () {
                    },
                    child: JobDetailsPopup(
                      onPopupClose: () {
                        setState(() {
                          isDetailsPopupVisible = false;
                        });
                      },
                    ),
                  ),
                )
            )
                :
            const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    return Stack(
      children: [
        TextField(
          controller: _searchText,
          onChanged: (text) {
            _searchItems(text);
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
                Text(_startDate != null ? DateFormat('MMM, dd yyyy').format(_startDate!) : "", style: AppStyles.labelRegular,),
              ],
            ),
            Row(
              children: [
                const Text('To: ', style: AppStyles.labelBold,),
                Text(_endDate != null ? DateFormat('MMM, dd yyyy').format(_endDate!) : "", style: AppStyles.labelRegular,),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16,),
        NZCalendar(
          onDateSelected: (date){
            print('date selected');
          },
          startDate: _startDate,
          endDate: _endDate,
          selectRange: true,
          onRangeSelected: (start, end) {
            setState(() {
              _startDate = start;
              _endDate = end;
            });
            diffInDays = DateTime.parse(end.toString()).difference(start).inDays;
          },
        ),
        const SizedBox(height: 32,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$diffInDays days selected", style: AppStyles.labelBold,),
            Row(
              children: [
                LZTextButton(
                  "Cancel",
                  textColor: AppColors.secondary_20,
                  fontWeight: FontWeight.w500,
                  onPressed: () {
                    setState(() {
                      showCustomDateRange = false;
                      if(_startDate == null && _endDate == null) {
                        _selectedDuration = "";
                        sortByDuration();
                      }
                    });
                    print(_selectedDuration);
                  },
                ),
                const SizedBox(width: 32,),
                AppButton(
                    label: "Apply",
                    onPressed: () async {
                      sortByCustomRange();
                      setState(() {
                        showCustomDateRange = false;
                      });
                    }
                )
              ],
            )
          ],
        )
      ]
  );
}