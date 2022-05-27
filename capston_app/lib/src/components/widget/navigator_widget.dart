import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:capston_app/src/controller/state_controller.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NavigatorWidget extends GetView<AppController> {
  late Widget centerWidget;
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

  NavigatorWidget.emotion() {
    centerWidget = GetBuilder<EmotionController>(
      builder: (_) => SizedBox(
        child: SvgPicture.asset(
          Get.find<EmotionController>().emotionIconURL,
        ),
        height: isOver() ? verticalSize * 0.15 : 100,
      ),
    );
  }
  NavigatorWidget.stateInfo() {
    centerWidget = Text(
      "${Get.find<StateController>().issue}건",
      style: TextStyle(
          color: Colors.red,
          fontSize: isOver() ? verticalSize * 0.115 : 100,
          fontFamily: "MalangMalang"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => controller.changePreviousPage(),
              icon: SvgPicture.asset('assets/icons/back.svg'),
              iconSize: isOver() ? verticalSize * 0.08 : 70),
          centerWidget,
          IconButton(
              onPressed: () => controller.changeNextPage(),
              icon: SvgPicture.asset('assets/icons/front.svg'),
              iconSize: isOver() ? verticalSize * 0.08 : 70),
        ],
      ),
    );
  }
}
