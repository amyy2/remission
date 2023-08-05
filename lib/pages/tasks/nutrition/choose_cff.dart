import 'package:flutter/material.dart';
import '../../../widgets/task_page.dart';

class ChooseCFFPage extends StatefulWidget {
  final String image;
  const ChooseCFFPage({super.key, required this.image});

  @override
  State<ChooseCFFPage> createState() => _ChooseCFFState();
}

class _ChooseCFFState extends State<ChooseCFFPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPage(
        title: 'Choose CFFs',
        description:
            'Grab a pen and paper and the CFF lists.  Write down HOW you’re going to add more CFFs to your diet.  You can try searching for new recipes online that contain these foods or think about how to sneak them into your favorite meals.  For example, can you add some spinach or squash to your spaghetti sauce? More veggies on your pizza?',
        dbName: 'choose_cffs',
        image: widget.image);
  }
}
