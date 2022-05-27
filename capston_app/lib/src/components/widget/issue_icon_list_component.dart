import 'package:capston_app/src/controller/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IssueIconListComponent extends GetView<StateController> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: controller.stateIconListView,
    );
  }
}
