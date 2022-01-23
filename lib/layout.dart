import 'package:fallsa_admin/helpers/responsiveness.dart';
import 'package:fallsa_admin/widgets/large_screen.dart';
import 'package:fallsa_admin/widgets/small_screen.dart';
import 'package:fallsa_admin/widgets/top_nav.dart';
import 'package:flutter/material.dart';

class SiteLayout extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topNavigationBar(context, scaffoldKey),
      key: scaffoldKey,
      drawer: Drawer(),
      body: ResponsiveWidget(
        largeScreen: LargeScreen(),
        smallScreen: SmallScreen(),
      ),
    );
  }
}
