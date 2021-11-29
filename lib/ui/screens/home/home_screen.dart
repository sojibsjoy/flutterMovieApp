import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/auth_constants.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';
import 'package:movie_app/state_management/models/menu_model.dart';
import 'package:movie_app/ui/pages/home_page.dart';
import 'package:movie_app/ui/pages/search_page.dart';
import 'package:movie_app/ui/screens/auth/auth_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // home page will be the initial page
  var menuType = MenuType.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appBgColor,
      body: SafeArea(
        child: getView(menuType),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        height: 65,
        width: double.infinity,
        color: CustomColors.appBgColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            btmIcon(menu: MenuType.home, icon: Icons.home_rounded),
            btmIcon(menu: MenuType.search, icon: Icons.search_rounded),
            btmIcon(
              menu: MenuType.download,
              icon: Icons.file_download_outlined,
            ),
            btmIcon(menu: MenuType.menu, icon: Icons.menu),
            btmIcon(menu: MenuType.profile, icon: Icons.person_outline),
          ],
        ),
      ),
    );
  }

  InkWell btmIcon({required MenuType menu, required IconData icon}) {
    return InkWell(
      onTap: () => setState(() {
        menuType = menu;
      }),
      child: Icon(
        icon,
        size: 40,
        color: menuType == menu ? Colors.blue : Colors.grey,
      ),
    );
  }

  Widget getView(MenuType menuType) {
    switch (menuType) {
      case MenuType.home:
        return const HomePage();
      case MenuType.search:
        return const SearchPage();
      case MenuType.download:
        return const Text("Download Page");
      case MenuType.menu:
        return const Text("menu Page");
      case MenuType.profile:
        AuthController.instance.fbSignOut();
        checkFbLogOut();
        return const Text("Profile Page");
      default:
        return const HomePage();
    }
  }

  checkFbLogOut() async {
    final AccessToken? accessToken = await fbAuth.accessToken;
    if (accessToken != null) {
      // user is logged in
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }
  }
}
