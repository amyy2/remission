import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class CopingWithFearsPage extends StatefulWidget {
  const CopingWithFearsPage({super.key});

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
        URLname: 'Exercise',
        dbName: 'coping_with_fears');
  }
}
