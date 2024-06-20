import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('users');


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

}
