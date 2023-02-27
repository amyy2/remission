import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class BalancePage extends StatefulWidget {
  final String image;
  BalancePage({required this.image});

  @override
  State<BalancePage> createState() => _BalanceState();
}

class _BalanceState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/balance-exercise',
        title: 'Balance',
        description: 'Complete the exercise below.',
        URLname: 'Exercise',
        dbName: 'balance',
        image: widget.image);
  }
}
