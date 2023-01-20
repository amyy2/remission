import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:remission/pages/login/sign_in.dart';
import 'package:remission/pages/login/sign_up.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remission/utilities/showSnackBar.dart';

import '../../colors.dart';
import '../main_page.dart';

class WelcomeScreen extends StatefulWidget {
  static String routeName = '/welcome-page';
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  void signUpUser() async {
    if (_formkey.currentState!.validate()) {
      FirebaseAuthMethods(FirebaseAuth.instance).emailSignUp(
        email: emailController.text,
        password: passwordController.text,
        context: context,
      );
    } else {
      showSnackBar(context, "Please ensure all fields are correct");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.lightBlue,
      body: Center(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: const Image(
                    image: AssetImage('images/remission-logo.png'), width: 250),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 10),
                child: const Text(
                  'Welcome to Remission',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'DancingScript',
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: MyColors.orange),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20),
                child: const Text(
                  'Let\'s get started by making an account.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: MyColors.darkBlue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(124, 255, 255, 255),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Name',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: MyColors.darkBlue,
                          fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(124, 255, 255, 255),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: MyColors.darkBlue,
                          fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(124, 255, 255, 255),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontFamily: 'Poppins',
                          color: MyColors.darkBlue,
                          fontSize: 18),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return 'Passwords do not match';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      } else {
                        return null;
                      }
                    }),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(124, 255, 255, 255),
                      contentPadding: EdgeInsets.all(10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Confirm password',
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
                    top: 10, left: 10, right: 10, bottom: 40),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: signUpUser,
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50))),
                    child: const Text(
                      'Create account',
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
                            SignIn(),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ));
                },
                child: const Text(
                  'Already have an account? Sign in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: MyColors.darkBlue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
