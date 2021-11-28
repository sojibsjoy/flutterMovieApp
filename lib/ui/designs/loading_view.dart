import 'package:flutter/material.dart';
import 'package:movie_app/state_management/constants/constants.dart';

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
