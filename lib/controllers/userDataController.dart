import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/model/fallRiskModel.dart';
import 'package:fallsa_admin/model/quizModel.dart';
import 'package:fallsa_admin/model/strengthTestModel.dart';
import 'package:fallsa_admin/model/userModel.dart';
import 'package:fallsa_admin/model/usersDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:universal_html/html.dart';

class UserDataContrller extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  List<StrengthTestModel> _allStrengthList = [];
  List<StrengthTestModel> strengthList = [];

  List dactorData = [];

  List<QuizModel> _allQuizList = [];
  List<QuizModel> quizList = [];

  List<FallRiskModel> _allFallRiskList = [];
  List<FallRiskModel> fallRiskList = [];

  List<FallRiskModel> dFallRiskList = [];

  List<UserDetailsModel> _alluserList = [];
  List<UserDetailsModel> userList = [];

  // RxList<QuizModel> quizs = RxList<QuizModel>([]).obs.value;
  CollectionReference stcollectionReference;
  CollectionReference collectionReference;
  CollectionReference qcollectionReference;
  CollectionReference userCollectionReference;

  CollectionReference doctorCollection;

  StreamSubscription strenghtSubs;
  StreamSubscription fallRisktSubs;
  StreamSubscription quizSubs;
  StreamSubscription userSubs;
  StreamSubscription allFallRisk;
  String name;

  @override
  void onInit() {
    super.onInit();
    initDoctorData();
    try {
      print(' The doctor name: $name');
    } catch (e) {
      print(e);
    }

    initStrengthData();
    initQuizData();
    initUsersData();
    initfallRiskData();
  }

  Future<void> initStrengthData() async {
    stcollectionReference = firebaseFirestore.collection("strength");
    strengthList = await stcollectionReference.get().then((query) =>
        query.docs.map((item) => StrengthTestModel.fromMap(item)).toList());
    update();
    final stream = getAllStrengthTest();
    strenghtSubs = stream.listen((event) {
      _allStrengthList = event;
      update();
    });
  }

  Future<void> initDoctorData() async {
    await firebaseFirestore
        .collection('admin')
        .doc('rxAfnE5nERgddcvbEyyM')
        .get()
        .then((DocumentSnapshot documentSnapshot) =>
            name = documentSnapshot['name']);
  }

//initial fall risk start
  Future<void> initfallRiskData() async {
    collectionReference = firebaseFirestore.collection("fallRisk");
    fallRiskList = await collectionReference.get().then((query) =>
        query.docs.map((item) => FallRiskModel.fromMap(item)).toList());

    dFallRiskList = fallRiskList.where((f) => f.dUid == '123456').toList();
    update();

    final fallriskStream = getAllfallRisk();
    fallriskStream.listen((event) {
      _allFallRiskList = event;
      update();
    });
  }

  //closed here

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

//fall risk search start
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

  void searchDFallRisk(String searchedText) {
    print('searched $searchedText and is empty ${searchedText.isEmpty}');
    if (searchedText.isNotEmpty) {
      dFallRiskList = _allFallRiskList
          .where((e) =>
              (e.ic.contains(searchedText) ||
                  e.name.toLowerCase().contains(searchedText.toLowerCase())) &&
              e.dUid == '123456')
          .toList();
    } else {
      dFallRiskList =
          _allFallRiskList.where((e) => e.dUid == '123456').toList();
    }
    update();
  }
  //fall risk search stop

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

//Fall RIsk Stream all
  Stream<List<FallRiskModel>> getAllfallRisk() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => FallRiskModel.fromMap(item)).toList());
//untill here fall risk

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
    allFallRisk.cancel();
    super.onClose();
  }
}
