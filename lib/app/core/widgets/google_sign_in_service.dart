import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Google Sign-In Service Class
class GoogleSignInService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  // static bool _isInitialized = false;

  static Future<void> _initialize() async {
    await _googleSignIn.initialize(
      clientId:
          '102792963565-3ugsov23978rn4s16ugstv4favjdmacp.apps.googleusercontent.com',
      serverClientId:
          '102792963565-msilqo27io6lgd1q98t644gjedhfefai.apps.googleusercontent.com',
    );
  }

  static Future<User?> signInWithGoogle() async {
    try {
      await _initialize();

      // Simple sign-out to clear any existing state
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
      // Handle specific error cases
      switch (e.code) {
        case GoogleSignInExceptionCode.canceled:
          return null; // Return null instead of throwing
        default:
          rethrow;
      }
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }
}
