import 'package:flutter/material.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';

class LoadingView extends StatelessWidget {
  static String routeName = '/loading';
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appBgColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
