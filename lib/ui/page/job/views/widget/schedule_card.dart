import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:louzero/common/app_pop_menu.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:louzero/controller/constant/common.dart';
import 'package:louzero/ui/page/job/views/widget/add_schedule_dialog.dart';
import 'package:louzero/ui/widget/switch_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class ScheduleCard extends StatefulWidget {
  const ScheduleCard({Key? key, required this.schedule}) : super(key: key);

  final Map schedule;

  @override
  _ScheduleCard createState() => _ScheduleCard();
}

class _ScheduleCard extends State<ScheduleCard> {
  bool isComplete = false;
  bool showScheduleDialog = false;

  @override
  void initState() {
    if (widget.schedule['isCompleted']) {
      setState(() {
        isComplete = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime parseDate = DateTime.parse(widget.schedule['date']);
    final monthName = DateFormat.MMM().format(parseDate);
    final day = DateFormat.d().format(parseDate);

    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 230,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.secondary_40,
                      borderRadius: Common.border_24.copyWith(
                        topRight: const Radius.circular(0),
                        bottomRight: const Radius.circular(0),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(monthName.toUpperCase(),
                          style: const TextStyle(
                            fontFamily: 'Lato',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                            color: Colors.white,
                          )),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(day,
                          style: const TextStyle(
                              fontFamily: 'Lato',
                              fontSize: 45,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              color: Colors.white))
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                      height: 230,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(
                          color: AppColors.secondary_100,
                          borderRadius: Common.border_24.copyWith(
                            topLeft: const Radius.circular(0),
                            bottomLeft: const Radius.circular(0),
                          )),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${widget.schedule['startTime']} - ${widget.schedule['endTime']}",
                                        style: const TextStyle(
                                          fontFamily: 'Lato',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.1,
                                        )),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(widget.schedule['note'],
                                              style: const TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 16,
                                              )),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Align(
                                      alignment: Alignment.topRight,
                                      child: AppPopMenu(
                                        button: const [
                                          SizedBox(
                                            child: Icon(Icons.more_vert,
                                                color: AppColors.secondary_60),
                                          ),
                                        ],
                                        items: [
                                          PopMenuItem(
                                            label: 'Edit Appointment',
                                            icon: MdiIcons.pencil,
                                            onTap: () {
                                              setState(() {
                                                showScheduleDialog = true;
                                              });
                                            },
                                          ),
                                          PopMenuItem(
                                            label: 'Manage Notes',
                                            icon: MdiIcons.fileDocumentOutline,
                                            onTap: () {},
                                          ),
                                          PopMenuItem(
                                            label: 'Remove',
                                            icon: MdiIcons.trashCanOutline,
                                            onTap: () {},
                                          ),
                                        ],
                                      )),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            color: AppColors.secondary_80,
                            thickness: 1,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 20.0,
                                    backgroundImage: NetworkImage(
                                        widget.schedule['personnel']['image']),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(widget.schedule['personnel']['name'],
                                      style: const TextStyle(
                                        fontFamily: 'Lato',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.1,
                                      )),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: AppColors.secondary_95,
                                    radius: 12,
                                    child: IconButton(
                                      iconSize: 15,
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(MdiIcons.pencil),
                                      color: AppColors.secondary_30,
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                              NZSwitch(
                                isOn: isComplete,
                                label: "Complete",
                                onChanged: (bool value) {
                                  setState(() {
                                    isComplete = value;
                                  });
                                },
                              )
                            ],
                          )
                        ],
                      )))
            ])),
        const SizedBox(
          height: 8,
        ),
        showScheduleDialog
            ? AddScheduleDialog(
                schedule: widget.schedule,
                onClose: () {
                  setState(() {
                    showScheduleDialog = false;
                  });
                },
              )
            : const SizedBox(),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
