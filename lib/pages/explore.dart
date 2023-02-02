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

  @override
  void initState() {
    getUnlocked();
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
                height: 170.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    Task(
                        'Print CFF list',
                        'Print list of Cancer Fighting Foods',
                        const PrintCFFListPage(),
                        'print_cff_list',
                        'images/task_thumbnails/1.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Choose CFFs',
                        'Choose CFFs to add to your diet',
                        const ChooseCFFPage(),
                        'choose_cffs',
                        'images/task_thumbnails/2.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Make grocery list',
                        'Choose 5 healthy food swaps for your grocery list',
                        const MakeGroceryListPage(),
                        'make_grocery_list',
                        'images/task_thumbnails/3.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Food journal',
                        'Start a daily food journal',
                        const FoodJournalPage(),
                        'food_journal',
                        'images/task_thumbnails/4.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'SMART goals',
                        'Identify SMART goals for dietary change',
                        const DietarySMARTGoalsPage(),
                        'dietary_smart_goals',
                        'images/task_thumbnails/5.jpg'),
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
                height: 170.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    Task(
                        'SMART goals',
                        'Identify SMART goals for physical activity',
                        const PhysicalSMARTGoalsPage(),
                        'physical_smart_goals',
                        'images/task_thumbnails/6.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Action plan',
                        'Make an action plan for the next seven days',
                        const ActionPlanPage(),
                        'action_plan',
                        'images/task_thumbnails/7.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Staying motivated',
                        'Plan how to stay motivated',
                        const StayingMotivatedPage(),
                        'staying_motivated',
                        'images/task_thumbnails/8.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Roadblocks',
                        'Plan how to overcome roadblocks',
                        const RoadblocksPage(),
                        'roadblocks',
                        'images/task_thumbnails/9.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Rewarding yourself',
                        'Plan how you\'ll reward yourself',
                        const RewardingYourselfPage(),
                        'rewarding_yourself',
                        'images/task_thumbnails/10.jpg'),
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
                height: 170.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    Task(
                        'Sleep log',
                        'Create a sleep log for the next week',
                        const SleepLogPage(),
                        'sleep_log',
                        'images/task_thumbnails/11.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Sleep tips',
                        'Learn tips for better sleep',
                        const SleepTipsPage(),
                        'sleep_tips',
                        'images/task_thumbnails/12.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Meditation I',
                        'A guided meditation before sleep',
                        const GuidedMeditation1Page(),
                        'guided_meditation_1',
                        'images/task_thumbnails/13.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Journaling',
                        'An exercise to help you start journaling',
                        const JournalingPage(),
                        'journaling',
                        'images/task_thumbnails/14.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Meditation II',
                        'A guided meditation before sleep',
                        const GuidedMeditation2Page(),
                        'guided_meditation_2',
                        'images/task_thumbnails/15.jpg'),
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
                height: 170.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(width: 20),
                    Task(
                        'Problem solving',
                        'Description',
                        const ProblemSolvingPage(),
                        'problem_solving',
                        'images/task_thumbnails/16.jpg'),
                    const SizedBox(width: 20),
                    Task('Balance', 'Description', const BalancePage(),
                        'balance', 'images/task_thumbnails/17.jpg'),
                    const SizedBox(width: 20),
                    Task(
                        'Coping with fears',
                        'Description',
                        const CopingWithFearsPage(),
                        'coping_with_fears',
                        'images/task_thumbnails/18.jpg'),
                    const SizedBox(width: 20),
                    Task('Gratitude', 'Description', const GratitudePage(),
                        'gratitude', 'images/task_thumbnails/19.jpg'),
                    const SizedBox(width: 20),
                    Task('Worry log', 'Description', const WorryLogPage(),
                        'worry_log', 'images/task_thumbnails/20.jpg'),
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
            height: 33,
            child: Text(description,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
