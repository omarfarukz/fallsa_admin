import 'package:fallsa_admin/controllers/authController.dart';
import 'package:fallsa_admin/layout.dart';
import 'package:fallsa_admin/pages/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends GetWidget<AuthController> {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return GetX(
    //   initState: (_) async {
    //     Get.put<UserController>(UserController());
    //   },
    //   builder: (_) {
    //     if (Get.find<AuthController>().user?.uid != null) {
    //       return SiteLayout();
    //     } else {
    //       return AuthenticationPage();
    //     }
    //   },
    // );
    return Obx(() {
      return (Get.find<AuthController>().user != null)
          ? SiteLayout()
          : AuthenticationPage();
    });
  }
}
