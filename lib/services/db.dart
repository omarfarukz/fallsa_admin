import 'package:cloud_firestore/cloud_firestore.dart';

class Db {
  getUsers() {
    return FirebaseFirestore.instance.collection("userDetails").get();
  }
}
