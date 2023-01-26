import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/home/recommendations.dart';

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
          backgroundColor: _pressed.contains(widget.word)
              ? Color.fromARGB(255, 225, 225, 255)
              : Colors.white),
      onPressed: () {
        setState(() {
          if (_pressed.length < 3) {
            setState(() {
              maximum_reached = false;
            });
            if (_pressed.contains(widget.word)) {
              _pressed.remove(widget.word);
            } else {
              _pressed.add(widget.word);
            }
          } else {
            setState(() {
              maximum_reached = true;
            });
            if (_pressed.contains(widget.word)) {
              _pressed.remove(widget.word);
            }
          }
        });
      },
      child: Text(
        widget.word,
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }
}

class WordsPage extends StatefulWidget {
  const WordsPage({super.key});

  @override
  State<WordsPage> createState() => _WordsPageState();
}

var _pressed = [];

class _WordsPageState extends State<WordsPage> {
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
            padding: EdgeInsets.only(top: 10, bottom: 10),
            width: double.infinity,
            child: Text(
              "Which words describe how \nyou're feeling?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 60),
            width: double.infinity,
            child: Text(
              "Choose up to 3",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'sad'),
                WordButton(word: 'anxious'),
                WordButton(word: 'energetic'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'angry'),
                WordButton(word: 'lethargic'),
                WordButton(word: 'tired'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'depressed'),
                WordButton(word: 'happy'),
                WordButton(word: 'grateful'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'achy'),
                WordButton(word: 'constipated'),
                WordButton(word: 'bloated'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'moody'),
                WordButton(word: 'hopeful'),
                WordButton(word: 'peaceful'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'loved'),
                WordButton(word: 'helpless'),
                WordButton(word: 'stressed'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'fearful'),
                WordButton(word: 'worried'),
                WordButton(word: 'lonely'),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                WordButton(word: 'frustrated'),
                WordButton(word: 'nauseous'),
                WordButton(word: 'hormonal'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: TextButton(
              onPressed: () {
                setState(() {});
                if (_pressed.length > 1) {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  RecommendationsPage(pressedWords: _pressed),
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
                          }));
                }
              },
              child: Text(
                'Next',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
