import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class SleepTipsPage extends StatefulWidget {
  final String image;
  const SleepTipsPage({super.key, required this.image});

  @override
  State<SleepTipsPage> createState() => _SleepTipsState();
}

class _SleepTipsState extends State<SleepTipsPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/sleeptips',
        title: 'Sleep tips',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'sleep_tips',
        image: widget.image);
  }
}
