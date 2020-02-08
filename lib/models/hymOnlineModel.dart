import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sda_hymnal/utils/config.dart';

class OnlineHym {
  const OnlineHym(
      {this.author,
      this.likes,
      this.title,
      this.number,
      this.commentsId,
      this.likers,
      this.key});

  final String title;
  final int number;
  final String author;
  final int likes;
  final String commentsId;
  final List<String> likers;
  final String key;

  factory OnlineHym.fromFirestore(DocumentSnapshot snapshot) {
    return OnlineHym(
        title: snapshot.data[Config.hymTitle] ?? "",
        number: snapshot.data[Config.number] ?? 0,
        author: snapshot.data[Config.hymAuthor] ?? "",
        likes: snapshot.data[Config.likes] ?? 0,
        commentsId: snapshot.data[Config.commentsId] ?? "",
        key: snapshot.data[Config.key] ?? "",
        likers: snapshot.data[Config.likers] != null
            ? List.from(snapshot.data[Config.likers]) ?? []
            : []);
  }
}
