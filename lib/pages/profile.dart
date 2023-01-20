import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:remission/pages/login/welcome_screen.dart';

import '../colors.dart';
import '../services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            if (!user.emailVerified)
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 40),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      context
                          .read<FirebaseAuthMethods>()
                          .sendEmailVerification(context);
                    },
                    style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 0, style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50))),
                    child: Text(
                      'Verify email',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<FirebaseAuthMethods>().signOut(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: Text(
                    'Sign out',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 40),
              child: SizedBox(
                width: 300,
                height: 50,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<FirebaseAuthMethods>().deleteAccount(context);
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: Text(
                    'Delete account',
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
