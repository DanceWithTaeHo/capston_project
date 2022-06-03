import 'package:capston_app/src/components/container/bottom_container.dart';
import 'package:capston_app/src/components/widget/emotion_score_widget.dart';
import 'package:capston_app/src/components/widget/navigator_widget.dart';
import 'package:capston_app/src/components/widget/text_widget.dart';
import 'package:capston_app/src/components/widget/toggle_button_widget.dart';
import 'package:capston_app/src/components/container/top_container.dart';
import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/pose_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_page.dart';

class PosePage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      topContainer: TopContainer.pose(
        color: Colors.blueAccent.shade100,
        textWidget: TextWidget(text: "자세 현황"),
        feedbackTextWidget: GetBuilder<PoseController>(
            builder: (_) => TextWidget(
                  text: Get.find<PoseController>().topPoseTitle,
                )),
        navigatorWidget: NavigatorWidget.pose(),
        toggleButtonWidget: ToggleButtonWidget.pose(),
      ),
      bottomContainer: BottomContainer.pose(),
    );
  }
}
