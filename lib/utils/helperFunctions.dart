import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/hym.dart';

class HelperFunctions {
  Hym toHym(Map<String, dynamic> map) {
    Map<int, String> myversesMap = {};
    List<String> myversesArray = map["verses"].split("\n\n");

    for (int i = 0; i < myversesArray.length; i++) {
      myversesMap[i] = myversesArray[i];
    }
    return Hym(
        author: map["author"],
        id: map["id"],
        number: map["number"],
        verses: myversesMap,
        noVerses: map["no_verses"],
        title: map["title"]);
  }

  static Future getHymByNumber(int hymNumber) async {
    Map<String, dynamic> hymn;
    await DBConnect().getHym(hymNumber).then((hym) {
      hymn = hym;
    });

    return hymn;
  }
}
