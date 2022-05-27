import 'package:capston_app/src/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BasePage extends GetView<AppController> {
  late Widget topContainer;
  late Widget bottomContainer;
  BasePage(
      {Key? key, required this.topContainer, required this.bottomContainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [topContainer, Flexible(child: bottomContainer)],
      ),
    );
  }
}
