import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/colors.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/home/recommendations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remission/recommendation_algorithm.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommendationsPage extends StatefulWidget {
  final List recommendedTasks;
  const RecommendationsPage({Key? key, required this.recommendedTasks})
      : super(key: key);

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  String title1 = '';
  String description1 = '';
  String title2 = '';
  String description2 = '';

  Future getData() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .where("name", isEqualTo: widget.recommendedTasks[0])
        .get()
        .then((snapshot) async {
      setState(() {
        title1 = snapshot.docs[0]["title"];
        description1 = snapshot.docs[0]["description"];
      });
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where("name", isEqualTo: widget.recommendedTasks[1])
        .get()
        .then((snapshot) async {
      setState(() {
        title2 = snapshot.docs[0]["title"];
        description2 = snapshot.docs[0]["description"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: double.infinity,
            child: Text(
              "Based on how you\'re feeling, here are some tasks to choose from:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: MyColors.mediumBlue,
            ),
            width: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text(
                    title1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Text(
                    description1,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 232, 236, 252),
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
              ],
            ),
          ),
          SizedBox(height: 60),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: MyColors.mediumBlue,
            ),
            width: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  child: Text(
                    title2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  width: double.infinity,
                  child: Text(
                    description2,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 232, 236, 252),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
