import 'package:firebase_database/firebase_database.dart';

class UserService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<void> saveUserDetails({
    required String uid,
    required String name,
    required String gender,
    required String note,
    required String sexuality,
    required int age,
  }) async {
    try {
      await _db.child('users').child(uid).set({
        'name': name,
        'gender': gender,
        'note': note,
        'sexuality': sexuality,
        'age': age,
      });
    } catch (e) {
      print('Error saving user details: $e');
      throw e;
    }
  }

  Future<bool> checkUserExists(String uid) async {
    try {
      DataSnapshot snapshot = (await _db.child('users').child(uid).once()) as DataSnapshot;
      return snapshot.value != null;
    } catch (e) {
      print('Error checking user existence: $e');
      throw e;
    }
  }
}
