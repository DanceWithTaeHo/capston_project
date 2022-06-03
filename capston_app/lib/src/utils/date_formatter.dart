import 'package:intl/intl.dart';

class DateFormatter {
  DateFormat todayFormatter = DateFormat('yyyyMMdd');
  DateFormat weekFormatter = DateFormat('yyyyMM');
  DateFormat monthFormatter = DateFormat('yyyyMM');
  static DateTime _today = DateTime.now();
  static DateTime _ago2Hour = _today.subtract(const Duration(hours: 2));
  static DateTime _ago24Hour = _today.subtract(const Duration(hours: 24));
  static DateTime _ago7Day = _today.subtract(const Duration(days: 7));
  static DateTime _ago1Month = _today.subtract(const Duration(days: 30));

  static DateTime get now => _today;
  static String get today => DateFormat('yyyyMMdd').format(_today);
  static String get month => DateFormat('yyyyMM').format(_today);
  static String get ago2Hour => DateFormat('yyyyMMddHms').format(_ago2Hour);
  static String get ago24Hour => DateFormat('yyyyMMddHms').format(_ago24Hour);
  static String get ago7Day => DateFormat('yyyyMMddHms').format(_ago7Day);
  static String get ago1Month => DateFormat('yyyyMMddHms').format(_ago1Month);

  static int get nowTimestamp => _today.microsecondsSinceEpoch;
  static int get ago2HourTimestamp => _ago2Hour.microsecondsSinceEpoch;
  static int get ago24HourTimestamp => _ago24Hour.microsecondsSinceEpoch;
  static int get ago7DayTimestamp => _ago7Day.microsecondsSinceEpoch;
  static int get ago1MonthTimestamp => _ago1Month.microsecondsSinceEpoch;

  static DateTime changeDateTime(int timestamp) {
    return DateTime.fromMicrosecondsSinceEpoch(timestamp);
  }

  static int changeTimestamp(DateTime date) {
    return date.microsecondsSinceEpoch;
  }

  static String yyyyMMddFormat(DateTime time) {
    return DateFormat("yyyyMMdd").format(time);
  }

  static String yyyyMMFormat(DateTime time) {
    return DateFormat("yyyyMM").format(time);
  }

  static String yyyyMMddhmsFormat(DateTime time) {
    return DateFormat("yyyyMMddHms").format(time);
  }
}
