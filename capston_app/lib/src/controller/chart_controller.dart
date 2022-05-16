import 'package:get/get.dart';

class ChartController extends GetxController {
  RxDouble _ratio = 0.0.obs;

  double get ratio => _ratio.value;

  void setRatio(double ratio) {
    this._ratio = ratio.obs;
    update();
  }
}
