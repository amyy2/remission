import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class GratitudePage extends StatefulWidget {
  const GratitudePage({super.key});

  @override
  State<GratitudePage> createState() => _GratitudeState();
}

class _GratitudeState extends State<GratitudePage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/gratitudeexercise',
        title: 'Gratitude',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'gratitude');
  }
}
