import 'package:fallsa_admin/controllers/userController.dart';
import 'package:fallsa_admin/model/userModel.dart';
import 'package:fallsa_admin/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _firebaseUser = Rxn<User>();
  User get user => _firebaseUser.value;

  @override
  void onInit() {
    // TODO: implement onInit
    _firebaseUser.bindStream(_auth.authStateChanges());
    super.onInit();
  }

  // void createUser(
  //   // String name,
  //   String email,
  //   String password,
  // ) async {
  //   try {
  //     UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
  //         email: email.trim(), password: password);
  //     //create user in database.dart
  //     UserModel _user = UserModel(
  //       id: _authResult.user.uid,
  //       // name: name,
  //       email: _authResult.user.email,
  //     );
  //     if (await Database().createNewUser(_user)) {
  //       Get.find<UserController>().user = _user;
  //       Get.back();
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error creating Account",
  //       e.message,
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   }
  // }
  void login(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signup(String email, String password) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);

      Get.find<UserController>().user =
          await Database().getUser(_authResult.user.uid);
    } catch (e) {
      Get.snackbar(
        "Error signing in",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error Sign Out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
