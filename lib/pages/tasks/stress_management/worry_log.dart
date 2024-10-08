import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class WorryLogPage extends StatefulWidget {
  final String image;
  const WorryLogPage({super.key, required this.image});

  @override
  State<WorryLogPage> createState() => _WorryLogState();
}

class _WorryLogState extends State<WorryLogPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/worrylog',
        title: 'Worry log',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'worry_log',
        image: widget.image);
  }
}
