import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

class UserRepo {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<UserData?> getUserData() async {
    try {
      final user = _auth.currentUser;

      if (user == null) return null;

      final doc = await _firestore.collection("users").doc(user.uid).get();

      if (!doc.exists) return null;

      final data = doc.data();

      if (data == null) return null;

      return UserData.fromJson(data);
    } catch (e) {
      throw Exception("Failed to get user data: $e");
    }
  }

  static Future<void> updateUserName(String name) async {
    try {
      final user = _auth.currentUser;

      if (user == null) throw Exception("User not logged in");

      // Update FirebaseAuth display name
      await user.updateDisplayName(name);
      await user.reload();

      // Update Firestore
      await _firestore.collection("users").doc(user.uid).update({"name": name});
    } catch (e) {
      throw Exception("Failed to update name: $e");
    }
  }

  static Future<void> updatePhoto(String photoUrl) async {
    try {
      final user = _auth.currentUser;

      if (user == null) throw Exception("User not logged in");

      await user.updatePhotoURL(photoUrl);
      await user.reload();

      await _firestore.collection("users").doc(user.uid).update({
        "photo": photoUrl,
      });
    } catch (e) {
      throw Exception("Failed to update photo: $e");
    }
  }

  static Future<User?> refreshAuthUser() async {
    await _auth.currentUser?.reload();
    return _auth.currentUser;
  }
}
