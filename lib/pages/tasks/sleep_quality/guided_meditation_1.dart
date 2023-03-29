import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class GuidedMeditation1Page extends StatefulWidget {
  final String image;
  GuidedMeditation1Page({required this.image});

  @override
  State<GuidedMeditation1Page> createState() => _GuidedMeditation1State();
}

class _GuidedMeditation1State extends State<GuidedMeditation1Page> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL:
            'https://www.youtube.com/watch?v=69o0P7s8GHE&ab_channel=JasonStephenson-SleepMeditationMusic',
        title: 'Guided meditation I',
        description: 'Do this guided meditation before bed.',
        URLname: 'Click here for meditation',
        dbName: 'guided_meditation_1',
        image: widget.image);
  }
}
