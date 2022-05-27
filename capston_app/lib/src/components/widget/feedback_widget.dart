import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FeedbackWidget extends StatelessWidget {
  late double verticalSize;
  late double horizonSize;
  late String text;
  late String iconName;
  late bool isImage;
  FeedbackWidget(
      {required this.text,
      required this.iconName,
      this.isImage = false,
      Key? key})
      : super(key: key) {}

  _iconWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 5.0),
      child: isImage
          ? Image.asset(
              'assets/icons/${iconName}',
              width: 75,
              height: 75,
            )
          : SvgPicture.asset(
              'assets/icons/${iconName}',
              width: 75,
              height: 75,
            ),
    );
  }

  Widget _textWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Container(
        width: horizonSize * 0.7,
        child: Text(text,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
      ),
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
            _iconWidget(),
            _textWidget(),
          ],
        ),
      ),
    );
  }
}
