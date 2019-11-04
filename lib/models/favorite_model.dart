class Favorite {
  final int hymNumber;

  Favorite({this.hymNumber});

  Map<String, dynamic> toMap() {
    return {'number': hymNumber};
  }
}
