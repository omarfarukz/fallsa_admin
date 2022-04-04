import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  String name;
  String email;
  String dUid;
  String role;
  AdminModel({this.name, this.dUid, this.role, this.email});
  AdminModel.fromMap(DocumentSnapshot snapshot) {
    name = snapshot['name'];
    email = snapshot['email'];
    dUid = snapshot['dUid'];
    role = snapshot['role'];
  }
}
