import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/ui/screens/auth/auth_page.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';
import 'package:movie_app/ui/screens/login/login_page.dart';
import 'package:movie_app/ui/screens/otp/otp_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: AuthPage.routeName,
          page: () => const AuthPage(),
        ),
        GetPage(
          name: LoginPage.routeName,
          page: () => const LoginPage(),
        ),
        GetPage(
          name: OTPPage.routeName,
          page: () => const OTPPage(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
      ],
      initialRoute: HomeScreen.routeName,
    );
  }
}
