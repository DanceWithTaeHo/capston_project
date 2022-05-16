import 'package:capston_app/src/models/emotion_log.dart';
import 'package:capston_app/src/models/pose_log.dart';
import 'package:capston_app/src/utils/date_formatter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static late DateTime logDate;
  static late Timestamp _timestamp;

  static int todayEmotionLogMaxNum = 0;
  static int weekEmotionLogMaxNum = 0;
  static int monthEmotionLogMaxNum = 0;
  static int todayPoseLogMaxNum = 0;
  static int weekPoseLogMaxNum = 0;
  static int monthPoseLogMaxNum = 0;
  static List<EmotionLog> todayEmotionLog = [];
  static List<EmotionLog> weekEmotionLog = [];
  static List<EmotionLog> monthEmotionLog = [];
  static List<PoseLog> todayPoseLog = [];
  static List<PoseLog> weekPoseLog = [];
  static List<PoseLog> monthPoseLog = [];

  static Future<void> getLog(String kind) async {
    await db.collection("logs/").get().then((result) {
      for (var doc in result.docs) {
        if (doc.id == "${kind}_logs") {
          _timestamp = (doc.get("time"));
          logDate = DateFormatter.changeDateTime(_timestamp.seconds);
          if (kind == 'emotion') {
            if (DateFormatter.yyyyMMddFormat(logDate) == DateFormatter.today) {
              todayEmotionLogMaxNum += 1;
              todayEmotionLog
                  .add(EmotionLog(emotion: doc.get(kind), time: logDate));
            }
            if (int.parse(DateFormatter.yyyyMMddFormat(logDate)) >=
                DateFormatter.ago7DayNum) {
              weekEmotionLogMaxNum += 1;
              weekEmotionLog
                  .add(EmotionLog(emotion: doc.get(kind), time: logDate));
            }
            if (DateFormatter.yyyyMMFormat(logDate) == DateFormatter.month) {
              monthEmotionLogMaxNum += 1;
              monthEmotionLog
                  .add(EmotionLog(emotion: doc.get(kind), time: logDate));
            }
          } else if (kind == 'pose') {
            if (DateFormatter.yyyyMMddFormat(logDate) == DateFormatter.today) {
              todayPoseLogMaxNum += 1;
              todayPoseLog.add(PoseLog(pose: doc.get(kind), time: logDate));
            }
            if (int.parse(DateFormatter.yyyyMMddFormat(logDate)) >=
                DateFormatter.ago7DayNum) {
              weekPoseLogMaxNum += 1;
              weekPoseLog.add(PoseLog(pose: doc.get(kind), time: logDate));
            }
            if (DateFormatter.yyyyMMFormat(logDate) == DateFormatter.month) {
              monthPoseLogMaxNum += 1;
              monthPoseLog.add(PoseLog(pose: doc.get(kind), time: logDate));
            }
          }
        }
      }
    });
  }
}
