import 'package:fallsa_admin/pages/authentication/authentication.dart';
import 'package:fallsa_admin/pages/fallRisk/fallRisk.dart';
import 'package:fallsa_admin/pages/overview/overview.dart';
import 'package:fallsa_admin/pages/quizs/quiz.dart';
import 'package:fallsa_admin/pages/strengthTest/strengthTest.dart';
import 'package:fallsa_admin/pages/strengthTest/widgets/strengthTestTable.dart';
import 'package:fallsa_admin/pages/users/users.dart';

import 'package:fallsa_admin/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverViewPage());
    case UsersPageRoute:
      return _getPageRoute(UserPage());
    case FallRIskPageRoute:
      return _getPageRoute(FallRiskPage());
    case StrengthTestPageRoute:
      return _getPageRoute(StrengthTestPage());
    case QuizPageRoute:
      return _getPageRoute(QuizPage());
    case AuthenticationPageRoute:
      return _getPageRoute(AuthenticationPage());
    default:
      return _getPageRoute(OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(
    builder: (context) => child,
  );
}
