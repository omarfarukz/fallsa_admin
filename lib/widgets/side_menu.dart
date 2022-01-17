import 'package:fallsa_admin/constants/controllers.dart';
import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/routing/routes.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:fallsa_admin/widgets/side_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key key}) : super(key: key);

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
                SizedBox(
                  height: 40,
                ),
                Divider(
                  color: lightGrey.withOpacity(.1),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: sideMenueItems
                      .map((itemName) => SideMenuItem(
                            itemName: itemName == AuthenticationPageRoute
                                ? "Log Out"
                                : itemName,
                            onTap: () {
                              if (itemName == AuthenticationPageRoute) {
                                //go to log in page
                              }
                              if (!menuController.isActive(itemName)) {
                                menuController.changActiveitemTo(itemName);
                                if (ResponsiveWidget.isSmallScreen(context))
                                  Get.back();
                                //go to item name route
                              }
                            },
                          ))
                      .toList(),
                ),
              ],
            )
        ],
      ),
    );
  }
}
