import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class ReplyModel {
  ReplyModel(
      {this.date,
      this.likes,
      this.content,
      this.sender,
      this.senderName,
      this.replyId,
      this.commentPic,
      this.likers});
  final Timestamp date;
  final String content;
  final int likes;
  final String sender;
  final String commentPic;

  final String senderName;

  final String replyId;
  final List<String> likers;

  factory ReplyModel.fromFirestore(DocumentSnapshot snapshot) {
    return ReplyModel(
        date: snapshot.data[Config.date] ?? "",
        content: snapshot.data[Config.content] ?? "",
        likes: snapshot.data[Config.likes] ?? 0,
        sender: snapshot.data[Config.sender] ?? "",
        replyId: snapshot.data[Config.replyId],
        likers: snapshot.data[Config.likers] != null
            ? List.from(snapshot.data[Config.likers]) ?? []
            : [],
        commentPic: snapshot.data[Config.commentPic] ?? "",
        senderName: snapshot.data[Config.senderName] ?? "");
  }
}
