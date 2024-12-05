import 'package:intl/intl.dart';

class DateTimeUtil {
  static DateTime getFirstDayOfCalendar(DateTime date) {
    DateTime firstDay = _getFirstDayOfMonth(date);
    int difference = firstDay.weekday == 7 ? 0 : firstDay.weekday;
    DateTime startOfCalendar = firstDay.subtract(Duration(days: difference));

    return startOfCalendar;
  }

  static DateTime getLastDayOfCalendar(DateTime date) {
    DateTime lastDay = _getLastDayOfMonth(date);
    int difference = lastDay.weekday == 7 ? 6 : 6 - lastDay.weekday;
    DateTime endOfCalendar = lastDay.add(Duration(days: difference));

    return endOfCalendar
        .add(const Duration(hours: 23, minutes: 59, seconds: 59));
  }

  static DateTime _getFirstDayOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime _getLastDayOfMonth(DateTime date) {
    DateTime nextMonth = DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1));
  }

  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static bool isSameMonth(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month;
  }

  static String calRemainDateTime(String dateTimeStr) {
    DateTime dateTime;
    try {
      dateTime = DateTime.parse(dateTimeStr);
    } catch (e) {
      dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTimeStr);
    }

    final int milliSeconds =
        DateTime.now().millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;
    final double seconds = milliSeconds / 1000;

    if (seconds < 60) {
      return '방금 전';
    }

    final double minutes = seconds / 60;

    if (minutes < 60) {
      return '${minutes.floor()}분 전';
    }

    final double hours = minutes / 60;

    if (hours < 24) {
      return '${hours.floor()}시간 전';
    }

    final double days = hours / 24;

    if (days < 7) {
      return '${days.floor()}일 전';
    }

    final double weeks = days / 7;

    if (weeks < 5) {
      return '${weeks.floor()}주 전';
    }

    final double months = days / 30;

    if (months < 12) {
      return '${months.floor()}개월 전';
    }

    final double years = months / 12;

    return '${years.floor()}년 전';
  }
}
