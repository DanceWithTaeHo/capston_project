import 'package:capston_app/src/components/widget/chart_widget.dart';
import 'package:capston_app/src/controller/emotion_controller.dart';
import 'package:capston_app/src/controller/pose_controller.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:capston_app/src/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomContainer extends StatelessWidget {
  final EmotionController emotionController = Get.put(EmotionController());
  final PoseController poseController = Get.put(PoseController());
  Widget listView = ListView();
  GetxController controller = Get.find<PoseController>();

  late double verticalSize;
  late double horizonSize;
  late Widget bottomTitle;

  BottomContainer({Key? key}) : super(key: key);
  BottomContainer.emotion({Key? key}) : super(key: key) {
    bottomTitle = GetBuilder<EmotionController>(builder: (_) {
      return Text(
        Get.find<EmotionController>().bottomTitle,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      );
    });
    listView = GetBuilder<EmotionController>(builder: (_) {
      return ListView(
        children: [
          ChartWidget(
              color: Colors.amber,
              text: "긍정감",
              ratio: emotionController.positiveRatio),
          ChartWidget(
            color: Colors.purple.shade300,
            text: "부정감",
            ratio: emotionController.negativeRatio,
          ),
          ChartWidget(
            color: Colors.greenAccent,
            text: "무표정",
            ratio: emotionController.neutralRatio,
          ),
          ChartWidget(
            color: Colors.red.shade400,
            text: "행복감",
            ratio: emotionController.happyRatio,
          ),
          ChartWidget(
            color: Colors.blue,
            text: "우울감",
            ratio: emotionController.sadRatio,
          ),
          ChartWidget(
            color: Colors.yellow.shade400,
            text: "놀람",
            ratio: emotionController.surpriseRatio,
          ),
          ChartWidget(
            color: Colors.deepOrangeAccent,
            text: "두려움",
            ratio: emotionController.fearRatio,
          ),
        ],
      );
    });
  }
  BottomContainer.pose({Key? key}) : super(key: key) {
    bottomTitle = GetBuilder<PoseController>(builder: (_) {
      return Text(
        Get.find<PoseController>().bottomTitle,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      );
    });
    listView = GetBuilder<PoseController>(builder: (_) {
      return ListView(
        children: [
          ChartWidget(
              color: Colors.green,
              text: "누운 자세",
              ratio: poseController.lieRatio),
          ChartWidget(
            color: Colors.lightBlue,
            text: "엎드린 자세",
            ratio: poseController.lieFaceDownRatio,
          ),
          ChartWidget(
            color: Colors.red.shade300,
            text: "옆으로 누운 자세",
            ratio: poseController.lieSideRatio,
          ),
          ChartWidget(
            color: Colors.yellow.shade300,
            text: "양반다리",
            ratio: poseController.sitCrossLeggedRatio,
          ),
          ChartWidget(
            color: Colors.amber,
            text: "걸터앉은 자세",
            ratio: poseController.sitOnChairRatio,
          )
        ],
      );
    });
  }
  BottomContainer.sickroom({Key? key}) : super(key: key) {
    bottomTitle = GetBuilder<PoseController>(builder: (_) {
      return Text(
        "현재상황",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      );
    });
    listView = GetBuilder<EmotionController>(builder: (_) {
      return ListView(
        children: [
          ChartWidget(
              color: Colors.blue,
              text: "온도",
              ratio: FirebaseRepository.nowTemperature),
          ChartWidget(
            color: Colors.amber,
            text: "습도",
            ratio: FirebaseRepository.nowHumidity,
          ),
        ],
      );
    });
  }
  BottomContainer.stateInfo({Key? key, required this.listView})
      : super(key: key) {
    bottomTitle = GetBuilder<PoseController>(builder: (_) {
      return Text(
        "현재상황",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
      );
    });
  }

  Widget _titleWidget() {
    var today = DateFormatter.today;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bottomTitle,
          Text(
            today,
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 15.0,
                fontFamily: "poppins"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    verticalSize = MediaQuery.of(context).size.height; // 수직길이
    horizonSize = MediaQuery.of(context).size.width; // 수평길이
    return Column(
      children: [
        _titleWidget(),
        Expanded(
          child: GetBuilder<EmotionController>(
            builder: (_) {
              return listView;
            },
          ),
        ),
      ],
    );
  }
}
