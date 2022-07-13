import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/userDataController.dart';
import 'info_cards.dart';

class OverViewMediumScreen extends StatelessWidget {
  OverViewMediumScreen({Key key}) : super(key: key);
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return GetBuilder<UserDataContrller>(builder: (userDataController) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InfoCard(
                title: 'Total User',
                value: userDataContrller.userList.length.toString(),
                onTap: () {},
                topColour: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title: 'Total Fall Risk Test results',
                value: userDataContrller.fallRiskList.length.toString(),
                onTap: () {},
                topColour: Colors.orange,
              ),

              // ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              InfoCard(
                title: 'Total Strength Test',
                value: userDataContrller.strengthList.length.toString(),
                onTap: () {},
                topColour: Colors.orange,
              ),
              SizedBox(
                width: _width / 64,
              ),
              InfoCard(
                title: 'Total Strength Test',
                value: userDataContrller.quizList.length.toString(),
                onTap: () {},
                topColour: Colors.orange,
              ),
            ],
          )
        ],
      );
    });
  }
}
