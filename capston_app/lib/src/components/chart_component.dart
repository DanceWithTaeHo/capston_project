import 'package:flutter/material.dart';

class ChartComponent extends StatelessWidget {
  late double verticalSize;
  late double horizonSize;
  late Color color;
  late String text;

  ChartComponent({Color color = Colors.amber, String text = "긍정감", Key? key})
      : super(key: key) {
    this.color = color;
    this.text = text;
  }

  _circleWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: color.withOpacity(1.0),
        ),
      ),
    );
  }

  Widget _textWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 15.0),
      child: Container(
        width: horizonSize * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
            Text(
              "25/30",
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 8.0,
                  fontFamily: "poppins"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _grapeWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
      child: Stack(children: [
        Container(
          width: horizonSize * 0.75,
          height: 15.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            color: Colors.grey.withOpacity(0.1),
          ),
        ),
        Container(
          width: horizonSize * 0.5,
          height: 15.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.5),
            gradient: LinearGradient(
              colors: [color.withOpacity(1.0), color.withOpacity(0.7)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    verticalSize = MediaQuery.of(context).size.height; // 수직길이
    horizonSize = MediaQuery.of(context).size.width; // 수평길이
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        width: horizonSize,
        height: 70.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Row(
          children: [
            _circleWidget(),
            Column(
              children: [_textWidget(), _grapeWidget()],
            )
          ],
        ),
      ),
    );
  }
}
