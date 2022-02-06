const rootRoute = "/";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";
const UsersPageDisplayName = "Users";
const UsersPageRoute = "/users";
const FallRIskDisplayName = "Fall Risk";
const FallRIskPageRoute = "/fallrisk";
const StrengthTestDisplayName = "Strength Test";
const StrengthTestPageRoute = "/strength";
const QuizDisplayName = "Quiz Result";
const QuizPageRoute = "/quiz";
const AuthenticationPageDisplayName = "Log Out";
const AuthenticationPageRoute = "/authentication";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenueItems = [
  MenuItem(
    OverViewPageDisplayName,
    OverViewPageRoute,
  ),
  MenuItem(
    UsersPageDisplayName,
    UsersPageRoute,
  ),
  MenuItem(
    FallRIskDisplayName,
    FallRIskPageRoute,
  ),
  MenuItem(
    StrengthTestDisplayName,
    StrengthTestPageRoute,
  ),
  MenuItem(
    QuizDisplayName,
    QuizPageRoute,
  ),
  MenuItem(
    AuthenticationPageDisplayName,
    AuthenticationPageRoute,
  ),
];
