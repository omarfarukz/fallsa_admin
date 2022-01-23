import 'package:fallsa_admin/constants/controllers.dart';
import 'package:fallsa_admin/routing/router.dart';
import 'package:fallsa_admin/routing/routes.dart';
import 'package:flutter/material.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: OverViewPageRoute,
      onGenerateRoute: generateRoute,
    );
