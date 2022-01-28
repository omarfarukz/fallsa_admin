import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  String name;
  String ic;
  String dob;
  String number;
  UserDetailsModel({this.name, this.ic, this.number, this.dob});

  UserDetailsModel.fromDocumentSnapshot(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    dob = snapshot["dob"];
    number = snapshot["number"];
  }
}
