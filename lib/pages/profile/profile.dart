import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:remission/pages/profile/settings.dart';

import '../../colors.dart';
import '../../services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';

  Future getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!['name'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        scrolledUnderElevation: 3,
        title: const Text('Profile',
            style: TextStyle(
                color: MyColors.orange,
                fontFamily: 'DancingScript',
                fontSize: 40)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: MyColors.darkBlue,
            ),
            padding: EdgeInsets.only(right: 20),
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SettingsPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 20),
              width: double.infinity,
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: MyColors.darkBlue),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              width: double.infinity,
              child: Text(
                "Email: " + user.email!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                          return const WelcomeScreen();
                        },
                      ),
                      (_) => false,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 232, 236, 252),
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 0, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))),
                  child: const Text(
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
            Container(
              margin: const EdgeInsets.only(top: 300),
              child: const Image(
                  image: AssetImage('images/ribbon.png'), width: 1100),
            ),
          ],
        ),
      ),
    );
  }
}
