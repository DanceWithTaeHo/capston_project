import 'package:capston_app/src/controller/app_controller.dart';
import 'package:capston_app/src/controller/chart_controller.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
