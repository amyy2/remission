import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class BalancePage extends StatefulWidget {
  final String image;
  const BalancePage({super.key, required this.image});

  @override
  State<BalancePage> createState() => _BalanceState();
}

class _BalanceState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/balance-exercise',
        title: 'Balance',
        description: 'Complete the exercise below.',
        URLname: 'Click here',
        dbName: 'balance',
        image: widget.image);
  }
}
