import 'package:flutter/material.dart';
import '../../../widgets/task_page_with_URL.dart';

class MakeGroceryListPage extends StatefulWidget {
  final String image;
  const MakeGroceryListPage({super.key, required this.image});

  @override
  State<MakeGroceryListPage> createState() => _MakeGroceryListState();
}

class _MakeGroceryListState extends State<MakeGroceryListPage> {
  @override
  Widget build(BuildContext context) {
    return TaskPageWithURL(
        URL: 'https://www.ownyourcancercoaching.com/healthy-food-swaps',
        title: 'Make grocery list',
        description:
            'From the list of Healthy Food Swaps, choose at least 5 healthy swaps that you can start making today.  Make a grocery list of the healthy foods you’d like to purchase. The more of healthy food swaps you can make the better, but if you\'re just starting out, aim to make 1-2 swaps per week.',
        URLname: 'Get Healthy Food Swaps here',
        dbName: 'make_grocery_list',
        image: widget.image);
  }
}
