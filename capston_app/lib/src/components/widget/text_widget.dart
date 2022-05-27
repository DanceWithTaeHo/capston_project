import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  TextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 30,
            color: Colors.black.withOpacity(0.8),
            fontWeight: FontWeight.bold,
            fontFamily: "MalangMalang",
          ),
        ));
  }
}
