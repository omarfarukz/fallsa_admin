import 'package:cloud_firestore/cloud_firestore.dart';

class StrengthTestModel {
  String name;
  String ic;
  Timestamp date;
  String dUid;

  int score;
  StrengthTestModel({this.name, this.ic, this.date, this.score, this.dUid});
  StrengthTestModel.fromMap(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    date = snapshot['dateTime'];

    score = snapshot['score'];
    dUid = snapshot['dUid'];
  }

  fromMap(QueryDocumentSnapshot<Object> item) {}
}
