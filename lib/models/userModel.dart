import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class UserModel {
  final String userName;
  final String email;
  final String profilePicUrl;
  final String postsId;

  UserModel({this.userName, this.email, this.profilePicUrl, this.postsId});

  factory UserModel.fromFirestore(DocumentSnapshot snapshot) {
    return UserModel(
        email: snapshot.data[Config.email] ?? "",
        userName: snapshot.data[Config.userName] ?? "",
        profilePicUrl: snapshot.data[Config.profilePicUrl] ??
            "https://www.fourjay.org/myphoto/f/14/143147_avatar-png.jpg",
        postsId: snapshot.data[Config.postsId] ?? "");
  }
}
