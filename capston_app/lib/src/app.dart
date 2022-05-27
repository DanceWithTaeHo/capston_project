import 'package:capston_app/src/pages/emotion_page.dart';
import 'package:capston_app/src/pages/sickroom_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/app_controller.dart';
import 'pages/state_info_page.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [EmotionPage(), SickRoomPage(), StateInfoPage()],
      controller: controller.pageController,
    );
  }
}
