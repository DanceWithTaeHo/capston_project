import 'package:capston_app/src/components/chart_component.dart';
import 'package:capston_app/src/controller/chart_controller.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:capston_app/src/utils/date_formatter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BottomContainer extends StatelessWidget {
  final TopContainerController controller = Get.put(TopContainerController());
  final ChartController chartcontroller = Get.put(ChartController());

  late double verticalSize;
  late double horizonSize;

  BottomContainer({Key? key}) : super(key: key);

  Widget _titleWidget() {
    var today = DateFormatter.today;
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "오늘의 기분",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
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
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // 가로 축 정렬
      children: [
        _titleWidget(),
        Column(
          children: [
            GetBuilder<ChartController>(builder: (_) {
              return ChartComponent(
                color: Colors.amber,
                text: "긍정감",
                ratio: chartcontroller.happyRatio,
              );
            }),
            GetBuilder<ChartController>(builder: (_) {
              return ChartComponent(
                color: Colors.blue,
                text: "우울감",
                ratio: chartcontroller.sadRatio,
              );
            }),
          ],
        ),
      ],
    );
  }
}
