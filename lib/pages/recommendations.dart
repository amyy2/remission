import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/home.dart';
import 'package:remission/pages/recommendations.dart';

class RecommendationsPage extends StatelessWidget {
  final List pressedWords;
  const RecommendationsPage({Key? key, required this.pressedWords})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: double.infinity,
              child: Text(
                "Here are some tasks to choose from:",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ));
  }
}
