import 'package:capston_app/src/components/bottom_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/top_container.dart';
import 'controller/app_controller.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [TopContainer(), Flexible(child: BottomContainer())],
      ),
    );
  }
}
