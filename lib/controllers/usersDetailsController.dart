import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fallsa_admin/model/usersDetailsModel.dart';
import 'package:fallsa_admin/services/database.dart';
import 'package:get/get.dart';

class UsersDetailsController extends GetxController {
  // Rxn<List<UserDetailsModel>> userList = Rxn<List<UserDetailsModel>>();
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxList<UserDetailsModel> userDetails = RxList<UserDetailsModel>([]).obs.value;
  CollectionReference collectionReference;
// final MyRepository repository;
// UsersDetailsController(this.repository);

//   final _obj = ''.obs;
//   set obj(value) => this._obj.value = value;
//   get obj => this._obj.value;

  // RxList<UserDetailsModel> get userdetails => userList.value;
  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("userDetails");
    userDetails.bindStream(getAllUserDetails());
    // userList.bindStream(Database().userDetails());
  }

  Stream<List<UserDetailsModel>> getAllUserDetails() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => UserDetailsModel.fromMap(item)).toList());
}
