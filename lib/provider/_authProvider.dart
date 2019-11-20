import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:sda_hymnal/utils/config.dart';

class AuthProvider {
  FirebaseAuth _auth;
  Firestore _firestore;
  StorageReference _storage;
  AuthProvider.instance()
      : _firestore = Firestore.instance,
        _auth = FirebaseAuth.instance,
        _storage = FirebaseStorage.instance.ref().child("users");

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
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return "email sent";
    } catch (err) {
      if (err is PlatformException) {
        if (err.code == "ERROR_INVALID_EMAIL") {
          return "invalid email";
        } else if (err.code == "ERROR_USER_NOT_FOUND") {
          return "user not found";
        }
      }
    }
    return null;
  }

  Future<void> saveUser(String userName, String email, String uid,
      {String mode = "create"}) async {
    Map<String, dynamic> userMap = {};

    if (mode == "create") {
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
    } else if (mode == "update") {
      userMap[Config.email] = email;
      try {
        print(email);
        await _firestore
            .collection("users")
            .document("$uid")
            .updateData(userMap);
        print("updated email");
      } catch (e) {
        print("error saving data : $e");
      }
    }
  }

  Future<String> editEmail(String newEmail) async {
    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      try {
        await user.updateEmail(newEmail);
        await user.reload();
        await user.sendEmailVerification();
        return "email sent";
      } catch (err) {
        if (err is PlatformException) {
          if (err.code == "ERROR_INVALID_CREDENTIAL") {
            return "invalid email";
          } else if (err.code == "ERROR_EMAIL_ALREADY_IN_USE") {
            return "email already used";
          } else if (err.code == "ERROR_REQUIRES_RECENT_LOGIN") {
            return "login timeout";
          }
        }
      }
    } else {
      return "not logged in";
    }

    return null;
  }

  Future<String> deleteUser() async {
    FirebaseUser user = await _auth.currentUser();
    String userId = user.uid;

    try {
      await _firestore
          .collection("users")
          .document(userId)
          .delete()
          .catchError((Object err) {
        print("error on firestore");
      });

      try {
        await _storage.child(userId).child("profilePic").delete();
      } catch (e) {
        print("file not found");
      } finally {
        await user.delete();
        print("success deleting");
      }

      return "delete success";
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == "ERROR_REQUIRES_RECENT_LOGIN") {
          return 'login timeout';
        }
      }
      return "delete error";
    }
  }

  Future<String> resendVerification() async {
    FirebaseUser user = await _auth.currentUser();

    try {
      await user.sendEmailVerification();
      return "email sent";
    } catch (err) {
      return "email not sent";
    }
  }
}
