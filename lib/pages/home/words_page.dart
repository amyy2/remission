import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remission/pages/home/recommendations.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../colors.dart';
import '../../recommendation_algorithm.dart';

export '../home/words_page.dart';

class WordButton extends StatefulWidget {
  final String word;

  const WordButton({Key? key, required this.word}) : super(key: key);

  @override
  State<WordButton> createState() => _WordButtonState();
}

bool maximum_reached = false;

class _WordButtonState extends State<WordButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 0, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(50)),
          backgroundColor: WordsPage.pressed.contains(widget.word)
              ? const Color.fromARGB(255, 232, 236, 252)
              : Colors.white),
      onPressed: () {
        setState(() {
          if (WordsPage.pressed.length < 3) {
            setState(() {
              maximum_reached = false;
            });
            if (WordsPage.pressed.contains(widget.word)) {
              WordsPage.pressed.remove(widget.word);
            } else {
              WordsPage.pressed.add(widget.word);
            }
          } else {
            setState(() {
              maximum_reached = true;
            });
            if (WordsPage.pressed.contains(widget.word)) {
              WordsPage.pressed.remove(widget.word);
            }
          }
        });
      },
      child: Text(
        widget.word,
        style: TextStyle(
            color: WordsPage.pressed.contains(widget.word)
                ? MyColors.orange
                : Colors.black,
            fontSize: 14),
      ),
    );
  }
}

class WordsPage extends StatefulWidget {
  final String feeling;
  const WordsPage({Key? key, required this.feeling}) : super(key: key);

  static var pressed = [];

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  List unlocked = [];

  Future getUnlocked() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (snapshot) async {
        if (snapshot.exists) {
          setState(
            () {
              unlocked = snapshot.data()!['unlocked_tasks'];
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
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
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: const Text(
              "Which words describe how \nyou're feeling?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            width: double.infinity,
            child: const Text(
              "Choose up to 3",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'sad'),
                WordButton(word: 'anxious'),
                WordButton(word: 'energetic'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'angry'),
                WordButton(word: 'lethargic'),
                WordButton(word: 'tired'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'depressed'),
                WordButton(word: 'happy'),
                WordButton(word: 'grateful'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'stressed'),
                WordButton(word: 'fearful'),
                WordButton(word: 'worried'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'achy'),
                WordButton(word: 'constipated'),
                WordButton(word: 'bloated'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'moody'),
                WordButton(word: 'hopeful'),
                WordButton(word: 'peaceful'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'loved'),
                WordButton(word: 'helpless'),
                WordButton(word: 'lonely'),
              ],
            ),
          ),
          Container(
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'frustrated'),
                WordButton(word: 'nauseous'),
                WordButton(word: 'hormonal'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: OutlinedButton(
              onPressed: () async {
                getUnlocked();
                List tasks = await recommendationAlgorithm(
                    FirebaseFirestore.instance,
                    'tasks',
                    WordsPage.pressed,
                    unlocked);
                setState(() {});
                if (WordsPage.pressed.isNotEmpty) {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          RecommendationsPage(
                              feeling: widget.feeling, recommendedTasks: tasks),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                  shape: RoundedRectangleBorder(
                      side:
                          const BorderSide(width: 0, style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                'Next',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: MyColors.orange),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
