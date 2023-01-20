import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/words_page.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const title = 'Home';

  @override
  State<HomePage> createState() => _HomePageState();
}

String _mood = '';
var _angry_color = Colors.black;
var _sad_color = Colors.black;
var _meh_color = Colors.black;
var _good_color = Colors.black;
var _great_color = Colors.black;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: Text('Home', style: TextStyle(color: Colors.grey)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              child: Text(
                "Welcome back, " + user.email!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(top: 20, bottom: 30),
                    width: double.infinity,
                    child: Text(
                      "How are you feeling?",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    padding: EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _mood = 'angry';
                                _angry_color = Colors.blueAccent;
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
                                          const WordsPage(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        return SlideTransition(
                                          position: animation.drive(tween),
                                          child: child,
                                        );
                                      }));
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
                                _angry_color = Colors.black;
                                _sad_color = Colors.blueAccent;
                                _meh_color = Colors.black;
                                _good_color = Colors.black;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WordsPage()));
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
                                _angry_color = Colors.black;
                                _sad_color = Colors.black;
                                _meh_color = Colors.blueAccent;
                                _good_color = Colors.black;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WordsPage()));
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
                                _angry_color = Colors.black;
                                _sad_color = Colors.black;
                                _meh_color = Colors.black;
                                _good_color = Colors.blueAccent;
                                _great_color = Colors.black;
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const WordsPage()));
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
                              _angry_color = Colors.black;
                              _sad_color = Colors.black;
                              _meh_color = Colors.black;
                              _good_color = Colors.black;
                              _great_color = Colors.blueAccent;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WordsPage()));
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
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              margin: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                    style: TextStyle(fontSize: 20),
                    'Today\'s motivational quote:\nIt\'s okay to not be okay',
                    textAlign: TextAlign.center),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _push() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => WordsPage()));
  }
}
