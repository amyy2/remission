import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future<QuerySnapshot<Map<String, dynamic>>> recommendationAlgorithm() {
  final tasks_collection = FirebaseFirestore.instance.collection("tasks");
  final tasks = tasks_collection.get();
  return tasks;
}

void main() {
  recommendationAlgorithm();
}
