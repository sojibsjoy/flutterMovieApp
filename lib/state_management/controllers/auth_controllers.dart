import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/state_management/constants/auth_constants.dart';
import 'package:movie_app/state_management/constants/constants.dart';
import 'package:movie_app/ui/screens/auth/auth_screen.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

enum Status {
  error,
  waiting,
}

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  var verificationId;
  var status = Status.waiting;

  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  // late Rx<Future<AccessToken?>> fbAccount;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);

    // fbAccount = Rx<Future<AccessToken?>>(fbAuth.accessToken);
    // fbAccount.bindStream(fbAccount.stream);
    // ever(fbAccount, _setInitialFbScreen);
  }

  Future<bool> verifyPhoneNumber(String phoneNumber) async {
    bool returnFlag = false;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) async {
        returnFlag = false;
      },
      verificationFailed: (verificationFailed) async {
        showSnackBar(message: "Failed to Varify.");
        returnFlag = true;
      },
      codeSent: (verificationId, resendingToken) async {
        this.verificationId = verificationId;
        returnFlag = false;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
    return returnFlag;
  }

  Future<bool> sendCodeToFirebase(String code) async {
    print("code: $code");
    bool returnFlag = true;

    PhoneAuthCredential phoneAuthcredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: code);

    try {
      final authCredential =
          await auth.signInWithCredential(phoneAuthcredential);
      returnFlag = false;
      if (authCredential.user != null) {
        print('logged in');
        Get.offAll(() => const HomeScreen());
        return returnFlag;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(message: e.toString());
      returnFlag = false;
    }
    print("Req terminated");

    return returnFlag;
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      // user is logged in
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }
    _setInitialFbScreen;
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    if (googleSignInAccount != null) {
      // user is logged in
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }
    _setInitialFbScreen;
  }

  _setInitialFbScreen() async {
    final AccessToken? accessToken = await fbAuth.accessToken;
    if (accessToken != null) {
      // user is logged in
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const AuthScreen());
    }
  }

  Future<bool> signInWithFb() async {
    final LoginResult result = await fbAuth.login();
    if (result.status == LoginStatus.success) {
      // logged in
      return false;
    } else {
      showSnackBar(
          message: result.status.toString() + " " + result.message.toString());
      return true;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth.signInWithCredential(credential).catchError((onErr) {
          showSnackBar(message: 'Failed to log in.');
        });
      }
    } catch (e) {
      showSnackBar(message: e.toString());
    }
    return false;
  }

  Future<bool> register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      showSnackBar(message: e.toString());
    } catch (e) {
      showSnackBar(message: e.toString());
    }
    return false;
  }

  Future<bool> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      showSnackBar(message: e.toString());
    } catch (e) {
      showSnackBar(message: e.toString());
    }
    return false;
  }

  void authSignOut() async {
    try {
      auth.signOut();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void googleSignOut() {
    try {
      googleSign.signOut();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void fbSignOut() {
    try {
      fbAuth.logOut();
    } catch (e) {
      showSnackBar(message: e.toString());
    }
  }

  void showSnackBar({required String message}) {
    Get.snackbar(
      "Error Occured!",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CustomColors.inputFieldColor,
      colorText: Colors.white,
    );
  }
}
