import 'package:flutter/material.dart';
import 'package:movie_app/state_management/constants.dart';
import 'package:movie_app/state_management/models/menu_model.dart';
import 'package:movie_app/ui/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        return HomePage();
      case MenuType.search:
        return Text("Search Page");
      case MenuType.download:
        return Text("Download Page");
      case MenuType.menu:
        return Text("menu Page");
      case MenuType.profile:
        return Text("Profile Page");
      default:
        return HomePage();
    }
  }
}
