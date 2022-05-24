import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:capston_app/src/controller/chart_controller.dart';
import 'package:capston_app/src/controller/top_container_controller.dart';
import 'package:capston_app/src/repository/fireabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({Key? key}) : super(key: key);

  @override
  State<TopContainer> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopContainer> {
  final TopContainerController controller = Get.put(TopContainerController());
  late double verticalSize;
  late double horizonSize;
  static const int TODAY = 0;
  static const int WEEK = 1;
  static const int MONTH = 2;
  static const List<int> _isSelected = [TODAY, WEEK, MONTH];

  static const colorizeColors = [
    Colors.blue,
    Colors.red,
  ];

  static const colorizeTextStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: 'Horizon',
  );

  int num = 78;
  int value = 0;
  bool positive = false;
  bool over = false;
  bool isOver() {
    if (verticalSize * 0.1 < 100) {
      over = true;
      return over;
    } else {
      over = false;
      return false;
    }
  }

  Widget _textWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        FirebaseRepository.todayEmotionText,
        style: TextStyle(
            fontSize: 25,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _stateIcon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/back.svg'),
            iconSize: isOver() ? verticalSize * 0.08 : 70),
        SizedBox(
          child: SvgPicture.asset("assets/icons/smile.svg"),
          height: isOver() ? verticalSize * 0.08 : 100,
        ),
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/front.svg'),
            iconSize: isOver() ? verticalSize * 0.08 : 70),
      ],
    );
  }

  Widget _emotionScore() {
    return SizedBox(
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText(
            FirebaseRepository.todayEmotionScore,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            FirebaseRepository.weekEmotionScore,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
          ColorizeAnimatedText(
            FirebaseRepository.monthEmotionScore,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        onTap: () {},
      ),
    );
  }

  Widget _toggleButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: AnimatedToggleSwitch<int>.size(
        height: verticalSize * 0.04,
        current: value,
        values: _isSelected,
        iconOpacity: 0.5,
        indicatorSize: Size.fromWidth((horizonSize * 0.27)),
        customIconBuilder: (context, local, global) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              alternativeIconBuilder(context, local, global),
            ],
          );
        },
        borderColor: Colors.black,
        innerColor: Colors.black,
        colorBuilder: (i) => Colors.amber,
        onChanged: (i) => setState(() {
          if (i == 0) {
            Get.find<ChartController>().setEmotionRatio('today');
          } else if (i == 1) {
            Get.find<ChartController>().setEmotionRatio('week');
          } else if (i == 2) {
            Get.find<ChartController>().setEmotionRatio('month');
          }
          value = i;
        }),
      ),
    );
  }

  Widget alternativeIconBuilder(BuildContext context, SizeProperties<int> local,
      GlobalToggleProperties<int> global) {
    Text data = Text("data");
    switch (local.value) {
      case TODAY:
        data = const Text(
          "Today",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
      case WEEK:
        data = const Text(
          "Week",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
      case MONTH:
        data = const Text(
          "Month",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        );
        break;
    }
    return data;
  }

/*
  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 10:
        text = const Text('SEP', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '10K';
        break;
      case 3:
        text = '30k';
        break;
      case 5:
        text = '50k';
        break;
      case 10:
        text = '100k';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 5,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
        ),
      ],
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    verticalSize = MediaQuery.of(context).size.height; // 수직길이
    horizonSize = MediaQuery.of(context).size.width; // 수평길이
    return Container(
      // 아래 모서리 둥글게
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(30.0)),
        color: Colors.amber.withOpacity(1.0),
      ),
      height: verticalSize * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 가로 축 정렬
        children: [
          _textWidget(),
          _stateIcon(),
          _emotionScore(),
          _toggleButton()
        ],
      ),
    );
  }
}
