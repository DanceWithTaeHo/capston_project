import 'package:capston_app/src/repository/fireabase.dart';
import 'package:get/get.dart';

class PoseController extends GetxController {
  RxDouble _lieRatio = FirebaseRepository.todayPoseRatio['lie']!.obs;
  RxDouble _lieFaceDownRatio =
      FirebaseRepository.todayPoseRatio['lieFaceDown']!.obs;
  RxDouble _lieSideRatio = FirebaseRepository.todayPoseRatio['lieSide']!.obs;
  RxDouble _sitCrossLeggedRatio =
      FirebaseRepository.todayPoseRatio['sitCrossLegged']!.obs;
  RxDouble _sitOnChairRatio =
      FirebaseRepository.todayPoseRatio['sitOnChair']!.obs;

  RxString _topPoseTitle = "".obs;
  RxString _bottomTitle = "오늘의 자세".obs;
  RxString _poseIconURL = "assets/icons/smile.svg".obs;

  double get lieRatio => _lieRatio.value;
  double get lieFaceDownRatio => _lieFaceDownRatio.value;
  double get lieSideRatio => _lieSideRatio.value;
  double get sitCrossLeggedRatio => _sitCrossLeggedRatio.value;
  double get sitOnChairRatio => _sitOnChairRatio.value;

  String get topPoseTitle => _topPoseTitle.value;
  String get bottomTitle => _bottomTitle.value;

  String get poseIconURL => _poseIconURL.value;

  @override
  void onInit() {
    super.onInit();
    _setPoseScore();
  }

  void setPoseRatio(String kind) {
    if (kind == 'today') {
      _lieRatio = FirebaseRepository.todayPoseRatio['lie']!.obs;
      _lieFaceDownRatio = FirebaseRepository.todayPoseRatio['lieFaceDown']!.obs;
      _lieSideRatio = FirebaseRepository.todayPoseRatio['lieSide']!.obs;
      _sitCrossLeggedRatio =
          FirebaseRepository.todayPoseRatio['sitCrossLegged']!.obs;
      _sitOnChairRatio = FirebaseRepository.todayPoseRatio['sitOnChair']!.obs;
      _bottomTitle = "오늘의 자세".obs;
      _setPoseScore();
    } else if (kind == 'week') {
      _lieRatio = FirebaseRepository.weekPoseRatio['lie']!.obs;
      _lieFaceDownRatio = FirebaseRepository.weekPoseRatio['lieFaceDown']!.obs;
      _lieSideRatio = FirebaseRepository.weekPoseRatio['lieSide']!.obs;
      _sitCrossLeggedRatio =
          FirebaseRepository.weekPoseRatio['sitCrossLegged']!.obs;
      _sitOnChairRatio = FirebaseRepository.weekPoseRatio['sitOnChair']!.obs;
      _bottomTitle = "금주의 자세".obs;
      _setPoseScore();
    } else if (kind == 'month') {
      _lieRatio = FirebaseRepository.monthPoseRatio['lie']!.obs;
      _lieFaceDownRatio = FirebaseRepository.monthPoseRatio['lieFaceDown']!.obs;
      _lieSideRatio = FirebaseRepository.monthPoseRatio['lieSide']!.obs;
      _sitCrossLeggedRatio =
          FirebaseRepository.monthPoseRatio['sitCrossLegged']!.obs;
      _sitOnChairRatio = FirebaseRepository.monthPoseRatio['sitOnChair']!.obs;
      _bottomTitle = "이달의 자세".obs;
      _setPoseScore();
    }
    update();
  }

  void _setPoseScore() {
    if (FirebaseRepository.todayPoseRatio['lie'] == 0) {
      _topPoseTitle = "분석 데이터가 모잘라요!".obs;
    } else {
      if (lieRatio >= 30 && lieRatio <= 50) {
        _topPoseTitle = "대체로 좋아요".obs;
        _poseIconURL = "assets/icons/smile.svg".obs;
      } else if (lieRatio >= 50 && lieRatio <= 60) {
        _topPoseTitle = "반나절은 누워계세요".obs;
        _poseIconURL = "assets/icons/sad.svg".obs;
      } else if (lieRatio >= 70) {
        _topPoseTitle = "항상 누워만 계세요".obs;
        _poseIconURL = "assets/icons/sad.svg".obs;
      } else if (lieRatio < 30) {
        _topPoseTitle = "자주 활동 하세요".obs;
        _poseIconURL = "assets/icons/smile.svg".obs;
      } else if (lieSideRatio >= 30) {
        _topPoseTitle = "허리 부담이 커요".obs;
        _poseIconURL = "assets/icons/sad.svg".obs;
      }
    }
  }
}
