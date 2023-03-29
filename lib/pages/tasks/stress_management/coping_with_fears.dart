import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class CopingWithFearsPage extends StatefulWidget {
  final String image;
  CopingWithFearsPage({required this.image});

  @override
  State<CopingWithFearsPage> createState() => _CopingWithFearsState();
}

class _CopingWithFearsState extends State<CopingWithFearsPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/copingwithcancerfears',
        title: 'Coping with fears',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'coping_with_fears',
        image: widget.image);
  }
}
