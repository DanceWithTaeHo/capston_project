import 'package:get/get.dart';

class TopContainerController extends GetxController {
  RxString score = "".obs;

  void setScore(int i) {
    var text = i.toString() + "입니다.";
    score = text.obs;
  }
}
