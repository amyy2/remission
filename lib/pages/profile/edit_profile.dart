import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:provider/provider.dart';
import 'package:remission/pages/login/sign_up_2.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:remission/pages/profile/profile.dart';
import 'package:remission/pages/profile/settings.dart';

import '../../colors.dart';
import '../../services/firebase_auth_methods.dart';

var _diet = [
  "Very healthy",
  "Somewhat healthy",
  "Needs improvement",
  "Mostly unhealthy",
  "N/A"
];
var _genders = ["Female", "Male", "Nonbinary", "Other", "N/A"];
var _physical_limitations = [
  "Not mobile at all",
  "I have limited mobility",
  "No limitations but out of shape",
  "Not in the best shape, could improve",
  "I'm in great shape",
  "N/A"
];

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController diagnosisController = TextEditingController();
  TextEditingController dateOfDiagnosisController = TextEditingController();
  String? currGValue;
  String? currPLValue;
  String? currDValue;
  String name = '';
  String age = '';
  String gender = '';
  String height = '';
  String weight = '';
  String diagnosis = '';
  String dateOfDiagnosis = '';
  bool radiationChecked = false;
  bool chemoChecked = false;
  bool immunoChecked = false;
  bool hormoneChecked = false;
  bool otherChecked = false;
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

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    diagnosisController.dispose();
    dateOfDiagnosisController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Edit Profile',
            style: TextStyle(
                color: MyColors.darkBlue, fontFamily: 'Poppins', fontSize: 25)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SettingsPage(),
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
              color: MyColors.darkBlue,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            editField(nameController, 'Name'),
            editField(ageController, 'Age'),
            Container(
              padding: EdgeInsets.only(top: 13, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Gender',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 100, 100, 100))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 400,
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
                  iconSize: 25,
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
                  value: currGValue,
                  onChanged: (value) {
                    setState(() {
                      currGValue = value.toString();
                    });
                  },
                ),
              ),
            ),
            editField(heightController, 'Height [in]'),
            editField(weightController, 'Weight [kg]'),
            editField(diagnosisController, 'Cancer diagnosis'),
            editField(dateOfDiagnosisController, 'Date of diagnosis'),
            const Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Text(
                  'Please select which cancer treatments you\'ve had / are currently having:'),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: radiationChecked,
                          onChanged: (value) {
                            setState(() {
                              radiationChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: chemoChecked,
                          onChanged: (value) {
                            setState(() {
                              chemoChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: immunoChecked,
                          onChanged: (value) {
                            setState(() {
                              immunoChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: hormoneChecked,
                          onChanged: (value) {
                            setState(() {
                              hormoneChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
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
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: otherChecked,
                          onChanged: (value) {
                            setState(() {
                              otherChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 13, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Physical limitations',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 100, 100, 100))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 400,
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
                  hint: const Text(
                    'Physical limitations',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: MyColors.darkBlue,
                        fontSize: 18),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 25,
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
                  value: currPLValue,
                  onChanged: (value) {
                    setState(() {
                      currPLValue = value.toString();
                    });
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 13, left: 20, right: 20),
              width: double.infinity,
              child: const Text('Current diet',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 15, color: Color.fromARGB(255, 100, 100, 100))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: SizedBox(
                width: 400,
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
                  hint: const Text(
                    'Current diet',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: MyColors.darkBlue,
                        fontSize: 18),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 25,
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
                                  fontSize: 18),
                            ),
                          ))
                      .toList(),
                  value: currDValue,
                  onChanged: (value) {
                    setState(() {
                      currDValue = value.toString();
                    });
                  },
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
              child: Text('Please select your current dietary habits:        '),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Stress eating',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: stressChecked,
                          onChanged: (value) {
                            setState(() {
                              stressChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Sugar addication',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: sugarChecked,
                          onChanged: (value) {
                            setState(() {
                              sugarChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Emotional eating',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: emotionChecked,
                          onChanged: (value) {
                            setState(() {
                              emotionChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Boredom eating',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: boredomChecked,
                          onChanged: (value) {
                            setState(() {
                              boredomChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Salt cravings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: saltChecked,
                          onChanged: (value) {
                            setState(() {
                              saltChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Junk food cravings',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: junkChecked,
                          onChanged: (value) {
                            setState(() {
                              junkChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Late night snacking',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: lateChecked,
                          onChanged: (value) {
                            setState(() {
                              lateChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Mindless eating',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: mindlessChecked,
                          onChanged: (value) {
                            setState(() {
                              mindlessChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Eating to accomodate others',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: othersChecked,
                          onChanged: (value) {
                            setState(() {
                              othersChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Eating whatever\'s easy or fast',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: easyChecked,
                          onChanged: (value) {
                            setState(() {
                              easyChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 5, bottom: 10, left: 20, right: 5),
                  child: const Text(
                    'Never satisfied',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: MyColors.darkBlue),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, bottom: 10),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Checkbox(
                          checkColor: Colors.white,
                          shape: const CircleBorder(),
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: satisfiedChecked,
                          onChanged: (value) {
                            setState(() {
                              satisfiedChecked = value!;
                            });
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    updateUserData();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const SettingsPage(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Save changes',
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
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Row editCheckbox(String label, checked) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10, left: 20, right: 5),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
              fontFamily: 'Poppins', fontSize: 18, color: MyColors.darkBlue),
        ),
      ),
      Container(
        margin: const EdgeInsets.only(top: 5, bottom: 10),
        child: SizedBox(
          width: 24,
          height: 24,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Checkbox(
                checkColor: Colors.white,
                shape: const CircleBorder(),
                fillColor: MaterialStateProperty.resolveWith(getColor),
                value: checked,
                onChanged: (value) {
                  setState(() {
                    checked = value;
                  });
                },
              );
            },
          ),
        ),
      )
    ]);
  }

  Container editField(controller, String label) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

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

  Future getUserData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
          nameController.text = name;
          age = snapshot.data()!['age'];
          ageController.text = age;
          gender = snapshot.data()!['gender'];
          currGValue = gender;
          height = snapshot.data()!['height'];
          heightController.text = height;
          weight = snapshot.data()!['weight'];
          weightController.text = weight;
          diagnosis = snapshot.data()!['diagnosis'];
          diagnosisController.text = diagnosis;
          dateOfDiagnosis = snapshot.data()!['date_of_diagnosis'];
          dateOfDiagnosisController.text = dateOfDiagnosis;
          radiationChecked = snapshot.data()!['radiation'];
          chemoChecked = snapshot.data()!['chemo'];
          immunoChecked = snapshot.data()!['immunotherapy'];
          hormoneChecked = snapshot.data()!['hormone'];
          otherChecked = snapshot.data()!['other'];
          currPLValue = snapshot.data()!['physical_limitations'];
          currDValue = snapshot.data()!['diet'];
          stressChecked = snapshot.data()!['stress_eating'];
          sugarChecked = snapshot.data()!['sugar_addiction'];
          emotionChecked = snapshot.data()!['emotional_eating'];
          boredomChecked = snapshot.data()!['boredom_eating'];
          saltChecked = snapshot.data()!['salt_cravings'];
          junkChecked = snapshot.data()!['junk_food_cravings'];
          lateChecked = snapshot.data()!['late_night_snacking'];
          mindlessChecked = snapshot.data()!['mindless_eating'];
          easyChecked = snapshot.data()!['easy_or_fast'];
          othersChecked = snapshot.data()!['accomodate_others'];
          satisfiedChecked = snapshot.data()!['never_satisfied'];
        });
      }
    });
  }

  void updateUserData() async {
    print(FirebaseAuth.instance.currentUser!.email);
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(
      {
        'name': nameController.text.trim(),
        'age': ageController.text.trim(),
        'gender': currGValue,
        'height': heightController.text.trim(),
        'weight': weightController.text.trim(),
        'diagnosis': diagnosisController.text.trim(),
        'date_of_diagnosis': dateOfDiagnosisController.text.trim(),
        'radiation': radiationChecked,
        'chemo': chemoChecked,
        'immunotherapy': immunoChecked,
        'hormone': hormoneChecked,
        'other': othersChecked,
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
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }
}
