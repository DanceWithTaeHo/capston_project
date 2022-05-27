import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class EmotionScoreWidget extends StatelessWidget {
  double verticalSize = Get.height;
  bool over = false;
  bool isOver() {
    if (verticalSize * 0.1 < 100) {
      over = true;
      return over;
    } else {
      over = false;
      return false;
    }
  }

  static const colorizeColors = [
    Colors.blue,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: 'Horizon',
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            "금일 점수 ${FirebaseRepository.todayEmotionScore}",
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            "주간 점수 ${FirebaseRepository.weekEmotionScore}",
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            "월간 점수 ${FirebaseRepository.monthEmotionScore}",
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        onTap: () {},
      ),
    );
  }
}
