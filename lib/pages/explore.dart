import 'dart:math';
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

import '../colors.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  static const title = 'Explore';

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 16, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Nutrition',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 13),
              height: 170.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Task('Print CFF list', 'Print list of Cancer Fighting Foods',
                      PrintCFFListPage()),
                  SizedBox(width: 20),
                  Task('Choose CFFs', 'Choose CFFs to add to your diet',
                      ChooseCFFPage()),
                  SizedBox(width: 20),
                  Task(
                      'Make grocery list',
                      'Choose 5 healthy food swaps for your grocery list',
                      MakeGroceryListPage()),
                  SizedBox(width: 20),
                  Task('Food journal', 'Start a daily food journal',
                      FoodJournalPage()),
                  SizedBox(width: 20),
                  Task('SMART goals', 'Identify SMART goals for dietary change',
                      DietarySMARTGoalsPage()),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Physical Movement',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 13),
              height: 170.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Task(
                      'SMART goals',
                      'Identify SMART goals for physical activity',
                      PhysicalSMARTGoalsPage()),
                  SizedBox(width: 20),
                  Task(
                      'Action plan',
                      'Make an action plan for the next seven days',
                      ActionPlanPage()),
                  SizedBox(width: 20),
                  Task('Staying motivated', 'Plan how to stay motivated',
                      StayingMotivatedPage()),
                  SizedBox(width: 20),
                  Task('Roadblocks', 'Plan how to overcome roadblocks',
                      RoadblocksPage()),
                  SizedBox(width: 20),
                  Task('Rewarding yourself', 'Plan how you\'ll reward yourself',
                      RewardingYourselfPage()),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Sleep Quality',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 13),
              height: 170.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Task('Sleep log', 'Create a sleep log for the next week',
                      SleepLogPage()),
                  SizedBox(width: 20),
                  Task('Sleep tips', 'Learn tips for better sleep',
                      SleepTipsPage()),
                  SizedBox(width: 20),
                  Task(
                      'Guided meditation I',
                      'A guided meditation before sleep',
                      GuidedMeditation1Page()),
                  SizedBox(width: 20),
                  Task('Journaling', 'An exercise to help you start journaling',
                      JournalingPage()),
                  SizedBox(width: 20),
                  Task(
                      'Guided meditation II',
                      'A guided meditation before sleep',
                      GuidedMeditation2Page()),
                  SizedBox(width: 20),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Stress Management',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(top: 13),
              height: 170.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 20),
                  Task('Problem solving', 'Description', null),
                  SizedBox(width: 20),
                  Task('Balance', 'Description', null),
                  SizedBox(width: 20),
                  Task('Coping with fears', 'Description', null),
                  SizedBox(width: 20),
                  Task('Gratitude', 'Description', null),
                  SizedBox(width: 20),
                  Task('Worry log', 'Description', null),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  GestureDetector Task(String title, String description, page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page,
          ),
        );
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 232, 236, 252),
            ),
            width: 150.0,
            height: 100.0,
          ),
          SizedBox(height: 2),
          Container(
            width: 150,
            height: 22,
            child: Text(title,
                textAlign: TextAlign.left, style: TextStyle(fontSize: 14)),
          ),
          Container(
            width: 150,
            height: 33,
            child: Text(description,
                textAlign: TextAlign.left, style: TextStyle(fontSize: 11)),
          ),
        ],
      ),
    );
  }
}
