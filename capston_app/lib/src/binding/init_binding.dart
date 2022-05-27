import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:capston_app/src/controller/state_controller.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.put(TopContainerController());
    Get.put(EmotionController());
    Get.put(StateController());
  }
}
