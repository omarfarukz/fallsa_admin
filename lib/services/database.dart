import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/model/userModel.dart';
import 'package:fallsa_admin/model/usersDetailsModel.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("admin").doc(user.id).set({
        // "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("admin").doc(uid).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  // Stream<List<UserDetailsModel>> userDetails() {
  //   return _firestore
  //       .collection("users")
  //       .doc()
  //       .collection("user")
  //       .orderBy("dob", descending: true)
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<UserDetailsModel> retVal = List();
  //     query.docs.forEach((element) {
  //       retVal.add(UserDetailsModel.fromDocumentSnapshot(element));
  //     });
  //     return retVal;
  //   });
  // }
}
