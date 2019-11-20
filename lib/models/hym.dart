import 'package:cloud_firestore/cloud_firestore.dart';

class Hym {
  final int number;
  final String title;
  final String author;
  final int noVerses;
  final String category;
  final String musicFile;

  final Map<dynamic, String> verses;

  Hym({
    this.number,
    this.noVerses,
    this.title,
    this.verses,
    this.author,
    this.category,
    this.musicFile,
  });

  factory Hym.fromMap(Map<String, dynamic> hymMap) {
    return Hym(
        number: hymMap['number'],
        noVerses: hymMap['no_verses'],
        title: hymMap['title'],
        verses: hymMap['verses'],
        author: hymMap['author'],
        category: hymMap['category']);
  }

  String get getMusicFileName => this.musicFile;
  int get getHymNumber => this.number;
  @override
  toString() {
    return this.toMap().toString();
  }

  Map<String, dynamic> toMap() {
    String allVerses = "";
    this.verses.forEach((index, verse) {
      allVerses += index.toString() + "\n\n" + verse + "\n \n";
    });
    return {
      'number': this.number,
      'title': this.title,
      'author': this.author,
      'verses': allVerses,
      'no_verses': this.noVerses,
      'category': this.category,
      'music_file': this.musicFile
    };
  }
}
