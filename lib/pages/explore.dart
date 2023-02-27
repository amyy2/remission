import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/tasks/nutrition/choose_cff.dart';
import 'package:remission/pages/tasks/nutrition/food_journal.dart';
import 'package:remission/pages/tasks/nutrition/make_grocery_list.dart';
import 'package:remission/pages/tasks/nutrition/print_cff_list.dart';
import 'package:remission/pages/tasks/nutrition/dietary_smart_goals.dart';
import 'package:remission/pages/tasks/physical_movement/action_plan.dart';
import 'package:remission/pages/tasks/physical_movement/physical_smart_goals.dart';
import 'package:remission/pages/tasks/physical_movement/rewarding_yourself.dart';
import 'package:remission/pages/tasks/physical_movement/roadblocks.dart';
import 'package:remission/pages/tasks/physical_movement/staying_motivated.dart';
import 'package:remission/pages/tasks/sleep_quality/guided_meditation_1.dart';
import 'package:remission/pages/tasks/sleep_quality/guided_meditation_2.dart';
import 'package:remission/pages/tasks/sleep_quality/journaling.dart';
import 'package:remission/pages/tasks/sleep_quality/sleep_log.dart';
import 'package:remission/pages/tasks/sleep_quality/sleep_tips.dart';
import 'package:remission/pages/tasks/stress_management/balance.dart';
import 'package:remission/pages/tasks/stress_management/coping_with_fears.dart';
import 'package:remission/pages/tasks/stress_management/gratitude.dart';
import 'package:remission/pages/tasks/stress_management/problem_solving.dart';
import 'package:remission/pages/tasks/stress_management/worry_log.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../colors.dart';

void addToCompleted(List task) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'completed_tasks': FieldValue.arrayUnion(task)});
    }
  });
}

void removeFromCompleted(List task) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'completed_tasks': FieldValue.arrayRemove(task)});
    }
  });
}

void addToGoals(List task) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'goals': FieldValue.arrayUnion(task)});
    }
  });
}

void removeFromGoals(List task) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'goals': FieldValue.arrayRemove(task)});
    }
  });
}

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static const title = 'Explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List unlocked = [];

  Future getUnlocked() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          unlocked = snapshot.data()!['unlocked_tasks'];
        });
      }
    });
  }

  List<QueryDocumentSnapshot<Map<String, dynamic>>> tasks = [];
  Map tasksMap = {};
  String image = 'images/white.png';
  bool finished = false;

  Future getData() async {
    await FirebaseFirestore.instance.collection('tasks').get().then(
      (snapshot) async {
        setState(
          () {
            tasks = snapshot.docs;
            for (var task in tasks) {
              tasksMap[task.data()['title']] = task.data();
              finished = true;
            }
          },
        );
      },
    );
  }

  @override
  void initState() {
    getUnlocked();
    getData();
    super.initState();
  }

  Future<void> _pullToRefresh() async {
    getUnlocked();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Explore',
            style: TextStyle(
                color: MyColors.orange,
                fontFamily: 'DancingScript',
                fontSize: 40)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _pullToRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 22,
                child: Text('Use the Daily Check-In to unlock tasks',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
                width: double.infinity,
                child: const Text('Nutrition',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 13),
                height: 190.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Print CFF list']['title'],
                          tasksMap['Print CFF list']['description'],
                          PrintCFFListPage(
                              image: tasksMap['Print CFF list']['image']),
                          tasksMap['Print CFF list']['name'],
                          tasksMap['Print CFF list']['image']),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Choose CFFs']['title'],
                          tasksMap['Choose CFFs']['description'],
                          ChooseCFFPage(
                              image: tasksMap['Choose CFFs']['image']),
                          tasksMap['Choose CFFs']['name'],
                          tasksMap['Choose CFFs']['image']),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Make grocery list']['title'],
                          tasksMap['Make grocery list']['description'],
                          MakeGroceryListPage(
                              image: tasksMap['Make grocery list']['image']),
                          tasksMap['Make grocery list']['name'],
                          tasksMap['Make grocery list']['image']),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Food journal']['title'],
                          tasksMap['Food journal']['description'],
                          FoodJournalPage(
                              image: tasksMap['Food journal']['image']),
                          tasksMap['Food journal']['name'],
                          tasksMap['Food journal']['image']),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Dietary SMART goals']['title'],
                          tasksMap['Dietary SMART goals']['description'],
                          DietarySMARTGoalsPage(
                              image: tasksMap['Dietary SMART goals']['image']),
                          tasksMap['Dietary SMART goals']['name'],
                          tasksMap['Dietary SMART goals']['image']),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                width: double.infinity,
                child: const Text('Physical Movement',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 13),
                height: 190.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Physical SMART goals']['title'],
                        tasksMap['Physical SMART goals']['description'],
                        PhysicalSMARTGoalsPage(
                          image: tasksMap['Physical SMART goals']['image'],
                        ),
                        tasksMap['Physical SMART goals']['name'],
                        tasksMap['Physical SMART goals']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                          tasksMap['Action plan']['title'],
                          tasksMap['Action plan']['description'],
                          ActionPlanPage(
                              image: tasksMap['Action plan']['image']),
                          tasksMap['Action plan']['name'],
                          tasksMap['Action plan']['image']),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Staying motivated']['title'],
                        tasksMap['Staying motivated']['description'],
                        StayingMotivatedPage(
                          image: tasksMap['Staying motivated']['image'],
                        ),
                        tasksMap['Staying motivated']['name'],
                        tasksMap['Staying motivated']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Roadblocks']['title'],
                        tasksMap['Roadblocks']['description'],
                        RoadblocksPage(image: tasksMap['Roadblocks']['image']),
                        tasksMap['Roadblocks']['name'],
                        tasksMap['Roadblocks']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Rewarding yourself']['title'],
                        tasksMap['Rewarding yourself']['description'],
                        RewardingYourselfPage(
                            image: tasksMap['Rewarding yourself']['image']),
                        tasksMap['Rewarding yourself']['name'],
                        tasksMap['Rewarding yourself']['image'],
                      ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                width: double.infinity,
                child: const Text('Sleep Quality',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 13),
                height: 190.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Sleep log']['title'],
                        tasksMap['Sleep log']['description'],
                        SleepLogPage(
                          image: tasksMap['Sleep log']['image'],
                        ),
                        tasksMap['Sleep log']['name'],
                        tasksMap['Sleep log']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Sleep tips']['title'],
                        tasksMap['Sleep tips']['description'],
                        SleepTipsPage(image: tasksMap['Sleep tips']['image']),
                        tasksMap['Sleep tips']['name'],
                        tasksMap['Sleep tips']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Meditation I']['title'],
                        tasksMap['Meditation I']['description'],
                        GuidedMeditation1Page(
                            image: tasksMap['Meditation I']['image']),
                        tasksMap['Meditation I']['name'],
                        tasksMap['Meditation I']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Journaling']['title'],
                        tasksMap['Journaling']['description'],
                        JournalingPage(image: tasksMap['Journaling']['image']),
                        tasksMap['Journaling']['name'],
                        tasksMap['Journaling']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Meditation II']['title'],
                        tasksMap['Meditation II']['description'],
                        GuidedMeditation2Page(
                            image: tasksMap['Meditation II']['image']),
                        tasksMap['Meditation II']['name'],
                        tasksMap['Meditation II']['image'],
                      ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                width: double.infinity,
                child: const Text('Stress Management',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 13),
                height: 190.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Problem solving']['title'],
                        tasksMap['Problem solving']['description'],
                        ProblemSolvingPage(
                            image: tasksMap['Problem solving']['image']),
                        tasksMap['Problem solving']['name'],
                        tasksMap['Problem solving']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Balance']['title'],
                        tasksMap['Balance']['description'],
                        BalancePage(image: tasksMap['Balance']['image']),
                        tasksMap['Balance']['name'],
                        tasksMap['Balance']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Coping with fears']['title'],
                        tasksMap['Coping with fears']['description'],
                        CopingWithFearsPage(
                            image: tasksMap['Coping with fears']['image']),
                        tasksMap['Coping with fears']['name'],
                        tasksMap['Coping with fears']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Gratitude']['title'],
                        tasksMap['Gratitude']['description'],
                        GratitudePage(image: tasksMap['Gratitude']['image']),
                        tasksMap['Gratitude']['name'],
                        tasksMap['Gratitude']['image'],
                      ),
                    const SizedBox(width: 20),
                    if (finished)
                      Task(
                        tasksMap['Worry log']['title'],
                        tasksMap['Worry log']['description'],
                        WorryLogPage(image: tasksMap['Worry log']['image']),
                        tasksMap['Worry log']['name'],
                        tasksMap['Worry log']['image'],
                      ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector Task(
      String title, String description, page, String task_name, String image) {
    return GestureDetector(
      onTap: () {
        unlocked.contains(task_name)
            ? Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => page,
                ),
              )
            : null;
      },
      child: Column(
        children: [
          Container(
            width: 150.0,
            height: 100.0,
            child: AspectRatio(
              aspectRatio: 150 / 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: AssetImage(image),
                  )),
                ),
              ),
            ),
          ),
          const SizedBox(height: 2),
          unlocked.contains(task_name)
              ? Container(
                  width: 150,
                  height: 22,
                  child: Text(title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 14)),
                )
              : Container(
                  width: 150,
                  height: 22,
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        const WidgetSpan(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.lock_outline,
                              size: 15,
                            ),
                          ),
                        ),
                        TextSpan(
                            text: ' ' + title,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
          Container(
            width: 150,
            height: 53,
            child: Text(description,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
