import 'package:capston_app/src/components/widget/toggle_button_widget.dart';
import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final Color color;
  List<Widget> components = [];

  late Widget textWidget;
  late Widget feedbackTextWidget;
  late Widget navigatorWidget;
  late Widget emotionScoreWidget;
  late Widget toggleButtonWidget;
  late Widget issueIconWidget;

  TopContainer({Key? key, required this.color}) : super(key: key);

  TopContainer.emotion(
      {Key? key,
      required this.color,
      required this.textWidget,
      required this.navigatorWidget,
      required this.emotionScoreWidget,
      required this.toggleButtonWidget})
      : super(key: key) {
    components = [
      Container(
        child: Column(
          children: [
            textWidget,
            navigatorWidget,
          ],
        ),
      ),
      emotionScoreWidget,
      toggleButtonWidget
    ];
  }
  TopContainer.pose(
      {Key? key,
      required this.color,
      required this.textWidget,
      required this.navigatorWidget,
      required this.feedbackTextWidget,
      required this.toggleButtonWidget})
      : super(key: key) {
    components = [
      Container(
        child: Column(
          children: [
            textWidget,
            navigatorWidget,
          ],
        ),
      ),
      feedbackTextWidget,
      toggleButtonWidget
    ];
  }

  TopContainer.sickroom(
      {Key? key,
      required this.color,
      required this.textWidget,
      required this.navigatorWidget,
      required this.feedbackTextWidget,
      required this.toggleButtonWidget})
      : super(key: key) {
    components = [
      Container(
        child: Column(
          children: [
            textWidget,
            navigatorWidget,
          ],
        ),
      ),
      feedbackTextWidget,
      toggleButtonWidget
    ];
  }

  TopContainer.stateInfo({
    Key? key,
    required this.color,
    required this.textWidget,
    required this.navigatorWidget,
    required this.issueIconWidget,
  }) : super(key: key) {
    components = [
      Container(
        child: Column(
          children: [
            textWidget,
            navigatorWidget,
          ],
        ),
      ),
      issueIconWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    double verticalSize = MediaQuery.of(context).size.height; // ????????????
    return Container(
      // ?????? ????????? ?????????
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(30.0)),
        color: color,
      ),
      height: verticalSize * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // ?????? ??? ??????
        children: components,
      ),
    );
  }
}
