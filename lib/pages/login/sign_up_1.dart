import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:remission/pages/home/home.dart';
import 'package:remission/pages/login/sign_up_2.dart';
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

class SignUp1 extends StatefulWidget {
  const SignUp1({super.key});
  @override
  State<SignUp1> createState() => _SignUp1State();
}

class _SignUp1State extends State<SignUp1> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController diagnosisController = TextEditingController();
  final TextEditingController dateOfDiagnosisController =
      TextEditingController();

  void addUserDetails(String age, String height, String weight,
      String diagnosis, String dateOfDiagnosis) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          'age': age,
          'gender': currValue,
          'height': height,
          'weight': weight,
          'diagnosis': diagnosis,
          'date_of_diagnosis': dateOfDiagnosis,
          'radiation': radiationChecked,
          'chemo': chemoChecked,
          'immunotherapy': immunoChecked,
          'hormone': hormoneChecked,
          'other': otherChecked
        });
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
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background.jpg'), fit: BoxFit.cover)),
        child: Center(
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
                        margin: const EdgeInsets.only(top: 75),
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
                margin: const EdgeInsets.only(bottom: 20),
                child: const Text(
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
                        const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                    child: SizedBox(
                      width: 120,
                      height: 50,
                      child: TextFormField(
                        controller: ageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(124, 255, 255, 255),
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Age',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: MyColors.darkBlue,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 200,
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
                        buttonPadding:
                            const EdgeInsets.only(left: 0, right: 10),
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
                            return 'Please select your gender';
                          }
                        },
                        onChanged: (value) {
                          currValue = value.toString();
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
                        const EdgeInsets.only(top: 10, bottom: 10, right: 20),
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: TextFormField(
                        controller: heightController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(124, 255, 255, 255),
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Height',
                          suffixText: 'in',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: MyColors.darkBlue,
                              fontSize: 18),
                          suffixStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: MyColors.darkBlue,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: TextFormField(
                        controller: weightController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromARGB(124, 255, 255, 255),
                          contentPadding: const EdgeInsets.all(10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          hintText: 'Weight',
                          suffixText: 'kg',
                          hintStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: MyColors.darkBlue,
                              fontSize: 18),
                          suffixStyle: const TextStyle(
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
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: TextFormField(
                    controller: diagnosisController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(124, 255, 255, 255),
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Cancer diagnosis',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: MyColors.darkBlue,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: TextFormField(
                    controller: dateOfDiagnosisController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromARGB(124, 255, 255, 255),
                      contentPadding: const EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Date of diagnosis',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: MyColors.darkBlue,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                    top: 10, bottom: 15, left: 20, right: 20),
                child: const Text(
                  'Which cancer treatments have you had / are currently having?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: MyColors.darkBlue),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 15, right: 5),
                    child: const Text(
                      'Radiation therapy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                    child: const Text(
                      'Chemotherapy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
                    margin: const EdgeInsets.only(bottom: 15, right: 5),
                    child: const Text(
                      'Immunotherapy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
                    margin:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 5),
                    child: const Text(
                      'Hormone therapy',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
                    margin: const EdgeInsets.only(bottom: 15, right: 5),
                    child: const Text(
                      'Other',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
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
                    top: 20, left: 20, right: 20, bottom: 20),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      addUserDetails(
                          ageController.text.trim(),
                          heightController.text.trim(),
                          weightController.text.trim(),
                          diagnosisController.text.trim(),
                          dateOfDiagnosisController.text.trim());
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SignUp2(),
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
                      'Next',
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            SignUp2(),
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
            ],
          ),
        ),
      ),
    );
  }
}
