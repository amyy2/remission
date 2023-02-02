import 'package:flutter/material.dart';
import '../../../widgets/task_page.dart';

class RoadblocksPage extends StatefulWidget {
  const RoadblocksPage({super.key});

  @override
  State<RoadblocksPage> createState() => _RoadblocksState();
}

class _RoadblocksState extends State<RoadblocksPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPage(
        title: 'Roadblocks',
        description:
            'Do one of the small steps from your SMART goals.  Grab a pen and paper and write down what your biggest \'roadblocks\' have been this week for you to be active.  What are things you can do moving forward to overcome them?',
        dbName: 'roadblocks');
  }
}
