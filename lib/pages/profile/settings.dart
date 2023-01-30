import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:remission/pages/profile/change_email.dart';
import 'package:remission/pages/profile/change_password.dart';
import 'package:remission/pages/profile/edit_profile.dart';
import 'package:remission/pages/profile/profile.dart';
import 'package:remission/pages/profile/settings.dart';
import '../../colors.dart';
import '../../services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Account Settings',
            style: TextStyle(
                color: MyColors.orange,
                fontFamily: 'DancingScript',
                fontSize: 35)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    const ProfilePage(),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const EditProfilePage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: const Text(
                'Edit profile',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const ChangeEmailScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: const Text(
                'Change email',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ChangePasswordScreen(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: const Text(
                'Change password',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .sendEmailVerification(context);
              },
              child: const Text(
                'Send verification email',
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.black),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            child: GestureDetector(
              onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  content: const Text(
                      'Are you sure you want to delete your account? This cannot be undone.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => [
                        context
                            .read<FirebaseAuthMethods>()
                            .deleteAccount(context),
                        Navigator.pop(context, 'OK'),
                        Navigator.of(context, rootNavigator: true)
                            .pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return WelcomeScreen();
                            },
                          ),
                          (_) => false,
                        ),
                      ],
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text(
                'Delete account',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
