import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class FoodJournalPage extends StatefulWidget {
  final String image;
  FoodJournalPage({required this.image});

  @override
  State<FoodJournalPage> createState() => _FoodJournalState();
}

class _FoodJournalState extends State<FoodJournalPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/exercise',
        title: 'Food journal',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'food_journal',
        image: widget.image);
  }
}
