import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/widgets/Horizontal_menu.dart';
import 'package:fallsa_admin/widgets/vertical_menu_item.dart';
import 'package:flutter/material.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final Function onTap;
  const SideMenuItem({Key key, this.itemName, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context))
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );

    return HorizontalMenueItem(
      itemName: itemName,
      onTap: onTap,
    );
  }
}
