export 'decoration.dart';
import 'package:intl/intl.dart';

extension DateTimeEx on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year &&
        month == other.month &&
        day == other.day;
  }

  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  bool canStartRun() {
    int minute = difference(DateTime.now()).inMinutes;
    return minute >= 0 && minute < 30;
  }

  String get messageSeparatorDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(year, month, day);
    if(aDate == today) {
      return 'Today';
    } else if(aDate == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('EEEE, MMMM d, y').format(this);
    }
  }

  get fullDate => DateFormat('EEEE, MMMM d, hh:mm a').format(this);

  get simpleDate => DateFormat('MMMM d, y').format(this);

  get weekDay => DateFormat('EEEE').format(this);

  String inDayHour({DateTime? other}) {
    other ??= DateTime.now();
    int day = difference(other).inDays;
    int hour = difference(other).inHours;
    int minute = difference(other).inMinutes;
    hour -= day * 24;
    minute -= day * 24 * 60 - hour * 60;

    String dayStr = day > 1 ? '$day days ' : day == 1 ?'$day day ' : '';
    String hourStr = hour > 1 ? '$hour hours ' : hour == 1 ?'$hour hour ' : '';
    String minuteStr = hour >= 1 ? '' : minute > 10 ? '$minute minutes' : 'Now';
    return 'in $dayStr$hourStr$minuteStr';
  }


}