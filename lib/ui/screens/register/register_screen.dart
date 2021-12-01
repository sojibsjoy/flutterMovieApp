import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';

class RegisterScreen extends StatefulWidget {
  static String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                      'Let\'s sign you up.',
                      style: TextStyle(
                        color: CustomColors.authTitleColor,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(45, 0, 130, 0),
                    child: Text(
                      'Hello & welcome.\nNice to have you!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    height: 420,
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
                                labelText: "Email",
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
                        'Already have an account?',
                        style: TextStyle(
                          color: CustomColors.authDesColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Login',
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
                            setState(() {
                              showLoading = true;
                            });
                            checkValidation(
                                _emailCon.text.trim(), _passCon.text.trim());
                          },
                          child: const Text(
                            'Sign up',
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
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  checkValidation(String inputEmail, String inputPass) async {
    showLoading = true;
    bool isEmail = EmailValidator.validate(inputEmail);
    if (isEmail) {
      showLoading =
          await AuthController.instance.register(inputEmail, inputPass);
      setState(() {});
    } else {
      _emailCon.text = "";
      _passCon.text = "";
      setState(() {});
    }
    setState(() {});
  }
}
