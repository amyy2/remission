import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/home/check-in.dart';
import 'package:remission/pages/home/words_page.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../colors.dart';

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
  String name = '';

  Future getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
        });
      }
    });
  }

  @override
  @override
  void initState() {
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Home',
            style: TextStyle(
                color: MyColors.orange,
                fontFamily: 'DancingScript',
                fontSize: 40)),
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Align(
          alignment: Alignment.topLeft,
          child: Image(image: AssetImage('images/ribbon_1.jpg'), width: 170),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 150, bottom: 20),
              width: double.infinity,
              child: Text(
                "Welcome back, $name",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CheckInPage(),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ));
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                width: double.infinity,
                margin: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: MyColors.orange,
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                ),
                child: const Center(
                  child: Text(
                      style: TextStyle(fontSize: 22, color: Colors.white),
                      'Daily check-in is unlocked',
                      textAlign: TextAlign.center),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              margin: const EdgeInsets.only(
                  top: 20, bottom: 20, left: 20, right: 20),
              decoration: BoxDecoration(
                color: MyColors.lightBlue,
                borderRadius: const BorderRadius.all(Radius.circular(22)),
              ),
              child: const Center(
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
        .push(MaterialPageRoute(builder: (context) => const WordsPage()));
  }
}
