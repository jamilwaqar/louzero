import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:louzero/controller/constant/colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 12, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 60, kToday.day);

class NZCalendar extends StatefulWidget{
  const NZCalendar({
    Key? key,
    required this.onDateSelected,
    this.onRangeSelected,
    this.selectedDate,
    this.selectRange = false,
    this.startDate,
    this.endDate
  }) : super(key: key);
  final Function(DateTime) onDateSelected;
  final Function(DateTime, DateTime)? onRangeSelected;
  final DateTime? selectedDate;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool selectRange;

  @override
  _NZCalendarState createState() => _NZCalendarState();
}

class _NZCalendarState extends State<NZCalendar> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    if(widget.selectedDate != null) {
      setState(() {
        _selectedDays.clear();
        _selectedDays.add(widget.selectedDate!);
      });
    }
    if(widget.selectRange) {
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    }
    if(widget.startDate != null && widget.endDate != null) {
      _rangeStart = widget.startDate;
      _rangeEnd = widget.endDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    _focusedDay.dispose();
    super.dispose();
  }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.clear();
        _selectedDays.add(selectedDay);
      }
      _rangeStart = null;
      _rangeEnd = null;
      _focusedDay.value = focusedDay;
      _rangeSelectionMode = widget.selectRange ? RangeSelectionMode.toggledOn : RangeSelectionMode.toggledOff;
    });
    widget.onDateSelected(selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
                focusedDay: value,
                onLeftArrowTap: (){
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                },
                onRightArrowTap: (){
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
            );
          },
        ),
        _DaysOfWeek(),
        TableCalendar<Event>(
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: _focusedDay.value,
          headerVisible: false,
          daysOfWeekVisible: false,
          calendarFormat: _calendarFormat,
          rangeStartDay: _rangeStart,
          rangeEndDay: _rangeEnd,
          selectedDayPredicate: (day) => _selectedDays.contains(day),
          rangeSelectionMode: _rangeSelectionMode,
          onRangeSelected: (start, end, focusedDay) {
            if(widget.selectRange) {
              setState(() {
                _focusedDay.value = focusedDay;
                _rangeStart = start;
                _rangeEnd = end;
                _rangeSelectionMode = RangeSelectionMode.toggledOn;
              });

              if(_rangeStart != null && _rangeEnd != null) {
                widget.onRangeSelected!(_rangeStart!, _rangeEnd!);
              }
            }
            else{
              print('ddd');
            }
          },
          calendarStyle: CalendarStyle(
              isTodayHighlighted: false,
              cellMargin: const EdgeInsets.all(0.0),
              tableBorder: TableBorder.all(color: AppColors.secondary_90),
              outsideDecoration: const BoxDecoration(
                  color: AppColors.secondary_99
              ),
              outsideTextStyle: const TextStyle(color: AppColors.secondary_99),
              defaultTextStyle: AppStyles.labelRegular,
              weekendTextStyle: AppStyles.labelRegular,
              selectedDecoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 5),
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFFEC5B2A), Color(0xFFEB794B)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
          ),
          onDaySelected: _onDaySelected,
          onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
        ),
      ],
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

class _DaysOfWeek extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"].map((e) => Expanded(
          child: Text(e,
            textAlign: TextAlign.center,
            style: AppStyles.labelBold
          ),
        )).toList(),
      ),
    );
  }

}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, size: 25.0),
            onPressed: onLeftArrowTap,
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              headerText,
              textAlign: TextAlign.center,
              style: AppStyles.headerRegular,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward, size: 25.0),
            onPressed: onRightArrowTap,
          ),
        ],
      ),
    );
  }
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}