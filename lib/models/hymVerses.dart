class HymVerse {
  final int id;
  final String content;
  final int hymid;
  final int verseNumber;

  HymVerse({this.id, this.content, this.hymid, this.verseNumber});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'content': this.content,
      'hymid': this.hymid,
      'number': this.verseNumber
    };
  }
}
