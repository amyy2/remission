import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class PrintCFFListPage extends StatefulWidget {
  final String image;
  const PrintCFFListPage({super.key, required this.image});

  @override
  State<PrintCFFListPage> createState() => _PrintCFFListState();
}

class _PrintCFFListState extends State<PrintCFFListPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.remissionsupport.com/cancer-fighting-foods',
        title: 'Print CFF list',
        description:
            'Take a screenhot or print out the lists of CFFs (Cancer Fighting Foods) for easy access.  Circle or make a list of all the foods you don’t consume regularly but are willing to add more of to your diet on a regular basis.  Make a grocery list of those foods.',
        URLname: 'Get list here',
        dbName: 'print_cff_list',
        image: widget.image);
  }
}
