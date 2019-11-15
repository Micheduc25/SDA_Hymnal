import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/models/userModel.dart';

class ProfileProvider {
  Firestore _firestore;

  ProfileProvider.instance() : _firestore = Firestore.instance;

  Stream<UserModel> streamUserProfile(String userId) {
    return _firestore
        .collection("users")
        .document(userId)
        .snapshots()
        .map((snapshot) {
      return UserModel.fromFirestore(snapshot);
    });
  }
}
