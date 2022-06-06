import 'package:flutter/material.dart';

import 'info_cards.dart';

class OverViewMediumScreen extends StatelessWidget {
  const OverViewMediumScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: 'Total Customer',
              value: "10",
              onTap: () {},
              topColour: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: 'Total Fall Risk Test',
              value: "15",
              onTap: () {},
              topColour: Colors.orange,
            ),
            // SizedBox(
            //   width: _width / 64,
            // ),
            // InfoCard(
            //   title: 'Total Fall Risk Test',
            //   value: "15",
            //   onTap: () {},
            //   topColour: Colors.orange,
            // ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          children: [
            InfoCard(
              title: 'Total Strength Test',
              value: "10",
              onTap: () {},
              topColour: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: 'Total Strength Test',
              value: "10",
              onTap: () {},
              topColour: Colors.orange,
            ),
          ],
        )
      ],
    );
  }
}
