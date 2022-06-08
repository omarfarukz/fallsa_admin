import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/model/fallRiskModel.dart';
import 'package:fallsa_admin/model/quizModel.dart';
import 'package:fallsa_admin/model/strengthTestModel.dart';
import 'package:fallsa_admin/model/usersDetailsModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserDataContrller extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  List dactorData = [];

  List<UserDetailsModel> _alluserList = [];
  List<UserDetailsModel> userList = [];
  List<UserDetailsModel> dUserList = [];

  List<FallRiskModel> _allFallRiskList = [];
  List<FallRiskModel> fallRiskList = [];
  List<FallRiskModel> dFallRiskList = [];

  List<StrengthTestModel> _allStrengthList = [];
  List<StrengthTestModel> strengthList = [];
  List<StrengthTestModel> dStrengthList = [];

  List<QuizModel> _allQuizList = [];
  List<QuizModel> quizList = [];
  List<QuizModel> dQuizList = [];

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
  //1st we will check the acess true or not

  bool isAcess = false;
  //then we will check the doctor id
  String doctorId = "";
  String adminName = "Omar";

  //then weather it is doctor or researcher
  bool isDoctor = true;
  bool isAdmin = false;

  @override
  void onInit() {
    super.onInit();
    initAdmin();
    initAcess();
    initaccType();
    initDoctorData();
    initadnminName();
    // print("The UID is : ${user.uid}");
    Future.delayed(Duration(seconds: 1), () {
      try {
        // print(' The doctor Id: $doctorId');
        // print("The account Type is doctor:  $isDoctor");
        // print("The account Status is active:  $isAcess");
        initStrengthData();
        initQuizData();
        initUsersData();
        initfallRiskData();
      } catch (e) {
        print(e);
      }
    });
  }

//check the account type
  Future<void> initaccType() async {
    await firebaseFirestore
        .collection('admin')
        .doc(user.uid.toString())
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) =>
              isDoctor = documentSnapshot['isDoctor'],
        );
  }

//check the admin access
  Future<void> initAdmin() async {
    await firebaseFirestore
        .collection('admin')
        .doc(user.uid.toString())
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) =>
              isAdmin = documentSnapshot['isAdmin'],
        );
  }

//check the account status
  Future<void> initAcess() async {
    await firebaseFirestore
        .collection('admin')
        .doc(user.uid.toString())
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) =>
              isAcess = documentSnapshot['isAccess'],
        );
  }

//check doctor id
  Future<void> initDoctorData() async {
    await firebaseFirestore
        .collection('admin')
        .doc(user.uid.toString())
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) =>
              doctorId = documentSnapshot['docId'],
        );
  }

  Future<void> initadnminName() async {
    await firebaseFirestore
        .collection('admin')
        .doc(user.uid.toString())
        .get()
        .then(
          (DocumentSnapshot documentSnapshot) =>
              adminName = documentSnapshot['name'],
        );
  }

//Initial user list start here
  Future<void> initUsersData() async {
    userCollectionReference = firebaseFirestore.collection("userDetails");
    userList = await userCollectionReference.get().then((query) =>
        query.docs.map((item) => UserDetailsModel.fromMap(item)).toList());
    dUserList = userList.where((f) => f.dUid == doctorId).toList();
    update();
    final userStream = getAllUsers();
    userStream.listen((event) {
      _alluserList = event;
      update();
    });
  }
  //closed here

  //User search start

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

  void searchDUser(String searchedText) {
    if (searchedText.isNotEmpty) {
      dUserList = _alluserList
          .where((e) =>
              (e.ic.contains(searchedText) ||
                  e.name.toLowerCase().contains(searchedText.toLowerCase())) &&
              e.dUid == doctorId)
          .toList();
    } else {
      dUserList = _alluserList.where((e) => e.dUid == doctorId).toList();
    }
    update();
  } //search user stop

  //initial Strength Data start
  Future<void> initStrengthData() async {
    stcollectionReference = firebaseFirestore.collection("strength");
    strengthList = await stcollectionReference.get().then((query) =>
        query.docs.map((item) => StrengthTestModel.fromMap(item)).toList());
    dStrengthList = strengthList.where((f) => f.dUid == doctorId).toList();
    update();
    final strengthStream = getAllStrengthTest();
    strengthStream.listen((event) {
      _allStrengthList = event;
      update();
    });
  }

  //closed here
  void searchStrength(String searchedText) {
    if (searchedText.isNotEmpty) {
      strengthList = _allStrengthList
          .where((e) => e.ic.contains(searchedText.toLowerCase()))
          .toList();
    } else {
      strengthList = _allStrengthList;
    }
    update();
  }

  void searchDStrength(String searchedText) {
    if (searchedText.isNotEmpty) {
      dStrengthList = _allStrengthList
          .where((e) =>
              (e.ic.contains(searchedText) ||
                  e.name.toLowerCase().contains(searchedText.toLowerCase())) &&
              e.dUid == doctorId)
          .toList();
    } else {
      dStrengthList =
          _allStrengthList.where((e) => e.dUid == doctorId).toList();
    }
    update();
  }

//inititalized quiz here
  Future<void> initQuizData() async {
    qcollectionReference = firebaseFirestore.collection("quiz");
    quizList = await qcollectionReference.get().then(
        (query) => query.docs.map((item) => QuizModel.fromMap(item)).toList());

    dQuizList = quizList.where((g) => g.dUid == doctorId).toList();
    update();
    final streamQuiz = getAllQuizs();
    streamQuiz.listen((event) {
      _allQuizList = event;
    });
  }
  //closed here

  //quiz search start here

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

  void searchDQuiz(String searchedText) {
    if (searchedText.isNotEmpty) {
      dQuizList = _allQuizList
          .where((e) =>
              (e.ic.contains(searchedText) ||
                  e.name.toLowerCase().contains(searchedText.toLowerCase())) &&
              e.dUid == doctorId)
          .toList();
    } else {
      dQuizList = _allQuizList.where((e) => e.dUid == doctorId).toList();
    }
    update();
  }
//search quiz stop here

  //initial fall risk start
  Future<void> initfallRiskData() async {
    collectionReference = firebaseFirestore.collection("fallRisk");
    fallRiskList = await collectionReference.get().then((query) =>
        query.docs.map((item) => FallRiskModel.fromMap(item)).toList());

    dFallRiskList = fallRiskList.where((f) => f.dUid == doctorId).toList();
    update();

    final fallriskStream = getAllfallRisk();
    fallriskStream.listen((event) {
      _allFallRiskList = event;
      update();
    });
  }

  //closed here

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
              e.dUid == doctorId)
          .toList();
    } else {
      dFallRiskList =
          _allFallRiskList.where((e) => e.dUid == doctorId).toList();
    }
    update();
  }
  //fall risk search stop

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
