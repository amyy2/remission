import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remission/pages/explore.dart';
import 'package:remission/pages/tasks/nutrition/choose_cff.dart';
import 'package:remission/pages/tasks/nutrition/dietary_smart_goals.dart';
import 'package:remission/pages/tasks/nutrition/food_journal.dart';
import 'package:remission/pages/tasks/nutrition/make_grocery_list.dart';
import 'package:remission/pages/tasks/nutrition/print_cff_list.dart';
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
import 'package:visibility_detector/visibility_detector.dart';

import '../colors.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  static const title = 'Tasks';

  static List goals = [];

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  Future getGoals() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          GoalsPage.goals = snapshot.data()!['goals'];
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
              tasksMap[task.data()['name']] = task.data();
            }
            pageLinks['dietary_smart_goals'] = DietarySMARTGoalsPage(
                image: tasksMap['dietary_smart_goals']['image']);
            pageLinks['print_cff_list'] =
                PrintCFFListPage(image: tasksMap['print_cff_list']['image']);
            pageLinks['make_grocery_list'] = MakeGroceryListPage(
                image: tasksMap['make_grocery_list']['image']);
            pageLinks['choose_cffs'] =
                ChooseCFFPage(image: tasksMap['choose_cffs']['image']);
            pageLinks['food_journal'] =
                FoodJournalPage(image: tasksMap['food_journal']['image']);
            pageLinks['rewarding_yourself'] = RewardingYourselfPage(
                image: tasksMap['rewarding_yourself']['image']);
            pageLinks['physical_smart_goals'] = PhysicalSMARTGoalsPage(
                image: tasksMap['physical_smart_goals']['image']);
            pageLinks['staying_motivated'] = StayingMotivatedPage(
                image: tasksMap['staying_motivated']['image']);
            pageLinks['roadblocks'] =
                RoadblocksPage(image: tasksMap['roadblocks']['image']);
            pageLinks['action_plan'] =
                ActionPlanPage(image: tasksMap['action_plan']['image']);
            pageLinks['sleep_tips'] =
                SleepTipsPage(image: tasksMap['sleep_tips']['image']);
            pageLinks['guided_meditation_1'] = GuidedMeditation1Page(
                image: tasksMap['guided_meditation_1']['image']);
            pageLinks['sleep_log'] =
                SleepLogPage(image: tasksMap['sleep_log']['image']);
            pageLinks['guided_meditation_2'] = GuidedMeditation2Page(
                image: tasksMap['guided_meditation_2']['image']);
            pageLinks['journaling'] =
                JournalingPage(image: tasksMap['journaling']['image']);
            pageLinks['coping_with_fears'] = CopingWithFearsPage(
                image: tasksMap['coping_with_fears']['image']);
            pageLinks['balance'] =
                BalancePage(image: tasksMap['balance']['image']);
            pageLinks['problem_solving'] =
                ProblemSolvingPage(image: tasksMap['problem_solving']['image']);
            pageLinks['gratitude'] =
                GratitudePage(image: tasksMap['gratitude']['image']);
            pageLinks['worry_log'] =
                WorryLogPage(image: tasksMap['worry_log']['image']);
            finished = true;
          },
        );
      },
    );
  }

  Map pageLinks = {};

  @override
  void initState() {
    getGoals();
    getData();
    super.initState();
  }

  Future<void> _pullToRefresh() async {
    getGoals();
  }

  static String id = 'goalsPage';

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(_GoalsPageState.id),
      onVisibilityChanged: (VisibilityInfo info) {
        bool isVisible = info.visibleFraction != 0;
        getGoals();
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          scrolledUnderElevation: 3,
          title: const Text('My Goals',
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
            physics: const AlwaysScrollableScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  if (finished)
                    if (GoalsPage.goals.isEmpty)
                      const Column(children: [
                        SizedBox(height: 20),
                        Text(
                          'Add some tasks from the explore page',
                          style: TextStyle(fontSize: 18),
                        )
                      ])
                    else
                      for (var goal in GoalsPage.goals)
                        Column(
                          children: [
                            const SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        pageLinks[goal],
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 350.0,
                                height: 75.0,
                                child: AspectRatio(
                                  aspectRatio: 300 / 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(22),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 232, 232, 232),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '    ' + tasksMap[goal]['title'],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                removeFromGoals([goal]);
                                                getGoals();
                                              },
                                              icon: const FaIcon(
                                                FontAwesomeIcons.x,
                                                size: 20,
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
