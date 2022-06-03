import 'package:capston_app/src/components/widget/feedback_widget.dart';
import 'package:capston_app/src/components/widget/issue_icon_widget.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateController extends GetxController {
  int issue = 0;

  // int nowTemperature = FirebaseRepository.nowTemperature;
  // int nowhumidity = FirebaseRepository.nowHumidity;
  double nowTemperature = 19.0;
  double nowhumidity = 50.0;
  String nowPose = FirebaseRepository.nowPose;
  int nowPoseSecond = FirebaseRepository.nowPoseSecond;

  String topPoseTitle = "";

  List<Widget> stateIconListView = [];
  List<Widget> feedbackListView = [];
  List<Widget> dialogListView = [];

  StateController() {
    setIssue();
  }

  void setIssue() {
    if (FirebaseRepository.todayEmotionRatio['negative']! > 20) {
      issue++;
      stateIconListView
          .add(IssueIconWidget(text: "우 울 감", iconName: "sed_black.svg"));
      feedbackListView
          .add(FeedbackWidget(text: "우울감 개선이 필요", iconName: "sed_black.svg"));
    }
    if ((nowPose == "lie" && nowPoseSecond >= 7200)) {
      issue++;
      stateIconListView.add(
          IssueIconWidget(text: "욕 창", iconName: "bedsore.png", isImage: true));

      feedbackListView.add(FeedbackWidget(
          text: "장시간 누운 자세", iconName: "bedsore.png", isImage: true));
    }
    if (nowTemperature <= 20) {
      issue++;
      stateIconListView
          .add(IssueIconWidget(text: "온 도", iconName: "temperature.svg"));
      feedbackListView.add(
          FeedbackWidget(text: "실내 온도 20도 미만", iconName: "temperature.svg"));
      topPoseTitle = "온도 관리의 유의하세요";
    }
  }
}
