import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/auth_constants.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';
import 'package:movie_app/ui/screens/auth/auth_screen.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              'assets/user.png',
              height: 200,
              width: 200,
            ),
          ),
          const Text(
            'Md. Sojib Sarker',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Flutter Developer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          infoContainer(Icons.call, '+8801716-589947'),
          const SizedBox(
            height: 20,
          ),
          infoContainer(Icons.mail, 'sojib.vu@gmail.com'),
          const SizedBox(
            height: 20,
          ),
          infoContainer(Icons.shop, 'Student \nDept. of CSE'),
          const SizedBox(
            height: 20,
          ),
          infoContainer(Icons.home, 'Varendra University'),
          const SizedBox(
            height: 35,
          ),
          TextButton(
            onPressed: signOutProcess,
            child: const Text(
              'Sign out',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                const Size(300, 50),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Container infoContainer(IconData icon, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35),
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(
            width: 25,
          ),
          Icon(
            icon,
            size: 30,
          ),
          const SizedBox(
            width: 40,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }

  void signOutProcess() {
    AuthController.instance.fbSignOut();
    checkFbLogOut();
    auth.signOut();
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
