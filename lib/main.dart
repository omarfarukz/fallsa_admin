import 'package:fallsa_admin/controllers/bindings/authBinding.dart';
import 'package:fallsa_admin/controllers/menu_controller.dart';
import 'package:fallsa_admin/controllers/navigation_controller.dart';
import 'package:fallsa_admin/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(MenuController());
  Get.put(NavigationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialRoute: AuthenticationPageRoute,
      initialBinding: AuthBinding(),

      // unknownRoute: GetPage(
      //     name: "/not-found",
      //     page: () => PageNotFound(),
      //     transition: Transition.fadeIn),
      // getPages: [
      //   GetPage(
      //       name: rootRoute,
      //       page: () {
      //         return SiteLayout();
      //       }),
      //   GetPage(
      //       name: AuthenticationPageRoute, page: () => AuthenticationPage()),
      // ],
      // debugShowCheckedModeBanner: false,
      title: "Dashboard",
      // theme: ThemeData(
      //     scaffoldBackgroundColor: Colors.white,
      //     textTheme:
      //         GoogleFonts.mulishTextTheme(Theme.of(context).textTheme).apply(
      //       bodyColor: Colors.black,
      //     ),
      //     pageTransitionsTheme: PageTransitionsTheme(builders: {
      //       TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      //       TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
      //     }),
      //     primaryColor: Colors.blue),
      home: Root(),
    );
  }
}
