import 'package:cloud_firestore/cloud_firestore.dart';

class FallRiskModel {
  String name;
  String ic;
  String dUid;
  Timestamp date;
  String risk;
  int score;
  double tug;
  FallRiskModel(
      {this.name,
      this.ic,
      this.date,
      this.risk,
      this.score,
      this.dUid,
      this.tug});
  FallRiskModel.fromMap(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    date = snapshot['dateTime'];
    risk = snapshot['risk'];
    score = snapshot['score'];
    dUid = snapshot['dUid'];
    tug = snapshot['tug'];
  }
}
