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
    this.selectedDate
  }) : super(key: key);
  final Function onDateSelected;
  final String? selectedDate;

  @override
  _NZCalendarState createState() => _NZCalendarState();
}

class _NZCalendarState extends State<NZCalendar> {
  late final PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  @override
  void initState() {
    if(widget.selectedDate != null) {
      DateTime selectedDate = DateTime.parse(widget.selectedDate!);
      setState(() {
        _selectedDays.clear();
        _selectedDays.add(selectedDate);
      });
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
      _focusedDay.value = focusedDay;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });
    widget.onDateSelected(selectedDay);
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ValueListenableBuilder<DateTime>(
            valueListenable: _focusedDay,
            builder: (context, value, _) {
              return _CalendarHeader(
                  focusedDay: value,
                  onLeftArrowTap: (){
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  },
                  onRightArrowTap: (){
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
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
            selectedDayPredicate: (day) => _selectedDays.contains(day),
            rangeSelectionMode: _rangeSelectionMode,
            calendarStyle: CalendarStyle(
                isTodayHighlighted: false,
                cellMargin: const EdgeInsets.all(0.0),
                tableBorder: TableBorder.all(color: AppColors.secondary_90),
                outsideDecoration: const BoxDecoration(
                    color: AppColors.secondary_99
                ),
                outsideTextStyle: const TextStyle(color: AppColors.secondary_99),
                selectedDecoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  color: AppColors.primary_1,
                  shape: BoxShape.circle,
                ),
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onCalendarCreated: (controller) => _pageController = controller,
            onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
          ),
        ],
      ),
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
            style: const TextStyle(
                fontWeight: FontWeight.bold,
              color: AppColors.secondary_30
            ),),
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: AppColors.secondary_30),
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