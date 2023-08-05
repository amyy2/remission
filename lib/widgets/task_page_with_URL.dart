import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remission/pages/explore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../colors.dart';

class TaskPageWithURL extends StatefulWidget {
  final String URL;
  final String title;
  final String description;
  final String URLname;
  final String dbName;
  final String image;

  const TaskPageWithURL(
      {super.key,
      required this.URL,
      required this.title,
      required this.description,
      required this.URLname,
      required this.dbName,
      required this.image});

  @override
  State<TaskPageWithURL> createState() => _TaskState();
}

class _TaskState extends State<TaskPageWithURL> {
  late final Uri _url = Uri.parse(widget.URL);

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  List completed = [];

  Future getCompleted() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          completed = snapshot.data()!['completed_tasks'];
        });
      }
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
    getCompleted();
    getGoals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
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
            SizedBox(
              width: 300.0,
              height: 200.0,
              child: AspectRatio(
                aspectRatio: 300 / 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.center,
                      image: AssetImage(widget.image),
                    )),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              width: double.infinity,
              child: Text(widget.title,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: const EdgeInsets.only(top: 16, left: 20, right: 20),
              width: double.infinity,
              child: Text(widget.description,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 15)),
            ),
            GestureDetector(
              onTap: _launchUrl,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 16, left: 20, right: 20, bottom: 16),
                width: double.infinity,
                child: Text(widget.URLname,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                  onPressed: () {
                    goals.contains(widget.dbName)
                        ? {
                            removeFromGoals([widget.dbName]),
                            getGoals()
                          }
                        : {
                            addToGoals([widget.dbName], context),
                            getGoals()
                          };
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: goals.contains(widget.dbName)
                      ? const Text(
                          'Remove task from goals',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: MyColors.orange),
                        )
                      : const Text(
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
                  onPressed: () {
                    completed.contains(widget.dbName)
                        ? {
                            removeFromCompleted([widget.dbName]),
                            getCompleted()
                          }
                        : {
                            addToCompleted([widget.dbName]),
                            getCompleted()
                          };
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: completed.contains(widget.dbName)
                      ? const Text(
                          'Mark as incomplete',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: MyColors.orange),
                        )
                      : const Text(
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
