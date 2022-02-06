import 'package:cloud_firestore/cloud_firestore.dart';

class FallRiskModel {
  String name;
  String ic;
  Timestamp date;
  String risk;
  int score;
  FallRiskModel({this.name, this.ic, this.date, this.risk, this.score});
  FallRiskModel.fromMap(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    date = snapshot['dateTime'];
    risk = snapshot['risk'];
    score = snapshot['score'];
  }
}
