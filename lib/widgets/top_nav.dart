import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

final emailController = TextEditingController();

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 28,
                  ),
                ),
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState.openDrawer();
              },
              icon: const Icon(Icons.menu),
            ),
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
              text: "Dash",
              color: lightGrey,
              size: 20,
              weight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: dark.withOpacity(.7),
            ),
          ),
  
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),

          CustomText(
            text: "Admin Panel",
            color: lightGrey,
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              margin: const EdgeInsets.all(2),
              child: CircleAvatar(
                child: Icon(
                  Icons.person_add_alt_1_outlined,
                  color: dark,
                ),
              ),
            ),
          ),
        ],
      ),
      iconTheme: IconThemeData(color: dark),
      backgroundColor: Colors.transparent,
    );
