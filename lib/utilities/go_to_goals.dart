import 'package:flutter/material.dart';
import 'package:remission/colors.dart';
import '../pages/goals.dart';

void goToGoals(BuildContext context) {
  showModalBottomSheet(
    barrierColor: Colors.black.withOpacity(0),
    context: context,
    builder: (builder) {
      return Container(
        height: 100.0,
        child: Padding(
          padding:
              EdgeInsets.fromLTRB(15, 15, 15, 25), // Increase bottom padding
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white, // Change this to the color you want
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MyColors.darkBlue),
                borderRadius:
                    BorderRadius.circular(50), // 50 pixel border radius
              ),
            ),
            child: Text(
              'View my goals',
              style: TextStyle(fontSize: 20, color: MyColors.darkBlue),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoalsPage()),
              );
            },
          ),
        ),
      );
    },
  );
}
