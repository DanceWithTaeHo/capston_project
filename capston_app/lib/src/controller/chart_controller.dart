import 'package:capston_app/src/repository/fireabase.dart';
import 'package:get/get.dart';

class ChartController extends GetxController {
  RxDouble _happyRatio = FirebaseRepository.todayEmotionRatio['happy']!.obs;
  RxDouble _sadRatio = FirebaseRepository.todayEmotionRatio['sad']!.obs;

  RxInt _happyHourRatio =
      ((FirebaseRepository.todayEmotionRatio['happy']!) / 100 * 24).round().obs;
  RxInt _sadHourRatio =
      ((FirebaseRepository.todayEmotionRatio['sad']!) / 100 * 24).round().obs;

  double get happyRatio => _happyRatio.value;
  double get sadRatio => _sadRatio.value;
  int get happyHourRatio => _happyHourRatio.value;
  int get sadHourRatio => _sadHourRatio.value;

  void setEmotionRatio(String kind) {
    if (kind == 'today') {
      _happyRatio = FirebaseRepository.todayEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.todayEmotionRatio['sad']!.obs;
    } else if (kind == 'week') {
      _happyRatio = FirebaseRepository.weekEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.weekEmotionRatio['sad']!.obs;
    } else if (kind == 'month') {
      _happyRatio = FirebaseRepository.monthEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.monthEmotionRatio['sad']!.obs;
    }
    update();
  }
}
