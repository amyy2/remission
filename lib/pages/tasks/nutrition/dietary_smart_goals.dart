import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class DietarySMARTGoalsPage extends StatefulWidget {
  final String image;
  const DietarySMARTGoalsPage({super.key, required this.image});

  @override
  State<DietarySMARTGoalsPage> createState() => _DietarySMARTGoalsState();
}

class _DietarySMARTGoalsState extends State<DietarySMARTGoalsPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/Dietarysmartgoals-dietary',
        title: 'SMART goals',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'dietary_smart_goals',
        image: widget.image);
  }
}
