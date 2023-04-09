import 'package:intl/intl.dart';

class DateFormatUtils {
  static var weekDay = ['', '一', '二', '三', '四', '五', '六', '日'];

  /// yyyy/MM/dd(weekDay) - MM/dd(weekDay)
  static String getDateWithFullDateTemplate(
      DateTime startDate, DateTime endDate) {
    return '${DateFormat('yyyy/MM/dd').format(startDate)}'
        '(${weekDay[startDate.weekday]})'
        ' - '
        '${DateFormat('MM/dd').format(endDate)}'
        '(${weekDay[endDate.weekday]})';
  }

  /// MM/dd - MM/dd
  static String getDateWithDateTemplate(
      DateTime startDate, DateTime endDate) {
    return '${DateFormat('MM/dd').format(startDate)}'
        ' - '
        '${DateFormat('MM/dd').format(endDate)}';
  }

  /// {total days) x天
  static String getTotalDate(DateTime startDate, DateTime endDate) {
    return '${daysBetween(startDate, endDate)}天';
  }

  static int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    var days = (to.difference(from).inHours / 24).round();
    return days > 0 ? days : 1;
  }
}
