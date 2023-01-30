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
import 'package:remission/utilities/showSnackBar.dart';

import '../../colors.dart';
import '../../services/firebase_auth_methods.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  _ChangeEmailScreenState createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final currUser = FirebaseAuth.instance.currentUser;

  changeEmail({email, password}) async {
    try {
      if (emailController.text.isEmpty) {
        showSnackBar(context, 'Please enter an email');
      } else {
        var cred =
            EmailAuthProvider.credential(email: email, password: password);
        await currUser!.reauthenticateWithCredential(cred).then((value) {
          currUser!.updateEmail(emailController.text);

          showSnackBar(context, 'Email has been changed');
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const SettingsPage(),
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
              ));
        });
      }
    } catch (e) {
      showSnackBar(context, "Please ensure all fields are correct");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Change email',
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
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'New email'),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
              child: TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Current password'),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () async {
                    await changeEmail(
                        email: currUser!.email,
                        password: passwordController.text);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Change email',
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
