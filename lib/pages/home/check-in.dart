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

class CheckInPage extends StatefulWidget {
  const CheckInPage({super.key});

  static const title = 'Home';

  @override
  State<CheckInPage> createState() => _CheckInPageState();
}

String _mood = '';
String _icon = '';
var _angry_color = Colors.black;
var _sad_color = Colors.black;
var _meh_color = Colors.black;
var _good_color = Colors.black;
var _great_color = Colors.black;

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
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const HomePage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ),
            );
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
                                _mood = 'angry';
                                _icon = 'faceAngry';
                                _angry_color = MyColors.mediumBlue;
                                _sad_color = Colors.black;
                                _meh_color = Colors.black;
                                _good_color = Colors.black;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: _mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceAngry,
                              size: 45,
                              color: _angry_color,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _mood = 'sad';
                                _icon = 'faceSadTear';
                                _angry_color = Colors.black;
                                _sad_color = MyColors.mediumBlue;
                                _meh_color = Colors.black;
                                _good_color = Colors.black;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: _mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceSadTear,
                              size: 45,
                              color: _sad_color,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _mood = 'meh';
                                _icon = 'faceMeh';
                                _angry_color = Colors.black;
                                _sad_color = Colors.black;
                                _meh_color = MyColors.mediumBlue;
                                _good_color = Colors.black;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: _mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceMeh,
                              size: 45,
                              color: _meh_color,
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _mood = 'good';
                                _icon = 'faceSmile';
                                _angry_color = Colors.black;
                                _sad_color = Colors.black;
                                _meh_color = Colors.black;
                                _good_color = MyColors.mediumBlue;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      WordsPage(feeling: _mood),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            icon: FaIcon(
                              FontAwesomeIcons.faceSmile,
                              size: 45,
                              color: _good_color,
                            )),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _mood = 'great';
                              _icon = 'faceGrin';
                              _angry_color = Colors.black;
                              _sad_color = Colors.black;
                              _meh_color = Colors.black;
                              _good_color = Colors.black;
                              _great_color = MyColors.mediumBlue;
                            });
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        WordsPage(feeling: _icon),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                            );
                          },
                          padding: EdgeInsets.zero,
                          icon: FaIcon(
                            FontAwesomeIcons.faceGrin,
                            size: 45,
                            color: _great_color,
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
