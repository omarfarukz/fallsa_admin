import 'dart:ui';

import 'package:fallsa_admin/constants/controllers.dart';
import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/pages/overview/widgets/overview_cards_medium.dart';
import 'package:fallsa_admin/pages/overview/widgets/overview_cards_small.dart';
import 'package:fallsa_admin/pages/overview/widgets/oveview_cards_large.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OverViewPage extends StatelessWidget {
  // const OverViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                child: CustomText(
                  text: menuController.activeitem.value,
                  size: 24,
                  weight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView(
          children: [
            if (ResponsiveWidget.isLargeScreen(context) ||
                ResponsiveWidget.isMediumScreen(context))
              if (ResponsiveWidget.isCustomSize(context))
                 OverViewMediumScreen()
              else
                OverViewCardsLargeScreen()
            else
              OverViewCardsSmallScreen()
          ],
        ))
      ],
    );
  }
}
