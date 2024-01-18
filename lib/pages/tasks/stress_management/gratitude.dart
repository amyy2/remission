import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class GratitudePage extends StatefulWidget {
  final String image;
  const GratitudePage({super.key, required this.image});

  @override
  State<GratitudePage> createState() => _GratitudeState();
}

class _GratitudeState extends State<GratitudePage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/gratitudeexercise',
        title: 'Gratitude',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'gratitude',
        image: widget.image);
  }
}
