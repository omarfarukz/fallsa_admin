import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetailsModel {
  String name;
  String ic;
  String dob;
  String number;
  String gender;
  String adress1;
  String adress2;
  String education;
  String uid;
  String dUid;
  // String postcode;
  // String state;
  // String phonenumber;

  UserDetailsModel({
    this.name,
    this.ic,
    this.number,
    this.dob,
    this.adress1,
    this.adress2,
    this.education,
    this.gender,
    this.uid,
    this.dUid,
    // this.phonenumber,
    // this.postcode,
    // this.state,
  });

  UserDetailsModel.fromMap(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    dob = snapshot["dob"];
    number = snapshot["number"];
    // phonenumber = snapshot["phonenumber"];
    gender = snapshot["gander"];
    adress1 = snapshot["adress1"];
    adress2 = snapshot["adress2"];
    education = snapshot["education"];
    uid = snapshot['uid'];
    dUid = snapshot['dUid'];

    // postcode = snapshot["postcode"];
    // state = snapshot["state"];
  }
}
