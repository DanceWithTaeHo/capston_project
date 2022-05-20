import 'package:capston_app/src/models/emotion_log.dart';
import 'package:capston_app/src/models/pose_log.dart';
import 'package:capston_app/src/utils/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  static List<Map<String, dynamic>> todayEmotionRatios = [];
  static Map<String, double> todayEmotionRatio = {};
  static List<Map<String, dynamic>> weekEmotionRatios = [];
  static Map<String, double> weekEmotionRatio = {};
  static List<Map<String, dynamic>> monthEmotionRatios = [];
  static Map<String, double> monthEmotionRatio = {};

  static List<EmotionLog> todayEmotionLogs = [];
  static List<EmotionLog> weekEmotionLogs = [];
  static List<EmotionLog> monthEmotionLogs = [];
  static List<PoseLog> todayPoseLogs = [];
  static List<PoseLog> weekPoseLogs = [];
  static List<PoseLog> monthPoseLogs = [];

  static Future<void> init() async {
    await _readData('emotion');
    await _readData('pose');
    setEmotionRatio('today');
    setEmotionRatio('week');
    setEmotionRatio('month');
    print(todayEmotionRatio);
    print(weekEmotionRatio);
    print(monthEmotionRatio);
  }

  static void setEmotionRatio(String kind) {
    late var emotionLogs;
    late var emotionRatios;
    int second = 0;
    Duration duration;
    double happyRatio = 0;
    double sadRatio = 0;
    int i = 0;
    double percentage = 100;

    if (kind == 'today') {
      emotionLogs = todayEmotionLogs.reversed;
      second = 86400;
    } else if (kind == 'week') {
      emotionLogs = weekEmotionLogs.reversed;
      second = 604800;
    } else if (kind == 'month') {
      emotionLogs = monthEmotionLogs.reversed;
      second = 2592000;
    }

    for (EmotionLog emotionLog in emotionLogs) {
      Map<String, dynamic> emotionDic = {};
      double ratio = 0;
      // 먼저 현재 시간과 로그의 시간 차를 구한다.
      duration = DateFormatter.now
          .difference(DateFormatter.changeDateTime(emotionLog.time!));

      if (i == emotionLogs.length - 1) {
        // 가장 오래된 로그라면
        ratio = double.parse(percentage.toStringAsFixed(2));
      } else {
        // 전체 24시간 중 시간 차의 비중을 구한다.
        ratio = double.parse(
            ((duration.inSeconds / second) * 100).toStringAsFixed(2));
      }

      emotionDic['emotion'] = emotionLog.emotion;
      emotionDic['ratio'] = ratio;

      if (kind == 'today') {
        todayEmotionRatios.add(emotionDic);
        emotionRatios = todayEmotionRatios;
      } else if (kind == 'week') {
        weekEmotionRatios.add(emotionDic);
        emotionRatios = weekEmotionRatios;
      } else if (kind == 'month') {
        monthEmotionRatios.add(emotionDic);
        emotionRatios = monthEmotionRatios;
      }

      percentage -= ratio;
      i++;
    }

    for (var emotionRatio in emotionRatios) {
      if (emotionRatio['emotion'] == 'happy') {
        happyRatio += emotionRatio['ratio'];
        happyRatio = double.parse(happyRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'sad') {
        sadRatio += emotionRatio['ratio'];
        sadRatio = double.parse(sadRatio.toStringAsFixed(2));
      }
    }

    if (kind == 'today') {
      todayEmotionRatio['happy'] = happyRatio;
      todayEmotionRatio['sad'] = sadRatio;
    } else if (kind == 'week') {
      weekEmotionRatio['happy'] = happyRatio;
      weekEmotionRatio['sad'] = sadRatio;
    } else if (kind == 'month') {
      monthEmotionRatio['happy'] = happyRatio;
      monthEmotionRatio['sad'] = sadRatio;
    }
  }

  static void setWeekEmotionRatio() {
    var emotionLogs = weekEmotionLogs.reversed;
    Duration duration;

    double happyRatio = 0;
    double sadRatio = 0;
    int i = 0;
    double percentage = 100;
    for (EmotionLog emotionLog in emotionLogs) {
      Map<String, dynamic> emotionDic = {};
      double ratio = 0;
      // 먼저 현재 시간과 로그의 시간 차를 구한다.
      duration = DateFormatter.now
          .difference(DateFormatter.changeDateTime(emotionLog.time!));

      if (i == emotionLogs.length - 1) {
        // 가장 오래된 로그라면
        ratio = percentage;
      } else {
        // 전체 24시간 중 시간 차의 비중을 구한다.
        ratio = double.parse(
            ((duration.inSeconds / 604800) * 100).toStringAsFixed(2));
      }

      emotionDic['emotion'] = emotionLog.emotion;
      emotionDic['ratio'] = ratio;
      weekEmotionRatios.add(emotionDic);
      percentage -= ratio;

      i++;
    }

    for (var emotionRatio in todayEmotionRatios) {
      if (emotionRatio['emotion'] == 'happy')
        happyRatio += emotionRatio['ratio'];
      else if (emotionRatio['emotion'] == 'sad')
        sadRatio += emotionRatio['ratio'];
    }
    weekEmotionRatio['happy'] = happyRatio;
    weekEmotionRatio['sad'] = sadRatio;
  }

  static void setTodayEmotionRatio() {
    var emotionLogs = todayEmotionLogs.reversed;
    Duration duration;

    double happyRatio = 0;
    double sadRatio = 0;
    int i = 0;
    double percentage = 100;
    for (EmotionLog emotionLog in emotionLogs) {
      Map<String, dynamic> emotionDic = {};
      double ratio = 0;
      // 먼저 현재 시간과 로그의 시간 차를 구한다.
      duration = DateFormatter.now
          .difference(DateFormatter.changeDateTime(emotionLog.time!));

      if (i == emotionLogs.length - 1) {
        // 가장 오래된 로그라면
        ratio = percentage;
      } else {
        // 전체 24시간 중 시간 차의 비중을 구한다.
        ratio = double.parse(
            ((duration.inSeconds / 86400) * 100).toStringAsFixed(2));
      }

      emotionDic['emotion'] = emotionLog.emotion;
      emotionDic['ratio'] = ratio;
      todayEmotionRatios.add(emotionDic);
      percentage -= ratio;

      i++;
    }

    for (var emotionRatio in todayEmotionRatios) {
      if (emotionRatio['emotion'] == 'happy')
        happyRatio += emotionRatio['ratio'];
      else if (emotionRatio['emotion'] == 'sad')
        sadRatio += emotionRatio['ratio'];
    }
    todayEmotionRatio['happy'] = happyRatio;
    todayEmotionRatio['sad'] = sadRatio;
  }

  static Future<void> _readData(String kind) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("${kind}_logs");
    var result = await ref.get();

    // 문서의 길이만큼 돌면서 작업 수행
    for (int i = 0; i < result.children.length; i++) {
      var timestamp =
          result.children.elementAt(i).child('time').value as int; // 로그의 타임 스템프
      var state = result.children.elementAt(i).child('${kind}').value
          as String; // 로그의 타임 스템프

      if (timestamp < DateFormatter.ago1MonthTimestamp) break;

      if (kind == 'emotion') {
        if (timestamp >= DateFormatter.ago24HourTimestamp) {
          todayEmotionLogs.add(EmotionLog(emotion: state, time: timestamp));
        }
        if (timestamp >= DateFormatter.ago7DayTimestamp) {
          weekEmotionLogs.add(EmotionLog(emotion: state, time: timestamp));
        }
        if (timestamp >= DateFormatter.ago1MonthTimestamp) {
          monthEmotionLogs.add(EmotionLog(emotion: state, time: timestamp));
        }
      } else if (kind == 'pose') {
        if (timestamp >= DateFormatter.ago24HourTimestamp) {
          todayPoseLogs.add(PoseLog(pose: state, time: timestamp));
        }
        if (timestamp >= DateFormatter.ago7DayTimestamp) {
          weekPoseLogs.add(PoseLog(pose: state, time: timestamp));
        }
        if (timestamp >= DateFormatter.ago1MonthTimestamp) {
          monthPoseLogs.add(PoseLog(pose: state, time: timestamp));
        }
      }
    }
  }
}
