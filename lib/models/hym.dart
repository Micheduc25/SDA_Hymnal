class Hym {
  final int id;
  final int number;
  final String title;
  final String author;
  final int noVerses;

  final Map<int, String> verses;

  Hym(
      {this.id,
      this.number,
      this.noVerses,
      this.title,
      this.verses,
      this.author});

  Map<String, dynamic> toMap() {
    String allVerses = "";
    this.verses.forEach((index, verse) {
      allVerses += index.toString() + "\n\n" + verse + "\n \n";
    });
    return {
      'id': this.id,
      'number': this.number,
      'title': this.title,
      'author': this.author,
      'verses': allVerses,
      'no_verses': this.noVerses
    };
  }
}
