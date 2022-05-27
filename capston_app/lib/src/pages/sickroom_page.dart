import 'package:capston_app/src/components/container/bottom_container.dart';
import 'package:capston_app/src/components/widget/emotion_score_widget.dart';
import 'package:capston_app/src/components/widget/navigator_widget.dart';
import 'package:capston_app/src/components/widget/text_widget.dart';
import 'package:capston_app/src/components/widget/toggle_button_widget.dart';
import 'package:capston_app/src/components/container/top_container.dart';
import 'package:capston_app/src/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_page.dart';

class SickRoomPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      topContainer: TopContainer.sickroom(
        color: Colors.amber.withOpacity(0.4),
        textWidget: TextWidget(text: "실내공조관리"),
        navigatorWidget: NavigatorWidget.emotion(),
        feedbackTextWidget: TextWidget(text: "온도 관리에 유의하세요"),
        toggleButtonWidget: ToggleButtonWidget.sickroom(),
      ),
      bottomContainer: BottomContainer.sickroom(),
    );
  }
}
