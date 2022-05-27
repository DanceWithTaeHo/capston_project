import 'package:capston_app/src/repository/fireabase.dart';
import 'package:get/get.dart';

class EmotionController extends GetxController {
  RxDouble _happyRatio = FirebaseRepository.todayEmotionRatio['happy']!.obs;
  RxDouble _sadRatio = FirebaseRepository.todayEmotionRatio['sad']!.obs;
  RxDouble _angryRatio = FirebaseRepository.todayEmotionRatio['angry']!.obs;
  RxDouble _disgustRatio = FirebaseRepository.todayEmotionRatio['disgust']!.obs;
  RxDouble _fearRatio = FirebaseRepository.todayEmotionRatio['fear']!.obs;
  RxDouble _surpriseRatio =
      FirebaseRepository.todayEmotionRatio['surprise']!.obs;
  RxDouble _neutralRatio = FirebaseRepository.todayEmotionRatio['neutral']!.obs;
  RxDouble _positiveRatio =
      FirebaseRepository.todayEmotionRatio['positive']!.obs;
  RxDouble _negativeRatio =
      FirebaseRepository.todayEmotionRatio['negative']!.obs;

  RxString _topEmotionTitle = "".obs;
  RxString _bottomTitle = "오늘의 기분".obs;
  RxString _emotionIconURL = "assets/icons/smile.svg".obs;

  RxInt _happyHourRatio =
      ((FirebaseRepository.todayEmotionRatio['happy']!) / 100 * 24).round().obs;
  RxInt _sadHourRatio =
      ((FirebaseRepository.todayEmotionRatio['sad']!) / 100 * 24).round().obs;

  double get happyRatio => _happyRatio.value;
  double get sadRatio => _sadRatio.value;
  double get angryRatio => _angryRatio.value;
  double get disgustRatio => _disgustRatio.value;
  double get fearRatio => _fearRatio.value;
  double get surpriseRatio => _surpriseRatio.value;
  double get neutralRatio => _neutralRatio.value;
  double get positiveRatio => _positiveRatio.value;
  double get negativeRatio => _negativeRatio.value;

  int get happyHourRatio => _happyHourRatio.value;
  int get sadHourRatio => _sadHourRatio.value;

  String get topEmotionTitle => _topEmotionTitle.value;
  String get bottomTitle => _bottomTitle.value;

  String get emotionIconURL => _emotionIconURL.value;

  @override
  void onInit() {
    super.onInit();
    _setEmotionScore();
  }

  void setEmotionRatio(String kind) {
    if (kind == 'today') {
      _happyRatio = FirebaseRepository.todayEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.todayEmotionRatio['sad']!.obs;
      _angryRatio = FirebaseRepository.todayEmotionRatio['angry']!.obs;
      _disgustRatio = FirebaseRepository.todayEmotionRatio['disgust']!.obs;
      _fearRatio = FirebaseRepository.todayEmotionRatio['fear']!.obs;
      _surpriseRatio = FirebaseRepository.todayEmotionRatio['surprise']!.obs;
      _neutralRatio = FirebaseRepository.todayEmotionRatio['neutral']!.obs;
      _positiveRatio = FirebaseRepository.todayEmotionRatio['positive']!.obs;
      _negativeRatio = FirebaseRepository.todayEmotionRatio['negative']!.obs;
      _bottomTitle = "오늘의 기분".obs;
      _setEmotionScore();
    } else if (kind == 'week') {
      _happyRatio = FirebaseRepository.weekEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.weekEmotionRatio['sad']!.obs;
      _angryRatio = FirebaseRepository.weekEmotionRatio['angry']!.obs;
      _disgustRatio = FirebaseRepository.weekEmotionRatio['disgust']!.obs;
      _fearRatio = FirebaseRepository.weekEmotionRatio['fear']!.obs;
      _surpriseRatio = FirebaseRepository.weekEmotionRatio['surprise']!.obs;
      _neutralRatio = FirebaseRepository.weekEmotionRatio['neutral']!.obs;
      _positiveRatio = FirebaseRepository.weekEmotionRatio['positive']!.obs;
      _negativeRatio = FirebaseRepository.weekEmotionRatio['negative']!.obs;
      _bottomTitle = "금주의 기분".obs;
      _setEmotionScore();
    } else if (kind == 'month') {
      _happyRatio = FirebaseRepository.monthEmotionRatio['happy']!.obs;
      _sadRatio = FirebaseRepository.monthEmotionRatio['sad']!.obs;
      _angryRatio = FirebaseRepository.monthEmotionRatio['angry']!.obs;
      _disgustRatio = FirebaseRepository.monthEmotionRatio['disgust']!.obs;
      _fearRatio = FirebaseRepository.monthEmotionRatio['fear']!.obs;
      _surpriseRatio = FirebaseRepository.monthEmotionRatio['surprise']!.obs;
      _neutralRatio = FirebaseRepository.monthEmotionRatio['neutral']!.obs;
      _positiveRatio = FirebaseRepository.monthEmotionRatio['positive']!.obs;
      _negativeRatio = FirebaseRepository.monthEmotionRatio['negative']!.obs;
      _bottomTitle = "이달의 기분".obs;
      _setEmotionScore();
    }
    update();
  }

  void _setEmotionScore() {
    if (FirebaseRepository.todayEmotionRatio['positive'] == 0) {
      _topEmotionTitle = "분석 데이터가 모잘라요!".obs;
    } else {
      if (positiveRatio >= 80 && neutralRatio >= 80) {
        _topEmotionTitle = "대체로 좋아요".obs;
        _emotionIconURL = "assets/icons/smile.svg".obs;
      } else if (positiveRatio >= 80 &&
          FirebaseRepository.todayEmotionRatio['neutral']! <= 80) {
        _topEmotionTitle = "항상 웃고 있어요!".obs;
        _emotionIconURL = "assets/icons/smile.svg".obs;
      } else if (negativeRatio > 20) {
        _topEmotionTitle = "주의 깊게 봐야해요".obs;
        _emotionIconURL = "assets/icons/sad.svg".obs;
      } else if (negativeRatio > positiveRatio) {
        _topEmotionTitle = "정밀 감정이 필요해요".obs;
        _emotionIconURL = "assets/icons/sad.svg".obs;
      }
    }
  }
}
