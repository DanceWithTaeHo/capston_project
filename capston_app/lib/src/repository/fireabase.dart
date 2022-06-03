import 'package:capston_app/src/models/emotion_log.dart';
import 'package:capston_app/src/models/pose_log.dart';
import 'package:capston_app/src/models/sickroom_log.dart';
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

  static List<Map<String, dynamic>> todayPoseRatios = [];
  static Map<String, double> todayPoseRatio = {};
  static List<Map<String, dynamic>> weekPoseRatios = [];
  static Map<String, double> weekPoseRatio = {};
  static List<Map<String, dynamic>> monthPoseRatios = [];
  static Map<String, double> monthPoseRatio = {};

  static List<EmotionLog> todayEmotionLogs = [];
  static List<EmotionLog> weekEmotionLogs = [];
  static List<EmotionLog> monthEmotionLogs = [];
  static List<PoseLog> todayPoseLogs = [];
  static List<PoseLog> weekPoseLogs = [];
  static List<PoseLog> monthPoseLogs = [];
  static List<SickroomLog> todaySickroomLogs = [];

  static String todayEmotionText = "";

  static int todayEmotionScore = 0;
  static int weekEmotionScore = 0;
  static int monthEmotionScore = 0;

  static String nowPose = "";
  static int nowPoseSecond = 0;

  static double nowTemperature = 0.0;
  static double nowHumidity = 0.0;

  static Future<void> init() async {
    await _readData('emotion');
    await _readData('pose');
    await _readData('sickroom');
    setEmotionRatio('today');
    setEmotionRatio('week');
    setEmotionRatio('month');
    setPoseRatio('today');
    setPoseRatio('week');
    setPoseRatio('month');
    setEmotionScore('today');
    setEmotionScore('week');
    setEmotionScore('month');
    print(todaySickroomLogs.length);
    print(todaySickroomLogs.last);
  }

  static void setEmotionScore(String kind) {
    double positiveRatio = 0.0;
    double negativeRatio = 0.0;
    if (kind == 'today') {
      positiveRatio = todayEmotionRatio['positive']!;
      negativeRatio = todayEmotionRatio['negative']!;
      todayEmotionScore = positiveRatio.round();
    } else if (kind == 'week') {
      positiveRatio = weekEmotionRatio['positive']!;
      negativeRatio = weekEmotionRatio['negative']!;
      weekEmotionScore = positiveRatio.round();
    } else if (kind == 'month') {
      negativeRatio = FirebaseRepository.monthEmotionRatio['negative']!;
      positiveRatio = FirebaseRepository.monthEmotionRatio['positive']!;
      monthEmotionScore = positiveRatio.round();
    }
  }

  static void _poseClassification(String kind) {
    var poseRatios;
    if (kind == 'today')
      poseRatios = todayPoseRatios;
    else if (kind == 'week')
      poseRatios = weekPoseRatios;
    else if (kind == 'month') poseRatios = monthPoseRatios;
    double lieRatio = 0.0;
    double lieFaceDownRatio = 0.0;
    double lieSideRatio = 0.0;
    double sitCrossLeggedRatio = 0.0;
    double sitOnChairRatio = 0.0;
    for (var poseRatio in poseRatios) {
      if (poseRatio['pose'] == 'lie') {
        lieRatio += poseRatio['ratio'];
        lieRatio = double.parse(lieRatio.toStringAsFixed(2));
      } else if (poseRatio['pose'] == 'lie_face_down') {
        lieFaceDownRatio += poseRatio['ratio'];
        lieFaceDownRatio = double.parse(lieFaceDownRatio.toStringAsFixed(2));
      } else if (poseRatio['pose'] == 'lie_side') {
        lieSideRatio += poseRatio['ratio'];
        lieSideRatio = double.parse(lieSideRatio.toStringAsFixed(2));
      } else if (poseRatio['pose'] == 'sit_cross_legged') {
        sitCrossLeggedRatio += poseRatio['ratio'];
        sitCrossLeggedRatio =
            double.parse(sitCrossLeggedRatio.toStringAsFixed(2));
      } else if (poseRatio['pose'] == 'sit_on_chair') {
        sitOnChairRatio += poseRatio['ratio'];
        sitOnChairRatio = double.parse(sitOnChairRatio.toStringAsFixed(2));
      }
    }

    if (kind == 'today') {
      todayPoseRatio['lie'] = lieRatio;
      todayPoseRatio['lieFaceDown'] = lieFaceDownRatio;
      todayPoseRatio['lieSide'] = lieSideRatio;
      todayPoseRatio['sitCrossLegged'] = sitCrossLeggedRatio;
      todayPoseRatio['sitOnChair'] = sitOnChairRatio;
    } else if (kind == 'week') {
      weekPoseRatio['lie'] = lieRatio;
      weekPoseRatio['lieFaceDown'] = lieFaceDownRatio;
      weekPoseRatio['lieSide'] = lieSideRatio;
      weekPoseRatio['sitCrossLegged'] = sitCrossLeggedRatio;
      weekPoseRatio['sitOnChair'] = sitOnChairRatio;
    } else if (kind == 'month') {
      monthPoseRatio['lie'] = lieRatio;
      monthPoseRatio['lieFaceDown'] = lieFaceDownRatio;
      monthPoseRatio['lieSide'] = lieSideRatio;
      monthPoseRatio['sitCrossLegged'] = sitCrossLeggedRatio;
      monthPoseRatio['sitOnChair'] = sitOnChairRatio;
    }
  }

  static void setPoseRatio(String kind) {
    late var poseLogs;
    late Duration beforeDuration;
    late Duration duration;
    int second = 0;
    double percentage = 100;

    if (kind == 'today') {
      poseLogs = List.from(todayPoseLogs.reversed);
      second = 86400;
    } else if (kind == 'week') {
      poseLogs = List.from(weekPoseLogs.reversed);
      second = 604800;
    } else if (kind == 'month') {
      poseLogs = List.from(monthPoseLogs.reversed);
      second = 2592000;
    }

    int i = 0;
    for (PoseLog poseLog in poseLogs) {
      Map<String, dynamic> poseDic = {};
      double ratio = 0;
      // 먼저 현재 시간과 로그의 시간 차를 구한다.
      duration = DateFormatter.now
          .difference(DateFormatter.changeDateTime(poseLog.time!));

      if (i == poseLogs.length - 1) {
        // 가장 오래된 로그라면
        ratio = double.parse(percentage.toStringAsFixed(2));
      }
      // 전체 시간 중 시간 차의 비중을 구한다.
      else if (i == 0) {
        // 가장 최근의 로그일 때만
        ratio = double.parse(
            (((duration.inSeconds) / second) * 100).toStringAsFixed(2));
        nowPose = poseLog.pose!;
        nowPoseSecond = duration.inSeconds;
      } else {
        // 나머지 로그들은 이전 로그의 비중을 뺀다.

        ratio = double.parse(
            (((duration.inSeconds - beforeDuration.inSeconds) / second) * 100)
                .toStringAsFixed(2));
      }
      poseDic['pose'] = poseLog.pose;
      poseDic['ratio'] = ratio;

      percentage -= ratio;
      beforeDuration = duration;

      i++;

      if (kind == 'today') {
        todayPoseRatios.add(poseDic);
      } else if (kind == 'week') {
        weekPoseRatios.add(poseDic);
      } else if (kind == 'month') {
        monthPoseRatios.add(poseDic);
      }
    }
    _poseClassification(kind);
  }

  static void _emotionClassification(String kind) {
    var emotionRatios;
    if (kind == 'today')
      emotionRatios = todayEmotionRatios;
    else if (kind == 'week')
      emotionRatios = weekEmotionRatios;
    else if (kind == 'month') emotionRatios = monthEmotionRatios;

    double happyRatio = 0.0;
    double sadRatio = 0.0;
    double angryRatio = 0.0;
    double disgustRatio = 0.0;
    double fearRatio = 0.0;
    double surpriseRatio = 0.0;
    double neutralRatio = 0.0;
    double positiveRatio = 0.0;
    double negativeRatio = 0.0;
    for (var emotionRatio in emotionRatios) {
      if (emotionRatio['emotion'] == 'happy') {
        happyRatio += emotionRatio['ratio'];
        happyRatio = double.parse(happyRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'sad') {
        sadRatio += emotionRatio['ratio'];
        sadRatio = double.parse(sadRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'angry') {
        angryRatio += emotionRatio['ratio'];
        angryRatio = double.parse(angryRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'disgust') {
        disgustRatio += emotionRatio['ratio'];
        disgustRatio = double.parse(disgustRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'fear') {
        fearRatio += emotionRatio['ratio'];
        fearRatio = double.parse(fearRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'surprise') {
        surpriseRatio += emotionRatio['ratio'];
        surpriseRatio = double.parse(surpriseRatio.toStringAsFixed(2));
      } else if (emotionRatio['emotion'] == 'neutral') {
        neutralRatio += emotionRatio['ratio'];
        neutralRatio = double.parse(neutralRatio.toStringAsFixed(2));
      }
      positiveRatio = happyRatio + neutralRatio + surpriseRatio;
      negativeRatio = sadRatio + angryRatio + disgustRatio + fearRatio;
    }

    if (kind == 'today') {
      todayEmotionRatio['happy'] = happyRatio;
      todayEmotionRatio['sad'] = sadRatio;
      todayEmotionRatio['angry'] = angryRatio;
      todayEmotionRatio['disgust'] = disgustRatio;
      todayEmotionRatio['fear'] = fearRatio;
      todayEmotionRatio['surprise'] = surpriseRatio;
      todayEmotionRatio['neutral'] = neutralRatio;
      todayEmotionRatio['positive'] = positiveRatio;
      todayEmotionRatio['negative'] = negativeRatio;
    } else if (kind == 'week') {
      weekEmotionRatio['happy'] = happyRatio;
      weekEmotionRatio['sad'] = sadRatio;
      weekEmotionRatio['angry'] = angryRatio;
      weekEmotionRatio['disgust'] = disgustRatio;
      weekEmotionRatio['fear'] = fearRatio;
      weekEmotionRatio['surprise'] = surpriseRatio;
      weekEmotionRatio['neutral'] = neutralRatio;
      weekEmotionRatio['positive'] = positiveRatio;
      weekEmotionRatio['negative'] = negativeRatio;
    } else if (kind == 'month') {
      monthEmotionRatio['happy'] = happyRatio;
      monthEmotionRatio['sad'] = sadRatio;
      monthEmotionRatio['angry'] = angryRatio;
      monthEmotionRatio['disgust'] = disgustRatio;
      monthEmotionRatio['fear'] = fearRatio;
      monthEmotionRatio['surprise'] = surpriseRatio;
      monthEmotionRatio['neutral'] = neutralRatio;
      monthEmotionRatio['positive'] = positiveRatio;
      monthEmotionRatio['negative'] = negativeRatio;
    }
  }

  static void setEmotionRatio(String kind) {
    late var emotionLogs;
    late Duration beforeDuration;
    late Duration duration;
    int second = 0;
    double percentage = 100;

    if (kind == 'today') {
      emotionLogs = List.from(todayEmotionLogs.reversed);
      second = 86400;
    } else if (kind == 'week') {
      emotionLogs = List.from(weekEmotionLogs.reversed);
      second = 604800;
    } else if (kind == 'month') {
      emotionLogs = List.from(monthEmotionLogs.reversed);
      second = 2592000;
    }

    int i = 0;
    for (EmotionLog emotionLog in emotionLogs) {
      Map<String, dynamic> emotionDic = {};
      double ratio = 0;
      // 먼저 현재 시간과 로그의 시간 차를 구한다.
      duration = DateFormatter.now
          .difference(DateFormatter.changeDateTime(emotionLog.time!));

      if (i == emotionLogs.length - 1) {
        // 가장 오래된 로그라면
        ratio = double.parse(percentage.toStringAsFixed(2));
      }
      // 전체 시간 중 시간 차의 비중을 구한다.
      else if (i == 0) {
        // 가장 최근의 로그일 때만
        ratio = double.parse(
            (((duration.inSeconds) / second) * 100).toStringAsFixed(2));
      } else {
        // 나머지 로그들은 이전 로그의 비중을 뺀다.

        ratio = double.parse(
            (((duration.inSeconds - beforeDuration.inSeconds) / second) * 100)
                .toStringAsFixed(2));
      }
      emotionDic['emotion'] = emotionLog.emotion;
      emotionDic['ratio'] = ratio;

      percentage -= ratio;
      beforeDuration = duration;

      i++;

      if (kind == 'today') {
        todayEmotionRatios.add(emotionDic);
      } else if (kind == 'week') {
        weekEmotionRatios.add(emotionDic);
      } else if (kind == 'month') {
        monthEmotionRatios.add(emotionDic);
      }
    }
    _emotionClassification(kind);
  }

  static Future<void> _readData(String kind) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("${kind}_logs");
    var result = await ref.get();

    // 문서의 길이만큼 돌면서 작업 수행
    for (int i = 0; i < result.children.length; i++) {
      String state = "";
      double temperature = 0.0;
      double humidity = 0.0;
      var timestamp = result.children.elementAt((i)).child('time').value
          as int; // 로그의 타임 스템프
      if (kind == "sickroom") {
        temperature =
            (result.children.elementAt(i).child('temperature').value as int)
                .toDouble();
        humidity = (result.children.elementAt(i).child('humidity').value as int)
            .toDouble();
      } else
        state = result.children.elementAt(i).child('${kind}').value
            as String; // 로그의
      if (timestamp < DateFormatter.ago1MonthTimestamp) {
        continue;
      }

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
      } else if (kind == 'sickroom') {
        if (timestamp >= DateFormatter.ago24HourTimestamp) {
          todaySickroomLogs.add(SickroomLog(
              temperature: temperature, humidity: humidity, time: timestamp));

          nowTemperature = temperature;
          nowHumidity = humidity;
        }
      }
    }

    if (todaySickroomLogs.length == 0) {
      todaySickroomLogs.add(SickroomLog());
    }
  }
}
