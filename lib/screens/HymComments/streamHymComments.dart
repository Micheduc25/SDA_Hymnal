import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/models/commentsModel.dart';
import 'package:sda_hymnal/models/hymOnlineModel.dart';
import 'package:sda_hymnal/models/replyModel.dart';
import 'package:sda_hymnal/screens/HymComments/hymComments.dart';

class StreamHymComments {
  StreamHymComments.instance() : firestore = Firestore.instance;

  Firestore firestore;

  Stream<List<CommentModel>> streamHymComments(int hymNumber) {
    return firestore
        .collection("comments")
        .document("hym_${hymNumber.toString()}_comments")
        .collection("comments")
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => CommentModel.fromFirestore(docSnapshot))
          .toList();
    });
  }

  Stream<List<ReplyModel>> streamCommentReplies(
      int hymNumber, String commentId) {
    return firestore
        .collection("comments")
        .document("hym_${hymNumber.toString()}_comments")
        .collection("replies")
        .document(commentId)
        .collection("replies")
        .snapshots()
        .map((snapshot) {
      return snapshot.documents
          .map((docSnapshot) => ReplyModel.fromFirestore(docSnapshot))
          .toList();
    });
  }

  Stream<OnlineHym> streamHymModel(int hymNumber) {
    return firestore
        .collection("hyms")
        .document("hym_${hymNumber.toString()}")
        .snapshots()
        .map((snapshot) {
      return OnlineHym.fromFirestore(snapshot);
    });
  }
}
