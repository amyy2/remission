import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class PhysicalSMARTGoalsPage extends StatefulWidget {
  final String image;
  PhysicalSMARTGoalsPage({required this.image});

  @override
  State<PhysicalSMARTGoalsPage> createState() => _PhysicalSMARTGoalsState();
}

class _PhysicalSMARTGoalsState extends State<PhysicalSMARTGoalsPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL:
            'https://www.ownyourcancercoaching.com/smart-goals-for-physicalmovement',
        title: 'SMART goals',
        description:
            'What is your main goal in terms of physical activity? (ie., to get in shape, to be more active, to have more motivation to exercise, etc) Complete the following exercise.',
        URLname: 'Exercise',
        dbName: 'physical_smart_goals',
        image: widget.image);
  }
}
