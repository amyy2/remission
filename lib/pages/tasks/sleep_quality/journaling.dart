import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class JournalingPage extends StatefulWidget {
  final String image;
  const JournalingPage({super.key, required this.image});

  @override
  State<JournalingPage> createState() => _JournalingState();
}

class _JournalingState extends State<JournalingPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/journalingexercise',
        title: 'Journaling',
        description:
            'Journaling right before bed has been proven to help to calm your mind and avoid having you wake up in the middle of the night, worrying about everything you need to do the next day.  Complete the following exercise:',
        URLname: 'Click here',
        dbName: 'journaling',
        image: widget.image);
  }
}
