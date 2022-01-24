import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String email;

  UserModel({
    this.id,
    this.email,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    email = documentSnapshot["email"];
  }
}
