import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleButtonWidget extends StatelessWidget {
  late Widget toggleButton;
  double verticalSize = Get.height;
  double horizonSize = Get.width;

  static const int TODAY = 0;
  static const int WEEK = 1;
  static const int MONTH = 2;

  static const int AIR = 0;
  static const int WEATHER = 1;
  static const List<int> _isEmotionSelected = [TODAY, WEEK, MONTH];
  static const List<int> _isSickroomSelected = [AIR, WEATHER];
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

  ToggleButtonWidget.emotion() {
    toggleButton = _toggleButton(true);
  }

  ToggleButtonWidget.sickroom() {
    toggleButton = _toggleButton(false);
  }
  Widget alternativeEmotionIconBuilder(BuildContext context,
      SizeProperties<int> local, GlobalToggleProperties<int> global) {
    Text data = Text("data");
    switch (local.value) {
      case TODAY:
        data = const Text(
          "Today",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
      case WEEK:
        data = const Text(
          "Week",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
      case MONTH:
        data = const Text(
          "Month",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
    }
    return data;
  }

  Widget alternativeSickroomIconBuilder(BuildContext context,
      SizeProperties<int> local, GlobalToggleProperties<int> global) {
    Text data = Text("data");
    switch (local.value) {
      case 0:
        data = const Text(
          "공조 현황",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
      case 1:
        data = const Text(
          "날씨",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return toggleButton;
  }

  Widget _toggleButton(bool isEmotion) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GetBuilder<TopContainerController>(
        builder: (_) => AnimatedToggleSwitch<int>.size(
            height: verticalSize * 0.04,
            current: Get.find<TopContainerController>().togleButtonValue,
            values: isEmotion ? _isEmotionSelected : _isSickroomSelected,
            iconOpacity: 0.5,
            indicatorSize: isEmotion
                ? Size.fromWidth((horizonSize * 0.27))
                : Size.fromWidth((horizonSize * 0.4)),
            customIconBuilder: (context, local, global) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isEmotion
                      ? alternativeEmotionIconBuilder(context, local, global)
                      : alternativeSickroomIconBuilder(context, local, global),
                ],
              );
            },
            borderColor: Colors.black,
            innerColor: Colors.black,
            colorBuilder: (i) => Colors.amber,
            onChanged: isEmotion
                ? (i) => Get.find<TopContainerController>().setToggleButton(i)
                : (i) => Get.find<TopContainerController>().setToggleButton(i)),
      ),
    );
  }
}
