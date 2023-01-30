import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/explore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../colors.dart';

class PrintCFFListPage extends StatefulWidget {
  const PrintCFFListPage({super.key});

  @override
  State<PrintCFFListPage> createState() => _PrintCFFListState();
}

class _PrintCFFListState extends State<PrintCFFListPage> {
  final Uri _url =
      Uri.parse('https://www.ownyourcancercoaching.com/cancer-fighting-foods');

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ExplorePage(),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 232, 236, 252),
              ),
              width: 300.0,
              height: 200.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Print CFF list',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              width: double.infinity,
              child: const Text(
                  'Take a screenhot or print out the lists of CFFs (Cancer Fighting Foods) for easy access.  Circle or make a list of all the foods you don’t consume regularly but are willing to add more of to your diet on a regular basis.  Make a grocery list of those foods.',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15)),
            ),
            GestureDetector(
              onTap: _launchUrl,
              child: Container(
                padding:
                    EdgeInsets.only(top: 16, left: 20, right: 20, bottom: 16),
                width: double.infinity,
                child: const Text('Get list here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: MyColors.darkBlue)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Add task to goals',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.orange),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Mark as completed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
