import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum PageType { emotion, pose, sickroom }

class ToggleButtonWidget extends StatelessWidget {
  late Widget toggleButton;
  double verticalSize = Get.height;
  double horizonSize = Get.width;
  late Size indicatorSize;
  late List<int> values;
  late PageType pageType;

  static const int TODAY = 0;
  static const int WEEK = 1;
  static const int MONTH = 2;

  static const int AIR = 0;
  static const int WEATHER = 1;
  static const List<int> _isEmotionSelected = [TODAY, WEEK, MONTH];
  static const List<int> _isPoseSelected = [TODAY, WEEK, MONTH];
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
    pageType = PageType.emotion;
    setType();
  }
  ToggleButtonWidget.pose() {
    pageType = PageType.pose;
    setType();
  }

  ToggleButtonWidget.sickroom() {
    pageType = PageType.sickroom;
    setType();
  }
  Widget alternativIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    Text data = Text("data");
    if (pageType == PageType.emotion || pageType == PageType.pose) {
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
    } else {
      switch (local.value) {
        case AIR:
          data = const Text(
            "공조 현황",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          );
          break;
        case WEATHER:
          data = const Text(
            "날씨",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          );
          break;
      }
    }
    return data;
  }

  void onChanged(int i) {
    switch (pageType) {
      case PageType.emotion:
        Get.find<TopContainerController>().setEmotionToggleButton(i);
        break;
      case PageType.pose:
        Get.find<TopContainerController>().setPoseToggleButton(i);
        break;
      case PageType.sickroom:
        Get.find<TopContainerController>().setPoseToggleButton(i);
        break;
    }
  }

  void setType() {
    switch (pageType) {
      case PageType.emotion:
        indicatorSize = Size.fromWidth((horizonSize * 0.27));
        values = _isEmotionSelected;
        break;
      case PageType.pose:
        indicatorSize = Size.fromWidth((horizonSize * 0.27));
        values = _isPoseSelected;
        break;
      case PageType.sickroom:
        indicatorSize = Size.fromWidth((horizonSize * 0.4));
        values = _isSickroomSelected;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: GetBuilder<TopContainerController>(
          builder: (_) => AnimatedToggleSwitch<int>.size(
            height: verticalSize * 0.04,
            current: Get.find<TopContainerController>().togleButtonValue,
            values: values,
            iconOpacity: 0.5,
            indicatorSize: indicatorSize,
            customIconBuilder: (context, local, global) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  alternativIconBuilder(context, local, global),
                ],
              );
            },
            borderColor: Colors.black,
            innerColor: Colors.black,
            colorBuilder: (i) => Colors.amber,
            onChanged: (i) => onChanged(i),
          ),
        ));
  }
}
