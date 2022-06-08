import 'package:fallsa_admin/constants/style.dart';
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key key,
    this.title,
    this.value,
    this.topColour,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String value;
  final Color topColour;
  final bool isActive;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 136,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 6),
                  color: lightGrey.withOpacity(0.1),
                  blurRadius: 12),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  color: topColour ?? active,
                  height: 5,
                ))
              ],
            ),
            Expanded(
              child: Container(),
            ),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "$title\n",
                  style: TextStyle(
                      fontSize: 16, color: isActive ? active : lightGrey),
                ),
                TextSpan(
                  text: "$value\n",
                  style:
                      TextStyle(fontSize: 40, color: isActive ? active : dark),
                ),
              ]),
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Container(),
            ),
          ]),
        ),
      ),
    );
  }
}
