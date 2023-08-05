import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:remission/pages/profile/settings.dart';
import 'package:remission/utilities/showSnackBar.dart';

import '../../colors.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePassswordScreenState createState() => _ChangePassswordScreenState();
}

class _ChangePassswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController currPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final currUser = FirebaseAuth.instance.currentUser;

  changePassword({email, currPassword, newPassword}) async {
    try {
      if (confirmPasswordController.text.isEmpty) {
        showSnackBar(context, 'Passwords do not match');
      } else if (confirmPasswordController.text != newPasswordController.text) {
        showSnackBar(context, 'Passwords do not match');
      } else {
        var cred =
            EmailAuthProvider.credential(email: email, password: currPassword);
        await currUser!.reauthenticateWithCredential(cred).then((value) {
          currUser!.updatePassword(newPassword);

          showSnackBar(context, 'Password has been changed');
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
        title: const Text('Change password',
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
                controller: currPasswordController,
                decoration: const InputDecoration(labelText: 'Current password'),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
              child: TextFormField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New password'),
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 5, left: 20, bottom: 5, right: 20),
              child: TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm new password'),
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
                    await changePassword(
                        email: currUser!.email,
                        currPassword: currPasswordController.text,
                        newPassword: newPasswordController.text);
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
                    'Change password',
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
