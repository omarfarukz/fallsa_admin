import 'package:fallsa_admin/constants/controllers.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/controllers/authController.dart';
import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/pages/authentication/authentication.dart';
import 'package:fallsa_admin/routing/routes.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:fallsa_admin/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  SideMenu({Key key}) : super(key: key);
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: _width / 48,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icon/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(
                      width: _width / 48,
                    ),
                  ],
                ),
              ],
            ),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: sideMenueItems
                .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (item.route == AuthenticationPageRoute) {
                          //go to log in page

                          menuController
                              .changActiveitemTo(OverViewPageDisplayName);
                          authController.signOut();
                          Get.offAll(AuthenticationPageRoute);
                        }
                        if (!menuController.isActive(item.name)) {
                          menuController.changActiveitemTo(item.name);
                          if (ResponsiveWidget.isSmallScreen(context))
                            Get.back();
                          //go to item name route
                          navigationController.navigateTo(item.route);
                        }
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
