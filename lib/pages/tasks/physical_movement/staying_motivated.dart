import 'package:flutter/material.dart';
import '../../../widgets/task_page.dart';

class StayingMotivatedPage extends StatefulWidget {
  final String image;
  const StayingMotivatedPage({super.key, required this.image});

  @override
  State<StayingMotivatedPage> createState() => _StayingMotivatedState();
}

class _StayingMotivatedState extends State<StayingMotivatedPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPage(
        title: 'Staying motivated',
        description:
            'Do one of the small steps from your SMART goals.  Grab a pen and paper and write down how you\'re going to stay motivated and accountable to complete these steps each day this week. (HINT:  just knowing that you\'ll likely feel better with each step you take can help!)',
        dbName: 'staying_motivated',
        image: widget.image);
  }
}
