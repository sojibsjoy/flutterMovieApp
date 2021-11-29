import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';
import 'package:movie_app/ui/screens/otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/login';
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showLoading = false;
  bool _obsecure = true;
  final TextEditingController _emailCon = TextEditingController();
  final TextEditingController _passCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.appBgColor,
      body: SafeArea(
        child: showLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 25, 0.0, 0.0),
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 0, 130, 5),
                    child: Text(
                      'Let\'s sign you in.',
                      style: TextStyle(
                        color: CustomColors.authTitleColor,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(45, 0, 130, 0),
                    child: Text(
                      'Welcome back.\nYou\'ve been missed!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    height: 340,
                    padding: const EdgeInsets.symmetric(horizontal: 55),
                    child: Center(
                      child: Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: _emailCon,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                fillColor: CustomColors.inputFieldColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Phone, email or username",
                                labelStyle: TextStyle(
                                  color: CustomColors.authDesColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: CustomColors.inputFieldColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: CustomColors.inputFieldColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            TextFormField(
                              controller: _passCon,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                              decoration: InputDecoration(
                                fillColor: CustomColors.inputFieldColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                  color: CustomColors.authDesColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () => setState(() {
                                    _obsecure = !_obsecure;
                                  }),
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: CustomColors.authDesColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: CustomColors.inputFieldColor,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                    color: CustomColors.inputFieldColor,
                                  ),
                                ),
                              ),
                              obscureText: _obsecure,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: CustomColors.authDesColor,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Reset',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          color: CustomColors.authDesColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () async {
                            // Get.toNamed(OTPScreen.routeName);
                            // TODO: add logic for sign in
                            setState(() {
                              showLoading = true;
                            });
                            checkValidation(
                                _emailCon.text.trim(), _passCon.text.trim());
                          },
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(300, 50),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            // TODO: Add Facebook login  logic
                            setState(() {
                              showLoading = true;
                            });
                            fbSignIn();
                          },
                          child: const Text(
                            'Facebook',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(300, 50),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                CustomColors.fbBtnColor),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () {
                            // TODO: add login for google sign in
                            setState(() {
                              showLoading = true;
                            });
                            googleSignIn();
                          },
                          child: const Text(
                            'Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            fixedSize: MaterialStateProperty.all<Size>(
                              const Size(300, 50),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                CustomColors.googleBtnColor),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  fbSignIn() async {
    showLoading = await AuthController.instance.signInWithFb();
    setState(() {});
    if (!showLoading) {
      Get.offAll(() => const HomeScreen());
    }
  }

  googleSignIn() async {
    showLoading = await AuthController.instance.signInWithGoogle();
    setState(() {});
    if (!showLoading) {
      Get.offAll(() => const HomeScreen());
    }
  }

  checkValidation(String inputEmail, String inputPass) async {
    showLoading = true;
    bool isEmail = EmailValidator.validate(inputEmail);
    if (isEmail) {
      showLoading = await AuthController.instance.login(inputEmail, inputPass);
      setState(() {});
    } else if (!isEmail && inputEmail.length == 14) {      
      showLoading = await AuthController.instance.verifyPhoneNumber(inputEmail);
      if (!showLoading) {
        setState(() {});
        Get.toNamed(
          OTPScreen.routeName,
          arguments: inputEmail,
        );
      }
    }
  }
}
