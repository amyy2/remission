import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:remission/pages/profile/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../colors.dart';
import '../../services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';

import '../goals.dart';
import '../home/check-in.dart';
import '../home/words_page.dart';
import '../home/recommendations.dart';
import '../explore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static List completed = [];

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  List<QueryDocumentSnapshot<Map<String, dynamic>>> moods = [];
  final Map moodsMap = {};
  bool finished = false;

  Future getMoods() async {
    await FirebaseFirestore.instance
        .collection('mood_history')
        .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      setState(
        () {
          moods = snapshot.docs;
          for (var mood in moods) {
            moodsMap[DateFormat('yyyy-MMM-dd').format(
                    DateTime.parse(mood.data()['date'].toDate().toString()))] =
                mood.data()['mood'];
          }
          finished = true;
        },
      );
    });
  }

  Future getCompleted() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          ProfilePage.completed = snapshot.data()!['completed_tasks'];
        });
      }
    });
  }

  num points = 0;

  Future getPoints() async {
    //QuerySnapshot<Map<String, dynamic>> tasks = await FirebaseFirestore.instance.collection('tasks').get();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(
            () {
              points = snapshot.data()!['points'];
            },
          );
          for (var i = 0; i < ProfilePage.completed.length; i++) {
            var task = await FirebaseFirestore.instance
                .collection('tasks')
                .where("name", isEqualTo: ProfilePage.completed[i])
                .get();
            task.docs.forEach(
              (doc) {
                setState(() {
                  points += doc["points"];
                });
              },
            );
          }
        }
      },
    );
  }

  Future getUnlocked() async {
    print(FirebaseAuth.instance.currentUser!.email);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          ExplorePage.unlocked = snapshot.data()!['unlocked_tasks'];
        });
        print(ExplorePage.unlocked);
      }
    });
  }

  @override
  void initState() {
    getName();
    getMoods();
    getCompleted();
    getPoints();
    getUnlocked();
    super.initState();
  }

  Future<void> _pullToRefresh() async {
    getMoods();
    getName();
    getCompleted();
    getPoints();
  }

  Future<void> _signOut() async {
    CheckInPage.mood = '';
    CheckInPage.icon = '';
    CheckInPage.angryColor = Colors.black;
    CheckInPage.sadColor = Colors.black;
    CheckInPage.mehColor = Colors.black;
    CheckInPage.goodColor = Colors.black;
    CheckInPage.greatColor = Colors.black;
    WordsPage.pressed = [];
    RecommendationsPage.title1 = '';
    RecommendationsPage.description1 = '';
    RecommendationsPage.image1 = 'images/white.png';
    RecommendationsPage.title2 = '';
    RecommendationsPage.description2 = '';
    RecommendationsPage.image2 = 'images/white.png';
    await FirebaseAuth.instance.signOut();
    //clearUserData();
  }

  Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // clear all variables
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Profile',
            style: TextStyle(
                color: MyColors.orange,
                fontFamily: 'DancingScript',
                fontSize: 40)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: MyColors.darkBlue,
            ),
            padding: EdgeInsets.only(right: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SettingsPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  child: Text(
                    "Email: " + user.email!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        _signOut();
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return const WelcomeScreen();
                            },
                          ),
                          (_) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 232, 236, 252),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Sign out',
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
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 5),
                  width: double.infinity,
                  child: Text(
                    "Summary",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                TableCalendar(
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                  ),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  calendarBuilders: CalendarBuilders(
                    todayBuilder: (context, date, _) {
                      if (finished) {
                        if (moodsMap.containsKey(DateFormat('yyyy-MMM-dd')
                            .format(date)
                            .toString())) {
                          IconData icon = FontAwesomeIcons.faceMeh;
                          Color color = Colors.yellow;
                          switch (moodsMap[DateFormat('yyyy-MMM-dd')
                              .format(date)
                              .toString()]) {
                            case 'great':
                              {
                                icon = FontAwesomeIcons.faceGrin;
                                color = Colors.green;
                              }
                              break;
                            case 'good':
                              {
                                icon = FontAwesomeIcons.faceSmile;
                                color = Colors.orange;
                              }
                              break;
                            case 'meh':
                              {
                                icon = FontAwesomeIcons.faceMeh;
                                color = Colors.yellow;
                              }
                              break;
                            case 'sad':
                              {
                                icon = FontAwesomeIcons.faceSadTear;
                                color = Colors.blue;
                              }
                              break;
                            case 'angry':
                              {
                                icon = FontAwesomeIcons.faceAngry;
                                color = Colors.red;
                              }
                              break;
                          }
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(14),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: MyColors.lightBlue,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: FaIcon(
                                  icon,
                                  color: color,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                    },
                    defaultBuilder: (context, date, _) {
                      if (finished) {
                        if (moodsMap.containsKey(DateFormat('yyyy-MMM-dd')
                            .format(date)
                            .toString())) {
                          IconData icon = FontAwesomeIcons.faceMeh;
                          Color color = Colors.yellow;
                          switch (moodsMap[DateFormat('yyyy-MMM-dd')
                              .format(date)
                              .toString()]) {
                            case 'great':
                              {
                                icon = FontAwesomeIcons.faceGrin;
                                color = Colors.green;
                              }
                              break;
                            case 'good':
                              {
                                icon = FontAwesomeIcons.faceSmile;
                                color = Colors.orange;
                              }
                              break;
                            case 'meh':
                              {
                                icon = FontAwesomeIcons.faceMeh;
                                color = Colors.yellow;
                              }
                              break;
                            case 'sad':
                              {
                                icon = FontAwesomeIcons.faceSadTear;
                                color = Colors.blue;
                              }
                              break;
                            case 'angry':
                              {
                                icon = FontAwesomeIcons.faceAngry;
                                color = Colors.red;
                              }
                              break;
                          }
                          return Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.all(4),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: FaIcon(
                                  icon,
                                  color: color,
                                ),
                              ),
                            ],
                          );
                        }
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 40, bottom: 5),
                  width: double.infinity,
                  child: Text(
                    "My total points: " + points.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                /*
            Container(
              margin: const EdgeInsets.only(top: 0),
              child: const Image(
                  image: AssetImage('images/ribbon.png'), width: 500),
            ),
            */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
