import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/hym.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static List<String> letters = [
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z"
  ];

  Hym toHym(Map<String, dynamic> map) {
    Map<int, String> myversesMap = {};
    List<String> myversesArray = map["verses"].split("\n\n");

    for (int i = 0; i < myversesArray.length; i++) {
      myversesMap[i] = myversesArray[i];
    }
    return Hym(
        author: map["author"],
        
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

  static Future<List<Map<String, dynamic>>> getHymsByNumbers(
      List<int> numbers) async {
    List<Map<String, dynamic>> hyms = await DBConnect().getHyms();
    List<Map<String, dynamic>> result = hyms.where((hym) {
      if (numbers.contains(hym["number"])) {
        return true;
      } else
        return false;
    }).toList();

    return result;
  }

  static setFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(number.toString(), number);
  }

  static removeFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(number.toString());
  }

  static Future<bool> isFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(number.toString())) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> getHymsByTitle(String title) async {
    List<Map<String, dynamic>> hyms = await DBConnect().getHyms();
    //  String a="";
    //  if(a.toLowerCase())
    if (hyms != null) {
      List<Map<String, dynamic>> result = hyms.where((hym) {
        if (hym["title"].toLowerCase().contains(title.toLowerCase()) &&
            title.length > 1) {
          print(title + " found");
          return true;
        } else
          return false;
      }).toList();

      return result;
    } else {
      print("result was null");
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getHymnByFirstLetter(
      String firstLetter) async {
    List<Map<String, dynamic>> hyms = await DBConnect().getHyms();
    //  String a="";
    //  if(a.startsWith(pattern))
    if (hyms != null) {
      List<Map<String, dynamic>> result = hyms.where((hym) {
        if (hym["title"].toLowerCase().startsWith(firstLetter.toLowerCase())) {
          return true;
        } else
          return false;
      }).toList();

      // print("matches for letter $firstLetter are   " + result.toString());
      return result;
    } else {
      print("result was null");
      return null;
    }
  }

  static Future<Map<String, List<Map<String, dynamic>>>>
      getAllHymsByFirstLetters() async {
    Map<String, List<Map<String, dynamic>>> finalHyms = {};
    List<String> letters = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "f",
      "g",
      "h",
      "i",
      "j",
      "k",
      "l",
      "m",
      "n",
      "o",
      "p",
      "q",
      "r",
      "s",
      "t",
      "u",
      "v",
      "w",
      "x",
      "y",
      "z"
    ];

    for (int i = 0; i < letters.length; i++) {
      List<Map<String, dynamic>> temp;
      temp = await getHymnByFirstLetter(letters[i]);

      try {
        if (temp.isNotEmpty) {
          finalHyms[letters[i]] = temp;
          print(temp);
        }
      } catch (e) {
        print("empty index: " + e.toString());
      }
    }

    // print("hyms in alphabetic are    " + finalHyms.toString());
    return finalHyms;
  }

  static String getHymCategory(int hymNumber){
  
    if((hymNumber>=1&&hymNumber<=69)||(hymNumber>=696&&hymNumber<=708)){
      return "Worship";
    }

    else if((hymNumber>=70&&hymNumber<=73)||hymNumber==709){
      return "Trinity";
    }

    else if((hymNumber>=74&&hymNumber<=114)){
      return "God the Father";
    }

    else if((hymNumber>=115&&hymNumber<=256)){
      return "Jesus Christ";
    }

    else if((hymNumber>=257&&hymNumber<=270)){
      return "Holy Spirit";
    }

    else if((hymNumber>=271&&hymNumber<=278)){
      return "Holy Scriptures";
    }

    else if((hymNumber>=279&&hymNumber<=343)){
      return "Gospel";
    }

    else if((hymNumber>=344&&hymNumber<=379)){
      return "Christian Church";
    }

    else if((hymNumber>=380&&hymNumber<=420)){
      return "Doctrines";
    }

    else if((hymNumber>=421&&hymNumber<=437)){
      return "General";
    }

    else if((hymNumber>=438&&hymNumber<=454)){
      return "Early Advent";
    }

    else if((hymNumber>=455&&hymNumber<=649)){
      return "Christian Life";
    }

    else if((hymNumber>=650&&hymNumber<=659)){
      return "Christian Home";
    }

    else if((hymNumber>=660&&hymNumber<=695)){
      return "Sentences and Responses";
    }

    else if((hymNumber>=696&&hymNumber<=920)){
      return "Worship Aids";
    }

    return null;
    
  }


  static Future<Map<String,List< Map<String,dynamic>>>> getAllHymsByCategory()async{

    List<String> categories=["Worship", 'Trinity', 'God the Father',
    
    'Jesus Christ', 'Holy Spirit', 'Holy Scriptures', 'Gospel', 
    'Christian Church',
    'Doctrines', 'General', 'Early Advent', 'Christian Life', 'Christian Home', 
    'Sentences and Responses',
    'Worship Aids'
    ];

    List<Map<String,dynamic>> allHyms=await DBConnect().getHyms();

    Map<String,List< Map<String,dynamic>>> hymsByCategory={};

    categories.forEach((category){

      hymsByCategory[category]=allHyms.where(
        (hym){
          
       
        if(hym['category'].toUpperCase()==category.toUpperCase()){
          
          return true;
        }
        else{
          return false;
        }
      }).toList();
    });


    return hymsByCategory;
  }
}
