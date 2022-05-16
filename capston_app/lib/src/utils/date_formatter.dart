import 'package:intl/intl.dart';

class DateFormatter {
  DateFormat todayFormatter = DateFormat('yyyyMMdd');
  DateFormat weekFormatter = DateFormat('yyyyMM');
  DateFormat monthFormatter = DateFormat('yyyyMM');
  static DateTime _today = DateTime.now();
  static DateTime _ago7Day =
      DateTime.parse((int.parse(DateFormatter.today) - 7).toString());

  static String get today => DateFormat('yyyyMMdd').format(_today);
  static String get month => DateFormat('yyyyMM').format(_today);
  static String get ago7Day => DateFormat('yyyyMMdd').format(_ago7Day);
  static int get todayNum => int.parse(DateFormatter.today);
  static int get ago7DayNum => int.parse(DateFormatter.ago7Day);

  static DateTime changeDateTime(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static String yyyyMMddFormat(DateTime time) {
    return DateFormat("yyyyMMdd").format(time);
  }

  static String yyyyMMFormat(DateTime time) {
    return DateFormat("yyyyMM").format(time);
  }
}
