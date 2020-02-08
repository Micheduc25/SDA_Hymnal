import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class CommentModel {
  CommentModel(
      {this.date,
      this.likes,
      this.content,
      this.sender,
      this.commentPic,
      this.senderName,
      this.likers,
      this.commentId,
      this.repliesId,
      this.replies});
  final String commentId;
  final Timestamp date;
  final String content;
  final int likes;
  final String sender;
  final String commentPic;
  String senderName;
  final List<String> likers;
  final String repliesId;
  int replies;

  factory CommentModel.fromFirestore(DocumentSnapshot snapshot) {
    return CommentModel(
        date: snapshot.data[Config.date] ?? "",
        content: snapshot.data[Config.content] ?? "",
        likes: snapshot.data[Config.likes] ?? 0,
        sender: snapshot.data[Config.sender] ?? "",
        commentPic: snapshot.data[Config.commentPic] ?? "",
        senderName: snapshot.data[Config.senderName] ?? "",
        repliesId: snapshot.data[Config.repliesId] ?? "",
        likers: snapshot.data[Config.likers] != null
            ? List.from(snapshot.data[Config.likers]) ?? []
            : [],
        commentId: snapshot.data[Config.commentsId] ?? "",
        replies: snapshot.data["replies"] ?? 0);
  }
}
