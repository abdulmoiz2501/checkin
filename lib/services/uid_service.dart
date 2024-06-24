import 'package:firebase_auth/firebase_auth.dart';

class UIDService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> getCurrentUID() async {
    String? uid;
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        uid = user.uid;
      }
    } catch (e) {
      print('Error getting UID: $e');
    }
    return uid;
  }
}
