import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class IssueIconWidget extends StatelessWidget {
  late String text;
  late String iconName;
  late bool isImage;

  IssueIconWidget(
      {required this.text, required this.iconName, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    const double paddingValue = 15.0;
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 20.0, left: paddingValue, right: paddingValue),
      child: Column(
        children: [
          isImage
              ? Image.asset(
                  'assets/icons/${iconName}',
                  width: 90,
                  height: 90,
                )
              : SvgPicture.asset(
                  'assets/icons/${iconName}',
                  width: 90,
                  height: 90,
                ),
          Text(
            text,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
