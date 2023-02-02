import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../colors.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  static const title = 'Tasks';

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
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
    getGoals();
    print(goals);
    super.initState();
  }

  Future<void> _pullToRefresh() async {
    getGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
          child: Column(
            children: <Widget>[for (var goal in goals) Text(goal)],
          ),
        ),
      ),
    );
  }
}
