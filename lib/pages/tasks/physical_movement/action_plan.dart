import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class ActionPlanPage extends StatefulWidget {
  final String image;
  ActionPlanPage({required this.image});

  @override
  State<ActionPlanPage> createState() => _ActionPlanState();
}

class _ActionPlanState extends State<ActionPlanPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL:
            'https://www.ownyourcancercoaching.com/the-best-of-youtube-home-workouts',
        title: 'Action plan',
        description:
            'Make an action plan for the next 7 days that will move you closer to achieving your SMART goals.  Grab a pen and paper and break down your goal into small realistic and achievable steps that you can do each day this week. Just make sure that they\'re steps that you are likely to do. Even if the steps are small (like walking to the end of the street and back) it\'s still progress towards achieving your goal.  If you\'re feeling ambitious, aim to do one of the following YouTube videos each day:',
        URLname: 'Click here for YouTube videos',
        dbName: 'action_plan',
        image: widget.image);
  }
}
