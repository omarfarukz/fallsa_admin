import 'package:fallsa_admin/model/userModel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Rxn<UserModel> _userModel = UserModel().obs;

  UserModel get user => _userModel.value;

  set user(UserModel value) => _userModel.value = value;

  void clear() {
    _userModel.value = UserModel();
  }
}
