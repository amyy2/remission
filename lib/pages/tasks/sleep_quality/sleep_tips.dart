import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class SleepTipsPage extends StatefulWidget {
  const SleepTipsPage({super.key});

  @override
  State<SleepTipsPage> createState() => _SleepTipsState();
}

class _SleepTipsState extends State<SleepTipsPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/sleeptips',
        title: 'Sleep tips',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'sleep_tips');
  }
}
