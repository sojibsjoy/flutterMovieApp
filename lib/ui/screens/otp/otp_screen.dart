import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/state_management/controllers/auth_controllers.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = '/otp';

  OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool showLoading = false;
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();
  String? otpCode;
  bool _dispose = false;
  var phoneNo = Get.arguments;

  Timer? _timer;
  int _time = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_time == 0) {
        setState(() {
          timer.cancel();
          AuthController.instance.verifyPhoneNumber(phoneNo);
        });
      } else {
        setState(() {
          _time--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer!.cancel();
    _dispose = true;
    super.dispose();
  }

  @override
  void initState() {
    if (!_dispose) {
      startTimer();
    }
    super.initState();
  }

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
                      'One Time Password',
                      style: TextStyle(
                        color: CustomColors.authTitleColor,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(45, 0, 0, 5),
                    child: SizedBox(
                      height: 130,
                      width: 280,
                      child: SingleChildScrollView(
                        child: Text(
                          'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus',
                          style: TextStyle(
                            color: CustomColors.authDesColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _textFieldOTP(
                                otpController: otpController1,
                                first: true,
                                last: false),
                            const SizedBox(width: 15),
                            _textFieldOTP(
                                otpController: otpController2,
                                first: true,
                                last: false),
                            const SizedBox(width: 15),
                            _textFieldOTP(
                                otpController: otpController3,
                                first: true,
                                last: false),
                            const SizedBox(width: 15),
                            _textFieldOTP(
                                otpController: otpController4,
                                first: true,
                                last: false),
                            const SizedBox(width: 15),
                            _textFieldOTP(
                                otpController: otpController5,
                                first: true,
                                last: false),
                            const SizedBox(width: 15),
                            _textFieldOTP(
                                otpController: otpController6,
                                first: true,
                                last: false),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Resend in ',
                            style: TextStyle(
                              color: CustomColors.authDesColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: '$_time:00',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' sec',
                                style: TextStyle(
                                  color: CustomColors.authDesColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          //TODO: Check for The OTP
                          setState(() {
                            showLoading = true;
                          });
                          verifyOtpCode();
                          print("checking otp");
                        },
                        child: const Text(
                          'Verify',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  verifyOtpCode() async {
    otpCode = otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text +
        otpController5.text +
        otpController6.text;
    print(otpCode);
    showLoading = await AuthController.instance.sendCodeToFirebase(otpCode!);
    if (!showLoading) {
      setState(() {});
    }
  }

  _textFieldOTP({TextEditingController? otpController, bool? first, last}) {
    return SizedBox(
      height: 65,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: TextField(
          controller: otpController,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 1 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            fillColor: CustomColors.inputFieldColor,
            filled: true,
            counter: const Offstage(),
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
      ),
    );
  }
}
