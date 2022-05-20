class TimeFormatter {
  var todayTimestamp = DateTime.now().millisecondsSinceEpoch;

  static DateTime today(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }
}
