import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/auth_constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';
import 'package:movie_app/ui/designs/loading_view.dart';
import 'package:movie_app/ui/screens/auth/auth_screen.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';
import 'package:movie_app/ui/screens/login/login_screen.dart';
import 'package:movie_app/ui/screens/otp/otp_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
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
          name: LoadingView.routeName,
          page: () => const LoadingView(),
        ),
        GetPage(
          name: AuthScreen.routeName,
          page: () => const AuthScreen(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: OTPScreen.routeName,
          page: () => const OTPScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
      ],
      home: const LoadingView(),
    );
  }
}
