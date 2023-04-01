import 'package:intl/intl.dart';

class DateFormatUtils {
  static var weekDay = ['', '一', '二', '三', '四', '五', '六', '日'];

  static String getDateWithFullDateTemplate(
      DateTime startDate, DateTime endDate) {
    return '${DateFormat('yyyy/MM/dd').format(startDate)}'
        '(${weekDay[startDate.weekday]})'
        ' - '
        '${DateFormat('MM/dd').format(endDate)}'
        '(${weekDay[endDate.weekday]})';
  }

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
