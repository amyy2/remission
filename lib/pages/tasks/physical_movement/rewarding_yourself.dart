import 'package:flutter/material.dart';
import '../../../widgets/task_page.dart';

class RewardingYourselfPage extends StatefulWidget {
  const RewardingYourselfPage({super.key});

  @override
  State<RewardingYourselfPage> createState() => _RewardingYourselfState();
}

class _RewardingYourselfState extends State<RewardingYourselfPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPage(
        title: 'Rewarding yourself',
        description:
            'Do one of the small steps from your SMART goals.  Grab a pen and paper and write down how you\'re feeling about the steps you\'ve been taking to achieve your goal.  How are you going to reward yourself once at the end of the 7 days?  Or once you\'ve achieved your goal?',
        dbName: 'rewarding_yourself');
  }
}
