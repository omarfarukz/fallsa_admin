import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/services/db.dart';
import 'package:get/get.dart';

class TempController extends GetxController {
  RxList users = [].obs;

  var number = 5.obs;

  @override
  void onInit() {
    // Db().getUsers().then((QuerySnapshot querySnapshot) {
    //   users = querySnapshot.docs as RxList;
    // });
    getUsers();
    super.onInit();
  }

  getUsers() async {
    DocumentReference documentReference =
        await FirebaseFirestore.instance.collection('userDetails').doc();
    documentReference.get().then((value) {
      RxList data = value.data();
      users = data;
    });
  }
}
