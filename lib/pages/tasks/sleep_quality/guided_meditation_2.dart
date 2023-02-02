import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class GuidedMeditation2Page extends StatefulWidget {
  const GuidedMeditation2Page({super.key});

  @override
  State<GuidedMeditation2Page> createState() => _GuidedMeditation2State();
}

class _GuidedMeditation2State extends State<GuidedMeditation2Page> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL:
            'https://www.youtube.com/watch?v=VQeoqqp5rVA&ab_channel=JasonStephenson-SleepMeditationMusic',
        title: 'Guided meditation II',
        description: 'Do this guided meditation before bed.',
        URLname: 'Meditation',
        dbName: 'guided_meditation_2');
  }
}
