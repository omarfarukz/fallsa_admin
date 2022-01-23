import 'package:fallsa_admin/helpers/local_navigator.dart';
import 'package:fallsa_admin/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            // flex: 1,
            child: SideMenu()),
        Expanded(flex: 5, child: localNavigator())
      ],
    );
  }
}
