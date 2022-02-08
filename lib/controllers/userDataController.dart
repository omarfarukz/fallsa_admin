import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/model/fallRiskModel.dart';
import 'package:fallsa_admin/model/quizModel.dart';
import 'package:fallsa_admin/model/strengthTestModel.dart';
import 'package:fallsa_admin/model/userModel.dart';
import 'package:fallsa_admin/model/usersDetailsModel.dart';
import 'package:get/get.dart';

class UserDataContrller extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<StrengthTestModel> _allStrengthList = [];
  List<StrengthTestModel> strengthList = [];

  List<QuizModel> _allQuizList = [];
  List<QuizModel> quizList = [];

  List<FallRiskModel> _allFallRiskList = [];
  List<FallRiskModel> fallRiskList = [];

  List<UserDetailsModel> _alluserList = [];
  List<UserDetailsModel> userList = [];

  // RxList<QuizModel> quizs = RxList<QuizModel>([]).obs.value;
  CollectionReference stcollectionReference;
  CollectionReference collectionReference;
  CollectionReference qcollectionReference;
  CollectionReference userCollectionReference;

  StreamSubscription strenghtSubs;
  StreamSubscription fallRisktSubs;
  StreamSubscription quizSubs;
  StreamSubscription userSubs;
  @override
  void onInit() {
    super.onInit();

    // collectionReference = firebaseFirestore.collection("fallRisk");
    // // fallRisks.bindStream(getAllfallRisk());
    // final fallriskStream = getAllfallRisk();
    // fallriskStream.listen((event) {
    //   _allFallRiskList = event;
    //   update();
    // });
    initfallRiskData();
    // print("stream listening");

    initStrengthData();
    // print("stream listening");
    // Future.delayed(Duration(milliseconds: 100), () {
    //   strengthList = _allStrengthList;
    //   // print("stream updated ${_allStrengthList.length}");
    //   update();
    // });
    //start streaming to list Quiz
    initQuizData();
    // qcollectionReference = firebaseFirestore.collection("quiz");
    // final streamQuiz = getAllQuizs();
    // streamQuiz.listen((event) {
    //   _allQuizList = event;
    //   update();
    // });
    // Future.delayed(Duration(milliseconds: 100), () {
    //   quizList = _allQuizList;
    //   update();
    // });

    // quizs.bindStream(getAllQuizs());
    // userCollectionReference = firebaseFirestore.collection("userDetails");
    // final userStream = getAllUsers();
    // userStream.listen((event) {
    //   _alluserList = event;
    //   update();
    // });
    // Future.delayed(Duration(milliseconds: 100), () {
    //   quizList = _allQuizList;
    //   update();
    // });
    initUsersData();
  }

  Future<void> initStrengthData() async {
    stcollectionReference = firebaseFirestore.collection("strength");
    // strengthTests.bindStream(getAllStrengthTest());

    strengthList = await stcollectionReference.get().then((query) =>
        query.docs.map((item) => StrengthTestModel.fromMap(item)).toList());
    update();
    final stream = getAllStrengthTest();
    strenghtSubs = stream.listen((event) {
      _allStrengthList = event;
      update();
    });
  }

  Future<void> initfallRiskData() async {
    collectionReference = firebaseFirestore.collection("fallRisk");
    fallRiskList = await collectionReference.get().then((query) =>
        query.docs.map((item) => FallRiskModel.fromMap(item)).toList());
    update();
    final fallriskStream = getAllfallRisk();
    fallriskStream.listen((event) {
      _allFallRiskList = event;
      update();
    });
  }

  Future<void> initQuizData() async {
    qcollectionReference = firebaseFirestore.collection("quiz");
    quizList = await qcollectionReference.get().then(
        (query) => query.docs.map((item) => QuizModel.fromMap(item)).toList());
    final streamQuiz = getAllQuizs();
    streamQuiz.listen((event) {
      _allQuizList = event;
      update();
    });
  }

  Future<void> initUsersData() async {
    userCollectionReference = firebaseFirestore.collection("userDetails");
    userList = await userCollectionReference.get().then((query) =>
        query.docs.map((item) => UserDetailsModel.fromMap(item)).toList());
    final userStream = getAllUsers();
    userStream.listen((event) {
      _alluserList = event;
      update();
    });
  }

  void searchStrength(String searchedText) {
    // print("searched $searchedText");
    if (searchedText.isNotEmpty) {
      strengthList = _allStrengthList
          .where((e) =>
              e.ic.contains(searchedText) ||
              e.name.toLowerCase().contains(searchedText.toLowerCase()))
          .toList();
    } else {
      strengthList = _allStrengthList;
    }
    update();
  }

  void searchQuiz(String searchedText) {
    // print("searched $searchedText");
    if (searchedText.isNotEmpty) {
      quizList = _allQuizList
          .where((e) =>
              e.ic.contains(searchedText) ||
              e.name.toLowerCase().contains(searchedText.toLowerCase()))
          .toList();
    } else {
      quizList = _allQuizList;
    }
    update();
  }

  void searchFallRisk(String searchedText) {
    if (searchedText.isNotEmpty) {
      fallRiskList = _allFallRiskList
          .where((e) =>
              e.ic.contains(searchedText) ||
              e.name.toLowerCase().contains(searchedText.toLowerCase()))
          .toList();
    } else {
      fallRiskList = _allFallRiskList;
    }
    update();
  }

  void searchUsers(String searchedText) {
    if (searchedText.isNotEmpty) {
      userList = _alluserList
          .where((e) =>
              e.ic.contains(searchedText) ||
              e.name.toLowerCase().contains(searchedText.toLowerCase()))
          .toList();
    } else {
      userList = _alluserList;
    }
    update();
  }

  Stream<List<FallRiskModel>> getAllfallRisk() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => FallRiskModel.fromMap(item)).toList());

  Stream<List<StrengthTestModel>> getAllStrengthTest() =>
      stcollectionReference.snapshots().map((query) =>
          query.docs.map((item) => StrengthTestModel.fromMap(item)).toList());
  Stream<List<QuizModel>> getAllQuizs() => qcollectionReference.snapshots().map(
      (query) => query.docs.map((item) => QuizModel.fromMap(item)).toList());
  Stream<List<UserDetailsModel>> getAllUsers() =>
      userCollectionReference.snapshots().map((query) =>
          query.docs.map((item) => UserDetailsModel.fromMap(item)).toList());

  @override
  void onClose() {
    strenghtSubs.cancel();
    fallRisktSubs.cancel();
    quizSubs.cancel();
    userSubs.cancel();
    super.onClose();
  }
}
