import 'package:cloud_firestore/cloud_firestore.dart';

class DB {
  getFallRisk(String uid) {
    return FirebaseFirestore.instance
        .collection('fallRisk')
        .where('uid', isEqualTo: uid)
        .orderBy('dateTime')
        .get();
  }
}
