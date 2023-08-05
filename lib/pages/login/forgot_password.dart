import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:remission/pages/login/sign_in.dart';
import 'package:remission/utilities/showSnackBar.dart';

import '../../colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void resetPassword() async {
    try {
      List? list = await FirebaseAuth.instance
          .fetchSignInMethodsForEmail(emailController.text.trim());
      if (list.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        showSnackBar(context, "Reset password email sent");
        Navigator.of(context).pop();
      } else {
        showSnackBar(context, "Email does not exist");
      }
    } catch (e) {
      showSnackBar(context, "Email does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Image(
                      image: AssetImage('images/remission-logo.png'),
                      width: 250),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 30),
                  child: const Text(
                    'Trouble logging in?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromARGB(124, 255, 255, 255),
                        contentPadding: const EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: MyColors.darkBlue,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 20, right: 20, bottom: 40),
                  child: SizedBox(
                    width: 300,
                    height: 50,
                    child: OutlinedButton(
                      onPressed: resetPassword,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0, style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Reset password',
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const SignIn(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ));
                  },
                  child: const Text(
                    'Back to login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
