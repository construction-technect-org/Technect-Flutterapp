import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static bool _isInitialized = false;

  static Future<void> _initialize() async {
    if (!_isInitialized) {
      await _googleSignIn.initialize(
        clientId:
            '102792963565-3ugsov23978rn4s16ugstv4favjdmacp.apps.googleusercontent.com',
        serverClientId:
            '484988555302-d91nev5jn5sit0qoe3oehpgpp58pl5mt.apps.googleusercontent.com',
      );
      _isInitialized = true;
    }
  }

  static Future<User?> signInWithGoogle() async {
    try {
      await _initialize();

      await _googleSignIn.signOut();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      return userCredential.user;
    } on GoogleSignInException catch (e) {
      switch (e.code) {
        case GoogleSignInExceptionCode.canceled:
          log('User canceled the sign-in process');
          return null;
        default:
          log('Google Sign-In error: ${e.code}');
          rethrow;
      }
    } catch (e) {
      log('General Google Sign-In error: $e');
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      log('Error signing out: $e');
      rethrow;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
