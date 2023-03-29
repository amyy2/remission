import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/colors.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/explore.dart';
import 'package:remission/pages/home/recommendations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:remission/recommendation_algorithm.dart';
import 'package:firebase_auth/firebase_auth.dart';

export '../home/recommendations.dart';

class RecommendationsPage extends StatefulWidget {
  final String feeling;
  final List recommendedTasks;
  const RecommendationsPage(
      {Key? key, required this.feeling, required this.recommendedTasks})
      : super(key: key);

  static String title1 = '';
  static String description1 = '';
  static String image1 = 'images/white.png';
  static String title2 = '';
  static String description2 = '';
  static String image2 = 'images/white.png';

  @override
  State<RecommendationsPage> createState() => _RecommendationsPageState();
}

void addToGoals(List task) async {
  FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .update({'goals': FieldValue.arrayUnion(task)});
}

void addMood(String mood, DateTime date) async {
  FirebaseFirestore.instance.collection('mood_history').doc().set({
    'user_id': FirebaseAuth.instance.currentUser!.uid,
    'mood': mood,
    'date': date,
  });
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  Future getData() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .where("name", isEqualTo: widget.recommendedTasks[0])
        .get()
        .then((snapshot) async {
      setState(() {
        RecommendationsPage.title1 = snapshot.docs[0]["title"];
        RecommendationsPage.description1 = snapshot.docs[0]["description"];
        RecommendationsPage.image1 = snapshot.docs[0]["image"];
      });
    });
    await FirebaseFirestore.instance
        .collection('tasks')
        .where("name", isEqualTo: widget.recommendedTasks[1])
        .get()
        .then((snapshot) async {
      setState(() {
        RecommendationsPage.title2 = snapshot.docs[0]["title"];
        RecommendationsPage.description2 = snapshot.docs[0]["description"];
        RecommendationsPage.image2 = snapshot.docs[0]["image"];
      });
    });
  }

  List goals = [];

  Future getGoals() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          goals = snapshot.data()!['goals'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
    addMood(
      widget.feeling,
      DateTime.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            null;
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            width: double.infinity,
            child: Text(
              "Here are some recommended tasks, based on how you're feeling today",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 300.0,
            height: 200.0,
            child: AspectRatio(
              aspectRatio: 300 / 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.center,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        image: AssetImage(RecommendationsPage.image1),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        RecommendationsPage.title1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        RecommendationsPage.description1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              goals.contains(widget.recommendedTasks[0])
                                  ? {
                                      removeFromGoals(
                                          [widget.recommendedTasks[0]]),
                                      getGoals()
                                    }
                                  : {
                                      addToGoals([widget.recommendedTasks[0]]),
                                      getGoals()
                                    };
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 232, 236, 252),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50))),
                            child: goals.contains(widget.recommendedTasks[0])
                                ? Text(
                                    'Remove task from goals',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: MyColors.orange),
                                  )
                                : Text(
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
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 300.0,
            height: 200.0,
            child: AspectRatio(
              aspectRatio: 300 / 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        alignment: FractionalOffset.center,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.dstATop),
                        image: AssetImage(RecommendationsPage.image2),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        RecommendationsPage.title2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        RecommendationsPage.description2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10),
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: OutlinedButton(
                            onPressed: () {
                              goals.contains(widget.recommendedTasks[1])
                                  ? {
                                      removeFromGoals(
                                          [widget.recommendedTasks[1]]),
                                      getGoals()
                                    }
                                  : {
                                      addToGoals([widget.recommendedTasks[1]]),
                                      getGoals()
                                    };
                            },
                            style: OutlinedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 232, 236, 252),
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        width: 0, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.circular(50))),
                            child: goals.contains(widget.recommendedTasks[1])
                                ? Text(
                                    'Remove task from goals',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: MyColors.orange),
                                  )
                                : Text(
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
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: 400,
            child: Text(
                'Want to complete these tasks later? Add them to your goals on the Explore Page',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
