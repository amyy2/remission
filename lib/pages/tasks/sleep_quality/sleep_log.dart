import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class SleepLogPage extends StatefulWidget {
  final String image;
  const SleepLogPage({super.key, required this.image});

  @override
  State<SleepLogPage> createState() => _SleepLogState();
}

class _SleepLogState extends State<SleepLogPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.nhs.uk/livewell/insomnia/documents/sleepdiary.pdf',
        title: 'Sleep log',
        description:
            'Create a sleep log for the next 7 days.  Here is an example to print or download:',
        URLname: 'Sleep log example',
        dbName: 'sleep_log',
        image: widget.image);
  }
}
