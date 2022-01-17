import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeitem = OverViewPageRoute.obs;
  var hovberItem = "".obs;

  changActiveitemTo(String itemName) {
    activeitem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hovberItem.value = itemName;
  }

  isActive(String itemName) => activeitem.value == itemName;
  isHovering(String itemName) => hovberItem.value == itemName;

  Widget returniconFor(String itemName) {
    switch (itemName) {
      case OverViewPageRoute:
        return _customIcon(Icons.trending_up, itemName);
      case UsersPageRoute:
        return _customIcon(Icons.people, itemName);
      case UsersDataPageRoute:
        return _customIcon(Icons.people_sharp, itemName);
      case AuthenticationPageRoute:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName))
      return Icon(
        icon,
        size: 22,
        color: dark,
      );

    return Icon(
      icon,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
