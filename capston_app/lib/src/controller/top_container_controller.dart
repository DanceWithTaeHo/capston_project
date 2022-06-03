import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:capston_app/src/controller/pose_controller.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:get/get.dart';

class TopContainerController extends GetxController {
  RxString emotionIconURL = "assets/icons/smile.svg".obs;
  int todayEmotionScore = FirebaseRepository.todayEmotionScore;
  int weekEmotionScore = FirebaseRepository.weekEmotionScore;
  int monthEmotionScore = FirebaseRepository.monthEmotionScore;
  int togleButtonValue = 0;

  void setEmotionIcon(String kind) {
    if (kind == 'today') {
      emotionIconURL = "assets/icons/smile.svg".obs;
    } else if (kind == 'week') {
    } else if (kind == 'month') {}
    update();
  }

  void setEmotionToggleButton(int i) {
    if (i == 0) {
      Get.find<EmotionController>().setEmotionRatio('today');
    } else if (i == 1) {
      Get.find<EmotionController>().setEmotionRatio('week');
    } else if (i == 2) {
      Get.find<EmotionController>().setEmotionRatio('month');
    }
    togleButtonValue = i;
    update();
  }

  void setPoseToggleButton(int i) {
    if (i == 0) {
      Get.find<PoseController>().setPoseRatio('today');
    } else if (i == 1) {
      Get.find<PoseController>().setPoseRatio('week');
    } else if (i == 2) {
      Get.find<PoseController>().setPoseRatio('month');
    }
    togleButtonValue = i;
    update();
  }

  void setSickroomToggleButton(int i) {
    if (i == 0) {
      Get.find<EmotionController>().setEmotionRatio('today');
    } else if (i == 1) {
      Get.find<EmotionController>().setEmotionRatio('week');
    } else if (i == 2) {
      Get.find<EmotionController>().setEmotionRatio('month');
    }
    togleButtonValue = i;
    update();
  }
}
