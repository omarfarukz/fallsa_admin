import 'package:cloud_firestore/cloud_firestore.dart';

class QuizModel {
  String name;
  String ic;
  Timestamp date;
  String preCorrect;
  String preWrong;
  String postCorrect;
  // String postWrong;

  QuizModel({
    this.name,
    this.ic,
    this.date,
    this.postCorrect,
    // this.postWrong,
    this.preCorrect,
    // this.preWrong,
  });
  QuizModel.fromMap(
    DocumentSnapshot snapshot,
  ) {
    name = snapshot['name'];
    ic = snapshot['ic'];
    date = snapshot['dateTime'];
    postCorrect = snapshot['postCorrect'];
    // // postWrong = snapshot['postWrong'];
    preCorrect = snapshot['preCorrect'];
    // preWrong = snapshot['preWrong'];
  }
}
