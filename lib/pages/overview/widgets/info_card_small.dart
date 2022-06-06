import 'package:fallsa_admin/constants/style.dart';
import 'package:fallsa_admin/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class InfoCardSamll extends StatelessWidget {
  InfoCardSamll({
    Key key,
    this.title,
    this.value,
    this.isActive = false,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String value;
  final bool isActive;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: isActive ? active : lightGrey, width: .5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              size: 24,
              weight: FontWeight.w300,
              color: isActive ? active : lightGrey,
            ),
            CustomText(
              text: value,
              size: 24,
              weight: FontWeight.w300,
              color: isActive ? active : lightGrey,
            ),
          ],
        ),
      ),
    );
  }
}
