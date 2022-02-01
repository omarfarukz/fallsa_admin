import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/services/db.dart';
import 'package:get/get.dart';

class TempController extends GetxController {
  // RxList users = List.empty(growable: true).obs;
  RxList users = [].obs;

  var number = 5.obs;

  @override
  void onInit() {
    // Db().getUsers().then((QuerySnapshot querySnapshot) {
    //   RxList tempList = querySnapshot.docs as RxList;
    //   users = tempList;
    // });

    // DocumentReference documentReference =
    //     FirebaseFirestore.instance.collection('userDetails').doc();
    // documentReference.get().then((value) {
    //   RxList data = value.data() as RxList;
    //   users = data;
    // });
    // FirebaseFirestore.instance
    //     .collection('userDetails')
    //     .get()
    //     .then((QuerySnapshot querySnapshot) {
    //   querySnapshot.docs.forEach((doc) {
    //     users = doc.data();
    //   });
    // });
    FirebaseFirestore.instance
        .collection('admin')
        .doc()
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        users = documentSnapshot.data();
      }
    });

    super.onInit();
  }
}
