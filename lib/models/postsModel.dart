import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class PostModel {
  const PostModel({this.date, this.likes, this.content, this.commentsId});

  final String date;
  final String content;
  final int likes;
  final String commentsId;

  factory PostModel.fromFirestore(DocumentSnapshot snapshot) {
    return PostModel(
        date: snapshot.data[Config.date] ?? "",
        content: snapshot.data[Config.content] ?? "",
        likes: snapshot.data[Config.likes] ?? 0,
        commentsId: snapshot.data[Config.commentsId] ?? "");
  }
}
