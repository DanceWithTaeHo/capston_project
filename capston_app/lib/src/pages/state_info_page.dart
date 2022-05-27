import 'package:capston_app/src/components/container/bottom_container.dart';
import 'package:capston_app/src/components/widget/feedback_list_component.dart';
import 'package:capston_app/src/components/widget/navigator_widget.dart';
import 'package:capston_app/src/components/widget/issue_icon_list_component.dart';
import 'package:capston_app/src/components/widget/text_widget.dart';
import 'package:capston_app/src/components/container/top_container.dart';
import 'package:capston_app/src/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'base_page.dart';

class StateInfoPage extends GetView<AppController> {
  @override
  Widget build(BuildContext context) {
    return BasePage(
      topContainer: TopContainer.stateInfo(
        color: Colors.pink.withOpacity(0.5),
        navigatorWidget: NavigatorWidget.stateInfo(),
        textWidget: TextWidget(
          text: "환자 상태 분석",
        ),
        issueIconWidget: IssueIconListComponent(),
      ),
      bottomContainer: BottomContainer.stateInfo(
        listView: FeedbackListComponent(),
      ),
    );
  }
}
