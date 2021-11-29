import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:movie_app/state_management/controllers/auth_controllers.dart';

FirebaseAuth auth = FirebaseAuth.instance;

final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();

// AuthController authController = AuthController.instance;

GoogleSignIn googleSign = GoogleSignIn();

FacebookAuth fbAuth = FacebookAuth.instance;
