import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remission/recommendation_algorithm.dart';

void main() {
  test('Test 1', () async {
    final firestore = FakeFirebaseFirestore();
    await firestore.collection("test_tasks").add({
      "category": "nutrition",
      "name": "print_cff_list",
      "prerequisites": [],
      "keywords": [
        "nauseous",
        "hormonal",
        "achy",
        "constipated",
        "bloated",
        "worried",
        "hopeful",
        "tired",
        "lethargic"
      ]
    });
    await firestore.collection("test_tasks").add({
      "category": "nutrition",
      "name": "choose_cffs",
      "prerequisites": ["print_cff_list"],
      "keywords": [
        "nauseous",
        "hormonal",
        "achy",
        "constipated",
        "bloated",
        "worried",
        "hopeful",
        "tired",
        "lethargic"
      ]
    });
    await firestore.collection("test_tasks").add({
      "category": "nutrition",
      "name": "make_grocery_list",
      "prerequisites": ["print_cff_list", "choose_cffs"],
      "keywords": [
        "nauseous",
        "hormonal",
        "achy",
        "constipated",
        "bloated",
        "worried",
        "hopeful",
        "tired",
        "lethargic"
      ]
    });
    await firestore.collection("test_tasks").add({
      "category": "nutrition",
      "name": "food_journal",
      "prerequisites": [],
      "keywords": [
        "nauseous",
        "hormonal",
        "achy",
        "constipated",
        "bloated",
        "worried",
        "hopeful",
        "tired",
        "lethargic"
      ]
    });
    await firestore.collection("test_tasks").add({
      "category": "nutrition",
      "name": "dietary_smart_goals",
      "prerequisites": [],
      "keywords": [
        "nauseous",
        "hormonal",
        "achy",
        "constipated",
        "bloated",
        "worried",
        "hopeful",
        "tired",
        "lethargic"
      ]
    });
    recommendationAlgorithm(
        firestore, 'test_tasks', ["sad", "worried", "nauseous", "tired"], []);
  });
}
