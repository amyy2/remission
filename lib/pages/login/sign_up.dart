import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:remission/pages/home.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:remission/pages/main_page.dart';

import '../../colors.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

var _genders = ["Female", "Male", "Nonbinary", "Other"];
String? currValue;
bool radiationChecked = false;
bool chemoChecked = false;
bool immunoChecked = false;
bool hormoneChecked = false;
bool otherChecked = false;

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return MyColors.orange;
      }
      return MyColors.darkBlue;
    }

    return Scaffold(
      backgroundColor: MyColors.lightBlue,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  /*
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  WelcomeScreen(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Icon(
                        (Icons.arrow_back),
                        size: 30,
                        color: MyColors.orange,
                      ),
                    ),
                  ),
                  */
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 75),
                      alignment: Alignment.center,
                      child: Image(
                          image: AssetImage('images/remission-logo.png'),
                          width: 150),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                'Let\'s get to know you a bit more',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: MyColors.darkBlue),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'This helps us curate a personalized experience for you',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: MyColors.darkBlue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 15, right: 20),
                  child: SizedBox(
                    width: 120,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(124, 255, 255, 255),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Age',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(124, 255, 255, 255),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Gender',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black45,
                      ),
                      iconSize: 30,
                      buttonHeight: 60,
                      buttonPadding: const EdgeInsets.only(left: 0, right: 10),
                      dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      items: _genders
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: MyColors.darkBlue,
                                      fontSize: 18),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        currValue = value.toString();
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 15, right: 20),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(124, 255, 255, 255),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Height',
                        suffixText: 'in',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                        suffixStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 15),
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(124, 255, 255, 255),
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Weight',
                        suffixText: 'kg',
                        hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                        suffixStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: SizedBox(
                width: 330,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(124, 255, 255, 255),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Cancer diagnosis',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: MyColors.darkBlue,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: SizedBox(
                width: 330,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(124, 255, 255, 255),
                    contentPadding: EdgeInsets.all(10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    hintText: 'Date of diagnosis',
                    hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: MyColors.darkBlue,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 15, left: 20, right: 20),
              child: Text(
                'Which cancer treatments have you had / are currently having?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: MyColors.darkBlue),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15, right: 5),
                  child: Text(
                    'Radiation therapy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: radiationChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          radiationChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 20, right: 5),
                  child: Text(
                    'Chemotherapy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: chemoChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          chemoChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15, right: 5),
                  child: Text(
                    'Immunotherapy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: immunoChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          immunoChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, left: 20, right: 5),
                  child: Text(
                    'Hormone therapy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: hormoneChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          hormoneChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 15, right: 5),
                  child: Text(
                    'Other',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      checkColor: Colors.white,
                      shape: CircleBorder(),
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: otherChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          otherChecked = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MainPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: Text(
                    'Get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.orange),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
