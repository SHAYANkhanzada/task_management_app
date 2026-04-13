import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user details to Firestore
  Future<void> saveUserDetails(String uid, String name, String email) async {
    try {
      await _db.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to save user details to Firestore: $e');
    }
  }

  // Retrieve user details from Firestore
  Future<DocumentSnapshot> getUserDetails(String uid) async {
    try {
      return await _db.collection('users').doc(uid).get();
    } catch (e) {
      throw Exception('Failed to retrieve user details from Firestore: $e');
    }
  }

  // Stream of user data
  Stream<DocumentSnapshot> userDataStream(String uid) {
    return _db.collection('users').doc(uid).snapshots();
  }
}
