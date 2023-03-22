import 'package:flutter/material.dart';
import 'package:flutterfire_ui/i10n.dart';
import 'package:remission/pages/login/sign_in.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remission/colors.dart';
import 'package:remission/pages/main_page.dart';
import 'package:remission/pages/splash.dart';
import 'package:remission/pages/tasks/nutrition/choose_cff.dart';
import 'package:remission/pages/tasks/nutrition/print_cff_list.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthMethods>(
            create: (_) => FirebaseAuthMethods(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<FirebaseAuthMethods>().authState,
            initialData: null)
      ],
      child: MaterialApp(
        home: const AuthWrapper(),
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: MyColors.darkBlue),
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontSizeFactor: 1.0, fontFamily: 'Poppins'),
        ),
        routes: {
          '/main-page': (context) => const MainPage(),
          '/welcome-page': (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const Splash();
    }
    return const WelcomeScreen();
  }
}
