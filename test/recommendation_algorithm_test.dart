import 'package:flutter/cupertino.dart';
import 'package:remission/firebase_options.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remission/recommendation_algorithm.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  test(
    'Test case 1',
    () {
      var result = recommendationAlgorithm();
      print(result);
    },
  );
}
