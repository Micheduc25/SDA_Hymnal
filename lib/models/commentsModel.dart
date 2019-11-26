import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class CommentModel {
  const CommentModel(
      {this.date,
      this.likes,
      this.content,
      this.sender,
      this.commentPic,
      this.senderName});

  final Timestamp date;
  final String content;
  final int likes;
  final String sender;
  final String commentPic;
  final String senderName;

  factory CommentModel.fromFirestore(DocumentSnapshot snapshot) {
    return CommentModel(
        date: snapshot.data[Config.date] ?? "",
        content: snapshot.data[Config.content] ?? "",
        likes: snapshot.data[Config.likes] ?? 0,
        sender: snapshot.data[Config.sender] ?? "",
        commentPic: snapshot.data[Config.commentPic] ?? "",
        senderName: snapshot.data[Config.senderName] ?? "");
  }
}
