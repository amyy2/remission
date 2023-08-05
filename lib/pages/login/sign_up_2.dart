import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remission/pages/login/sign_up_1.dart';
import 'package:remission/pages/main_page.dart';

import '../../colors.dart';

import 'package:dropdown_button2/dropdown_button2.dart';


var _physical_limitations = [
  "Not mobile at all",
  "I have limited mobility",
  "No limitations but out of shape",
  "Not in the best shape, could improve",
  "I'm in great shape"
];
String? currPLValue = 'N/A';
var _diet = [
  "Very healthy",
  "Somewhat healthy",
  "Needs improvement",
  "Mostly unhealthy"
];
String? currDValue = 'N/A';
bool stressChecked = false;
bool sugarChecked = false;
bool emotionChecked = false;
bool boredomChecked = false;
bool saltChecked = false;
bool junkChecked = false;
bool lateChecked = false;
bool mindlessChecked = false;
bool easyChecked = false;
bool othersChecked = false;
bool satisfiedChecked = false;

class SignUp2 extends StatefulWidget {
  const SignUp2({super.key});
  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  void addUserDetails() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    StreamSubscription<User?>? listener;
    listener = auth.authStateChanges().listen((User? user) {
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'physical_limitations': currPLValue,
          'diet': currDValue,
          'stress_eating': stressChecked,
          'sugar_addiction': sugarChecked,
          'emotional_eating': emotionChecked,
          'boredom_eating': boredomChecked,
          'salt_cravings': saltChecked,
          'junk_food_cravings': junkChecked,
          'late_night_snacking': lateChecked,
          'mindless_eating': mindlessChecked,
          'accomodate_others': othersChecked,
          'easy_or_fast': easyChecked,
          'never_satisfied': satisfiedChecked
        }).then((value) => listener?.cancel());
      }
    });
  }

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const SignUp1(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          child: const Icon(
                            (Icons.arrow_back),
                            size: 30,
                            color: MyColors.orange,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 75, right: 50),
                          alignment: Alignment.center,
                          child: const Image(
                              image: AssetImage('images/remission-logo.png'),
                              width: 150),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  child: const Text(
                    'Almost there',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: const Text(
                    'Finish setting up your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: MyColors.darkBlue),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(124, 255, 255, 255),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Physical limitations',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 14),
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
                      items: _physical_limitations
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
                          return 'Please select a physical state';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        currPLValue = value.toString();
                      },
                      onSaved: (value) {
                        currPLValue = value.toString();
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: SizedBox(
                    width: 380,
                    height: 50,
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(124, 255, 255, 255),
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Current diet',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 14),
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
                      items: _diet
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: MyColors.darkBlue,
                                      fontSize: 14),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a diet state';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        currDValue = value.toString();
                      },
                      onSaved: (value) {
                        currDValue = value.toString();
                      },
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 15, left: 20, right: 20),
                  child: const Text(
                    'Please select your dietary habits',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: MyColors.darkBlue),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Stress eating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: stressChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              stressChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                      child: const Text(
                        'Sugar addiction',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: sugarChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              sugarChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Emotional eating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: emotionChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              emotionChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                      child: const Text(
                        'Boredom eating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: boredomChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              boredomChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Salt cravings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: saltChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              saltChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                      child: const Text(
                        'Junk food cravings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: junkChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              junkChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Late night snacking',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: lateChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              lateChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                      child: const Text(
                        'Mindless eating',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: mindlessChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              mindlessChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Eating to accomodate others',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: othersChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              othersChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Eating whatever\'s easy or fast',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: easyChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              easyChecked = value!;
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
                      margin: const EdgeInsets.only(bottom: 15, right: 5),
                      child: const Text(
                        'Never satisfied',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            color: MyColors.darkBlue),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: satisfiedChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              satisfiedChecked = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 20),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: () {
                        addUserDetails();
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const MainPage(),
                            transitionDuration: Duration.zero,
                            reverseTransitionDuration: Duration.zero,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
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
                /*
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MainPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ));
                },
                child: const Text(
                  'Skip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins', fontSize: 18, color: Colors.white),
                ),
              ),
              */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
