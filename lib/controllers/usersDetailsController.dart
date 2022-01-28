import 'package:fallsa_admin/model/usersDetailsModel.dart';
import 'package:fallsa_admin/services/database.dart';
import 'package:get/get.dart';

class UsersDetailsController extends GetxController {
  Rxn<List<UserDetailsModel>> userList = Rxn<List<UserDetailsModel>>();

// final MyRepository repository;
// UsersDetailsController(this.repository);

//   final _obj = ''.obs;
//   set obj(value) => this._obj.value = value;
//   get obj => this._obj.value;

  List<UserDetailsModel> get userdetails => userList.value;
  @override
  void onInit() {
    userList.bindStream(Database().userDetails());
  }
}
