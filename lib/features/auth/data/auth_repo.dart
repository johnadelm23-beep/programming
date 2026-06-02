import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:programmin/features/auth/data/models/user_model.dart';

class AuthRepo {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // REGISTER
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

      await addUser(
        name: name,
        email: email,
        password: password,
        uId: response.user!.uid,
      );

      return response;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? "Register error";
    }
  }

  // LOGIN
  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  // ADD USER TO FIRESTORE
  static Future<void> addUser({
    required String name,
    required String email,
    required String password,
    required String uId,
  }) async {
    await FirebaseFirestore.instance.collection("users").doc(uId).set({
      "name": name,
      "email": email,
      "password": password,
      "isBlocked": false,
      "isAdmin": false,
    });
  }

  // GET USER DATA
  static Future<UserData?> getUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get();

    final data = doc.data();

    if (data == null) return null;

    if (data["isBlocked"] == true) return null;

    return UserData.fromJson(data);
  }

  // GOOGLE SIGN IN
  static Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      throw "Google sign-in cancelled";
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);

    final user = userCredential.user!;
    final ref = FirebaseFirestore.instance.collection("users").doc(user.uid);

    final doc = await ref.get();

    if (doc.exists && doc.data()?["isBlocked"] == true) {
      await _firebaseAuth.signOut();
      throw "Blocked account";
    }

    await ref.set({
      "uid": user.uid,
      "name": user.displayName ?? "User",
      "email": user.email ?? "",
      "photo": user.photoURL ?? "",
      "isBlocked": false,
      "isAdmin": false,
      "provider": "google",
      "createdAt": FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return userCredential;
  }
}
