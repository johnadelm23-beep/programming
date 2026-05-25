import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

class AuthRepo {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await response.user!.updateDisplayName(name);

      debugPrint(response.user?.uid ?? "");

      addUser(
        name: name,
        email: email,
        password: password,
        uId: response.user!.uid,
      );
      return response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address.';
      } else {
        throw e.message ?? 'Authentication Failed';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address.';
      } else if (e.code == 'invalid-credential') {
        throw 'Invalid email or password.';
      } else {
        throw e.message ?? 'Login failed';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<void> addUser({
    required String name,
    required String email,
    required String password,
    required String uId,
  }) async {
    try {
      FirebaseFirestore.instance.collection("users").doc(uId).set({
        "name": name,
        "email": email,
        "password": password,
        "isBlocked": false,
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<UserData?> getUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser == null) return null;

      final user = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.uid)
          .get();

      final data = user.data();

      if (data?["isBlocked"] == true) return null;

      return UserData.fromJson(data ?? {});
    } catch (e) {
      return null;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        throw "Google sign-in cancelled";
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCredential.user;
      if (user == null) {
        throw "User not found";
      }
      final userRef = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid);
      final doc = await userRef.get();
      final data = doc.data();
      if (data != null && data["isBlocked"] == true) {
        await FirebaseAuth.instance.signOut();
        throw "This account is blocked";
      }
      await userRef.set({
        "uid": user.uid,
        "name": user.displayName ?? "User",
        "email": user.email ?? "",
        "photo": user.photoURL ?? "",
        "isBlocked": false,
        "provider": "google",
        "createdAt": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return userCredential;
    } catch (e) {
      throw e.toString();
    }
  }
}
