import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/state_management/constants/auth_constants.dart';
import 'package:movie_app/ui/screens/auth/auth_screen.dart';
import 'package:movie_app/ui/screens/home/home_screen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

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

  void signInWithFb() async {
    final LoginResult result = await fbAuth.login();
    if (result.status == LoginStatus.success) {
      // logged in
      Get.offAll(() => const HomeScreen());
    } else {
      Get.snackbar(
        "Error",
        result.status.toString() + " " + result.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await auth
            .signInWithCredential(credential)
            .catchError((onErr) => print(onErr));
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message!,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      // this is solely for the Firebase Auth Exception
      // for example : password did not match
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void authSignOut() async {
    try {
      auth.signOut();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void googleSignOut() {
    try {
      googleSign.signOut();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void fbSignOut() {
    try {
      fbAuth.logOut();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
