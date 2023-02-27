import 'package:flutter/material.dart';
import 'package:remission/widgets/task_page_with_URL.dart';

class ProblemSolvingPage extends StatefulWidget {
  final String image;
  ProblemSolvingPage({required this.image});

  @override
  State<ProblemSolvingPage> createState() => _ProblemSolvingState();
}

class _ProblemSolvingState extends State<ProblemSolvingPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/problemsolving',
        title: 'Problem solving',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'problem_solving',
        image: widget.image);
  }
}
