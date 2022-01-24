import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:louzero/common/app_segment_item.dart';
import 'package:louzero/common/app_segmented_control.dart';
import 'package:louzero/common/common.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/get/job_controller.dart';
import 'package:louzero/models/models.dart';
import 'package:louzero/ui/widget/datatable.dart';
import 'package:louzero/ui/widget/widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../app_base_scaffold.dart';
import 'views/jobs_home.dart';

class JobListPage extends StatefulWidget {
  const JobListPage({Key? key}) : super(key: key);

  @override
  _JobListPageState createState() => _JobListPageState();
}
class _JobListPageState extends State<JobListPage> {
  TextEditingController _searchText = TextEditingController();
  String _selectedType = "";
  String _selectedDuration = "";
  List items = [
    {
      "id" : '8519',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Repair",
      "scheduled" : "1642696479",
      "total" : "150.0"
    },
    {
      "id" : '8518',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Repair",
      "scheduled" : "",
      "total" : "0.0"
    },
    {
      "id" : '8517',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Service",
      "scheduled" : "",
      "total" : "150.0"
    },
    {
      "id" : '8516',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Repair",
      "scheduled" : "1642696479",
      "total" : "780.0"
    },
    {
      "id" : '8515',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Pool Opening",
      "scheduled" : "1642696479",
      "total" : "0.0"
    },
    {
      "id" : '8514',
      "name" : "Archwood House",
      "address" : "3486 Archwood Ave., Vancouver, WA 98665",
      "type" : "Spa Opening",
      "scheduled" : "1642696479",
      "total" : "150.0"
    }
  ];
  List tableItems = [];

  @override
  void initState() {
    setState(() {
      tableItems = items;
    });
    super.initState();
  }

  void _searchItems(text) {
    if(text.toString().isNotEmpty) {
      List currentItems = items;
      List updatedItems = currentItems.where((i) {
        final searchText = text.toString().toLowerCase();
        return i['type'].toString().toLowerCase().contains(searchText) ||
            i['name'].toString().toLowerCase().contains(searchText) ||
            i['address'].toString().toLowerCase().contains(searchText);
      }).toList();
      setState(() {
        tableItems = [...updatedItems];
      });
    }
    else{
      setState(() {
        tableItems = items;
      });
    }

  }

  void sortByType() {
    List currentItems = items;
    List updatedItems = currentItems.where((i) => i['type'] == _selectedType).toList();
    setState(() {
      tableItems = [...updatedItems];
    });
  }

  void sortByDuration() {
    List currentItems = items;
    List updatedItems = [];
    DateTime now = DateTime.now();
    if(_selectedDuration == "Yesterday") {
      DateTime prevOfYesterday = now.subtract(Duration(days:2));
      updatedItems = currentItems.where((i) {
        if(i['scheduled'].toString().isEmpty) {
          return false;
        }

        return prevOfYesterday.millisecondsSinceEpoch > int.parse(i['scheduled']) &&
            now.millisecondsSinceEpoch < int.parse(i['scheduled']);
      }).toList();
    }
    else if(_selectedDuration == "Today") {
      DateTime yesterday = now.subtract(Duration(days:1));
      DateTime tomorrow = now.add(Duration(days:1));

      updatedItems = currentItems.where((i) {
        if(i['scheduled'].toString().isEmpty) {
          return false;
        }

        return yesterday.millisecondsSinceEpoch > int.parse(i['scheduled']) &&
            tomorrow.millisecondsSinceEpoch < int.parse(i['scheduled']);
      }).toList();
    }
    else if(_selectedDuration == "Tomorrow") {
      DateTime nexOfTomorrow = now.add(Duration(days:2));
      updatedItems = currentItems.where((i) {
        if(i['scheduled'].toString().isEmpty) {
          return false;
        }

        return now.millisecondsSinceEpoch > int.parse(i['scheduled']) &&
            nexOfTomorrow.millisecondsSinceEpoch < int.parse(i['scheduled']);
      }).toList();
    }
    else if(_selectedDuration == "This Week") {
      DateTime endOfWeek = now.add(Duration(days:8));

      updatedItems = currentItems.where((i) {
        if(i['scheduled'].toString().isEmpty) {
          return false;
        }

        return now.millisecondsSinceEpoch > int.parse(i['scheduled']) &&
            endOfWeek.millisecondsSinceEpoch < int.parse(i['scheduled']);
      }).toList();

    }
    else if(_selectedDuration == "Next Week") {
      DateTime startOfWeek = now.add(Duration(days:7));
      DateTime endOfNextWeek = now.add(Duration(days:15));

      updatedItems = currentItems.where((i) {
        if(i['scheduled'].toString().isEmpty) {
          return false;
        }

        return startOfWeek.millisecondsSinceEpoch > int.parse(i['scheduled']) &&
            endOfNextWeek.millisecondsSinceEpoch < int.parse(i['scheduled']);
      }).toList();
    }

    setState(() {
      tableItems = updatedItems;
    });
  }

  void sortItems(category, isASC) {
    if(category == "Customer") {
      category = "name";
    }
    List currentItems = tableItems;
    currentItems.sort((a, b) {
      return a[category.toString().toLowerCase()].compareTo(b[category.toString().toLowerCase()]);
    });

    setState(() {
      if(isASC) {
        tableItems = currentItems.reversed.toList();
      }
      else{
        tableItems = currentItems;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    print('table items $tableItems');
    return AppBaseScaffold(
      subheader: 'All Jobs (dev in progress)',
      child: Container(
        padding: const EdgeInsets.only(left: 32, right: 32),
        child: Column(
          children: [
            const SizedBox(height: 32,),
            AppSegmentedControl(
              fromMax: true,
              isStretch: true,
              backgroundColor: AppColors.secondary_95,
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
                AppPopMenu(
                    offset: const Offset(0, 40),
                    button: [
                      AppButton(
                        radius: 10,
                        borderColor: AppColors.secondary_90,
                        colorBg: Colors.transparent,
                        colorText: AppColors.secondary_30,
                        label: _selectedType.toString().isNotEmpty ? _selectedType :  "Job Type",
                        isMenu: true,
                      )
                    ],
                    items: [
                      PopMenuItem(
                        label: 'Repair',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedType = 'Repair';
                          });
                          sortByType();
                        },
                      ),
                      PopMenuItem(
                        label: 'Service',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedType = 'Service';
                          });
                          sortByType();
                        },
                      ),
                      PopMenuItem(
                        label: 'Pool Opening',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedType = 'Pool Opening';
                          });
                          sortByType();
                        },
                      ),
                      PopMenuItem(
                        label: 'Spa Opening',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedType = 'Spa Opening';
                          });
                          sortByType();
                        },
                      ),
                    ]
                ),
                const SizedBox(width: 8,),
                AppPopMenu(
                    offset: const Offset(0, 40),
                    button: [
                      AppButton(
                        radius: 10,
                        borderColor: AppColors.secondary_90,
                        colorBg: Colors.transparent,
                        colorText: AppColors.secondary_30,
                        label: _selectedDuration.toString().isNotEmpty ? _selectedDuration : "Duration",
                        isMenu: true,
                      )
                    ],
                    items: [
                      PopMenuItem(
                        label: 'Yesterday',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Yesterday';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'Today',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Today';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'Tomorrow',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Tomorrow';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'This Week',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'This Week';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'Next Week',
                        showIcon: false,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Next Week';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'Not Scheduled',
                        showIcon: false,
                        hasDivider: true,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Not Scheduled';
                          });
                          sortByDuration();
                        },
                      ),
                      PopMenuItem(
                        label: 'Custom Range',
                        showIcon: false,
                        hasDivider: true,
                        onTap: () {
                          setState(() {
                            _selectedDuration = 'Custom Range';
                          });
                          sortByDuration();
                        },
                      ),
                    ]
                ),
                const SizedBox(width: 8,),
                AppButton(
                  radius: 10,
                  borderColor: AppColors.secondary_90,
                  colorBg: Colors.transparent,
                  colorText: AppColors.secondary_30,
                  label: "Reset",
                  onPressed: () {
                    setState(() {
                      tableItems = items;
                      _selectedType = "";
                      _selectedDuration = "";
                      _searchText.text = "";
                    });
                  },
                )
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
            AppDivider(),
            const SizedBox(height: 8,),
            LZDataTable(
              items: tableItems,
              onSortTap: (category, isAsc) {
                sortItems(category, isAsc);
              },
            )
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
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.orange,
            contentPadding: const EdgeInsets.only(top: 0.0, bottom: 0, left: 8.0),
            focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.orange, width: 1.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            border: OutlineInputBorder(
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
}

class DropDownMenu extends StatelessWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      offset: const Offset(0, 40),
      onSelected: (result) { },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 1,
          child: Text('Working a lot harder'),
        ),
      ],
    );
  }

}