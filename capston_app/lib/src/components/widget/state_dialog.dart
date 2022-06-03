import 'package:capston_app/src/components/widget/issue_icon_list_component.dart';
import 'package:capston_app/src/controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StateDialog extends GetView<StateController> {
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: Get.width * 0.7,
        height: 380,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            Text(
              "다음과 같은 이상 징후를 발견하였습니다",
              style: TextStyle(
                  color: Colors.red, fontSize: 25, fontFamily: "MalangMalang"),
            ),
            Text(
              "${Get.find<StateController>().issue}건",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: isOver() ? verticalSize * 0.115 : 100,
                  fontFamily: "MalangMalang"),
            ),
            IssueIconListComponent()
          ],
        ),
      ),
    );
  }
}
