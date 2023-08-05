import 'package:flutter/material.dart';
import 'package:remission/pages/login/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:remission/colors.dart';
import 'package:remission/pages/main_page.dart';
import 'package:remission/pages/splash.dart';
import 'package:remission/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';
import 'firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await initNotifications();
  runApp(MyApp());
}

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: DarwinInitializationSettings(),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Initialize the time zone
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation("America/New_York"));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseMessagingService _firebaseMessagingService =
      FirebaseMessagingService();

  @override
  Widget build(BuildContext context) {
    scheduleDailyNotification();

    _firebaseMessagingService.initialize();

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

  Future<void> scheduleDailyNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_reminders',
      'Daily Reminders',
      channelDescription: 'Receive daily reminders to check in',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Remember to check in',
      '',
      _nextInstanceOf9AM(),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime _nextInstanceOf9AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 9, 0);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
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
