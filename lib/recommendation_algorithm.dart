import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:multiple_random_choice/multiple_random_choice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void updateUnlocked(List tasks) async {
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'unlocked_tasks': FieldValue.arrayUnion(tasks)});
    }
  });
}

Future<List<String>> recommendationAlgorithm(
    FirebaseFirestore db, String collection, List words, List completed) async {
  final querySnapshot = await db.collection(collection).get();
  List tasks = querySnapshot.docs.toList();
  //Iterable<double> weights = [];
  List<String> taskNames = [];
  List<num> weights = [];
  int P, i, k;
  double w;

  for (var index = 0; index < tasks.length; index++) {
    // check if prerequisite(s) are satisfied
    if (completed.toSet().containsAll(tasks[index]["prerequisites"])) {
      P = 1;
    } else {
      P = 0;
    }

    // check if task is incomplete
    if (completed.contains(tasks[index]["name"])) {
      i = 0;
    } else {
      i = 1;
    }

    // get number of matching keywords
    Set intersection = [tasks[index]["keywords"], words].fold<Set>(
        [tasks[index]["keywords"], words].first.toSet(),
        (a, b) => a.intersection(b.toSet()));
    k = intersection.length;

    // calculate weight
    w = (P * i * k) / tasks.length;
    //weights = weights.followedBy([w]);
    taskNames.add(tasks[index]["name"]);
    weights.add(w);
  }
  //String task1 = randomChoice(tasks, weights)["name"];

  //final Map<String, num> map = Map.fromIterables(tasks, weights);
  final Map<String, num> map = {};
  for (int i = 0; i < tasks.length; i++) {
    map[taskNames[i]] = weights[i];
  }

  List<String> recoommendation =
      randomMultipleWeightedChoice<String>(map, 2, null).toList();
  updateUnlocked(recoommendation);
  return recoommendation;
}
