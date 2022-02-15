export 'decoration.dart';
import 'package:intl/intl.dart';

DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
DateTime get now => DateTime.now();
DateTime get startDateInWeek {
  return getDate(now.subtract(Duration(days: now.weekday - 1)));
}

DateTime get endDateInWeek {
  return getDate(now.add(Duration(days: DateTime.daysPerWeek - now.weekday)));
}

extension DateTimeEx on DateTime {

  bool get isToday => isSameDate();

  bool get isYesterday {
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (day == yesterday.day && month == yesterday.month && year == yesterday.year) {
      return true;
    }
    return false;
  }

  bool get isTomorrow {
    DateTime yesterday = now.add(const Duration(days: 1));
    if (day == yesterday.day && month == yesterday.month && year == yesterday.year) {
      return true;
    }
    return false;
  }

  bool get isInThisWeek {
    return isBefore(endDateInWeek) && isAfter(startDateInWeek);
  }

  bool get isInNextWeek {
    final startDate = getDate(startDateInWeek.add(const Duration(days: 7)));
    final endDate = getDate(endDateInWeek.add(const Duration(days: 7)));
    return isBefore(endDate) && isAfter(startDate);
  }

  bool isSameDate({DateTime? other}) {
    other ??= DateTime.now();
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

  String get time => DateFormat('hh:mm a').format(this);

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