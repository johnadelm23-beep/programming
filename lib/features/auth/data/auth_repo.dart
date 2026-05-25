import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

      debugPrint(response.user!.uid);

      return response;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        throw 'Invalid email address.';
      } else {
        throw e.message ?? 'Authentication error';
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
}
