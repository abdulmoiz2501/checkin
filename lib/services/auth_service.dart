import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        if (_auth.currentUser != null) {
          UserCredential userCredential = await _auth.currentUser!.linkWithCredential(credential);
          return userCredential.user;
        } else {
          UserCredential userCredential = await _auth.signInWithCredential(credential);
          return userCredential.user;
        }
      } else {
        print('Google Sign-In aborted');
        return null;
      }
    } catch (e) {
      print('Google Sign-In error: $e');
      rethrow;  // Rethrow the exception so it can be caught in the onPressed method
    }
  }

  Future<User?> logInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // The user canceled the sign-in
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }


  /*Future<void> sendSignInWithEmailLink(String email) async {
    try {
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://your-app-url.com',
        handleCodeInApp: true,
        iOSBundleId: 'com.example.ios',
        androidPackageName: 'com.example.android',
        androidInstallApp: true,
        androidMinimumVersion: '23',
      );

      await _auth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings);
    } catch (e) {
      print('Error sending sign-in link to email: $e');
    }
  }*/

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  // Sign Up with Phone Number
  Future<void> signUpWithPhoneNumber(String phoneNumber, Function(String) codeSentCallback) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print('Verification failed with error: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  // Log In with Phone Number
  Future<void> loginWithPhoneNumber(String phoneNumber, Function(String) codeSentCallback) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        } else {
          print('Verification failed with error: ${e.message}');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<User?> confirmVerificationCode(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }


  // Check if User Exists
  Future<bool> userExists(String phoneNumber) async {
    try {
      // checking if umber exist in firebase
      List<String> methods = await _auth.fetchSignInMethodsForEmail(phoneNumber);
      return methods.isNotEmpty;
    } catch (e) {
      return false; // if no user
    }
  }

  Future<List<String>> fetchSignInMethodsForEmail(String email) async {
    return await _auth.fetchSignInMethodsForEmail(email);
  }
  static Future<bool> isLoggedIn() async {
    var user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
