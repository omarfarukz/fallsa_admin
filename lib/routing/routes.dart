const rootRoute = "/";

const OverViewPageDisplayName = "Overview";
const OverViewPageRoute = "/overview";
const UsersPageDisplayName = "Users";
const UsersPageRoute = "/users";
const UsersDataPageDisplayName = "User Data";
const UsersDataPageRoute = "/userdata";
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
    UsersDataPageDisplayName,
    UsersDataPageRoute,
  ),
  MenuItem(
    AuthenticationPageDisplayName,
    AuthenticationPageRoute,
  ),
];
