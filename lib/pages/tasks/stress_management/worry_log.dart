import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class WorryLogPage extends StatefulWidget {
  const WorryLogPage({super.key});

  @override
  State<WorryLogPage> createState() => _WorryLogState();
}

class _WorryLogState extends State<WorryLogPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/worrylog',
        title: 'Worry log',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'worry_log');
  }
}
