import 'package:capston_app/src/components/container/bottom_container.dart';
import 'package:capston_app/src/components/widget/emotion_score_widget.dart';
import 'package:capston_app/src/components/widget/navigator_widget.dart';
import 'package:capston_app/src/components/widget/text_widget.dart';
import 'package:capston_app/src/components/widget/toggle_button_widget.dart';
import 'package:capston_app/src/components/container/top_container.dart';
import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_page.dart';

class EmotionPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      topContainer: TopContainer.emotion(
        color: Colors.amber.withOpacity(1.0),
        emotionScoreWidget: EmotionScoreWidget(),
        navigatorWidget: NavigatorWidget.emotion(),
        textWidget: GetBuilder<EmotionController>(
            builder: (_) => TextWidget(
                  text: Get.find<EmotionController>().topEmotionTitle,
                )),
        toggleButtonWidget: ToggleButtonWidget.emotion(),
      ),
      bottomContainer: BottomContainer.emotion(),
    );
  }
}
