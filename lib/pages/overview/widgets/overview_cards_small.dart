import 'package:fallsa_admin/controllers/userDataController.dart';
import 'package:fallsa_admin/pages/overview/widgets/info_card_small.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewCardsSmallScreen extends StatelessWidget {
  OverViewCardsSmallScreen({Key key}) : super(key: key);
  final UserDataContrller userDataContrller = Get.put(UserDataContrller());
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return GetBuilder<UserDataContrller>(builder: (userDataContrller) {
      return SizedBox(
        height: 400,
        child: Column(children: [
          InfoCardSamll(
            title: 'Total Users',
            value: userDataContrller.userList.length.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSamll(
            title: 'Total Fall Risk Test Results',
            value: userDataContrller.fallRiskList.length.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSamll(
            title: 'Total Strength Test result',
            value: userDataContrller.strengthList.length.toString(),
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSamll(
            title: 'Total attempted Quiz',
            value: userDataContrller.quizList.length.toString(),
            onTap: () {},
            isActive: true,
          ),
        ]),
      );
    });
  }
}
