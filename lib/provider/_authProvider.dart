import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sda_hymnal/utils/config.dart';

class AuthProvider {
  FirebaseAuth _auth;
  Firestore _firestore;
  AuthProvider.instance()
      : _firestore = Firestore.instance,
        _auth = FirebaseAuth.instance;

  Future<String> createUser(String email, String password) async {
    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await user.sendEmailVerification();

      return "email sent";
    } catch (err) {
      if (err is PlatformException) {
        if (err.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
          return "already used";
        } else if (err.code == "ERROR_INVALID_EMAIL") {
          return "invalid email";
        }
      }
    }
    return null;
  }

  Future<String> loginUser(String email, String password) async {
    try {
      FirebaseUser user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return user.uid;
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "ERROR_INVALID_EMAIL") {
          return "invalid email";
        } else if (e.code == "ERROR_WRONG_PASSWORD") {
          return "wrong password";
        } else if (e.code == "ERROR_USER_NOT_FOUND") {
          return "user not found";
        }
      }
    }
    return null;
  }

  Future<String> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return "email sent";
  }

  Future<void> saveUser(String userName, String email, String uid) async {
    Map<String, dynamic> userMap = {};

    userMap[Config.email] = email;
    userMap[Config.userName] = userName;
    userMap[Config.createdOn] = FieldValue.serverTimestamp();

    try {
      await _firestore
          .collection("users")
          .document("$uid")
          .setData(userMap, merge: true);
    } catch (e) {
      print("error saving data : $e");
    }
  }
}
