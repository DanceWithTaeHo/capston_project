import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum PageType { Emotion, Pose }

class AppController extends GetxService {
  static AppController get to => Get.find();
  PageController pageController = PageController(initialPage: 0);

  List pageList = [
    "emotion",
  ];

  RxInt _currentIndex = 0.obs;

  int get currentIndex => _currentIndex.value;

  void changePageIndex(int index) {
    _currentIndex(index);
  }

  void changePreviousPage() {
    pageController.previousPage(
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  void changeNextPage() {
    pageController.nextPage(
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }
}
