import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/home/words_page.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../colors.dart';

export '../home/check-in.dart';

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  static const title = 'Home';
  static String mood = '';
  static String icon = '';
  static var angryColor = Colors.black;
  static var sadColor = Colors.black;
  static var mehColor = Colors.black;
  static var goodColor = Colors.black;
  static var greatColor = Colors.black;

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.only(left: 20, top: 20),
            child: const Icon(
              (Icons.arrow_back),
              size: 30,
              color: MyColors.orange,
            ),
          ),
        ),
        scrolledUnderElevation: 3,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 150),
          Container(
            margin: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    width: double.infinity,
                    child: const Text(
                      "Let\'s get started on today's daily check-in.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    width: double.infinity,
                    child: const Text(
                      "How are you feeling?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  duration: Duration(seconds: 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                CheckInPage.mood = 'angry';
                                CheckInPage.icon = 'faceAngry';
                                CheckInPage.angryColor = MyColors.mediumBlue;
                                CheckInPage.sadColor = Colors.black;
                                CheckInPage.mehColor = Colors.black;
                                CheckInPage.goodColor = Colors.black;
                                CheckInPage.greatColor = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: CheckInPage.mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceAngry,
                              size: 45,
                              color: CheckInPage.angryColor,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                CheckInPage.mood = 'sad';
                                CheckInPage.icon = 'faceSadTear';
                                CheckInPage.angryColor = Colors.black;
                                CheckInPage.sadColor = MyColors.mediumBlue;
                                CheckInPage.mehColor = Colors.black;
                                CheckInPage.goodColor = Colors.black;
                                CheckInPage.greatColor = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: CheckInPage.mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceSadTear,
                              size: 45,
                              color: CheckInPage.sadColor,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                CheckInPage.mood = 'meh';
                                CheckInPage.icon = 'faceMeh';
                                CheckInPage.angryColor = Colors.black;
                                CheckInPage.sadColor = Colors.black;
                                CheckInPage.mehColor = MyColors.mediumBlue;
                                CheckInPage.goodColor = Colors.black;
                                CheckInPage.greatColor = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: CheckInPage.mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceMeh,
                              size: 45,
                              color: CheckInPage.mehColor,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                CheckInPage.mood = 'good';
                                CheckInPage.icon = 'faceSmile';
                                CheckInPage.angryColor = Colors.black;
                                CheckInPage.sadColor = Colors.black;
                                CheckInPage.mehColor = Colors.black;
                                CheckInPage.goodColor = MyColors.mediumBlue;
                                CheckInPage.greatColor = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: CheckInPage.mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              size: 45,
                              color: CheckInPage.goodColor,
                            )),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              CheckInPage.mood = 'great';
                              CheckInPage.icon = 'faceGrin';
                              CheckInPage.angryColor = Colors.black;
                              CheckInPage.sadColor = Colors.black;
                              CheckInPage.mehColor = Colors.black;
                              CheckInPage.goodColor = Colors.black;
                              CheckInPage.greatColor = MyColors.mediumBlue;
                            });
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        WordsPage(feeling: CheckInPage.mood),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: FaIcon(
                            FontAwesomeIcons.faceGrin,
                            size: 45,
                            color: CheckInPage.greatColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
