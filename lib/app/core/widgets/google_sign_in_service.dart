import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // static bool _isInitialized = false;

  static Future<void> _initialize() async {
    log('Initializing Google Sign-In with:');
    log(
      'Client ID: 102792963565-3ugsov23978rn4s16ugstv4favjdmacp.apps.googleusercontent.com',
    );
    log(
      'Server Client ID: 102792963565-msilqo27io6lgd1q98t644gjedhfefai.apps.googleusercontent.com',
    );

    await _googleSignIn.initialize(
      clientId:
          '102792963565-3ugsov23978rn4s16ugstv4favjdmacp.apps.googleusercontent.com',
      serverClientId:
          '102792963565-msilqo27io6lgd1q98t644gjedhfefai.apps.googleusercontent.com',
    );

    log('Google Sign-In initialized successfully');
  }

  static Future<User?> signInWithGoogle() async {
    try {
      await _initialize();

      // Simple sign-out to clear any existing state
      await _googleSignIn.signOut();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
      log('Google Sign-In user: $googleUser');
      log('--------------------------------');

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      log('Google Sign-In auth: $googleAuth');
      log('--------------------------------');

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      log('Google Sign-In credential: $credential');
      log('--------------------------------');

      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      log('Google Sign-In userCredential: $userCredential');
      log('--------------------------------');

      return userCredential.user;
    } on GoogleSignInException catch (e) {
      log('Google Sign-In error: ${e.code} - ${e.description}');
      log('Error details: ${e.toString()}');
      log('--------------------------------');

      // Handle specific error cases
      switch (e.code) {
        case GoogleSignInExceptionCode.canceled:
          log('User canceled the sign-in process');
          log('This might be due to:');
          log('1. SHA-1 fingerprint mismatch in Firebase Console');
          log('2. Google account restrictions');
          log('3. Device credential manager issues');
          return null; // Return null instead of throwing
        default:
          log('Google Sign-In error: ${e.code}');
          rethrow;
      }
    } catch (e) {
      log('General Google Sign-In error: $e');
      log('--------------------------------');
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
