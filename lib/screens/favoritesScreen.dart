import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<int> favorites;
  bool deleteEnable;
  bool _loading;
  List<Map<String, dynamic>> favHyms;
  List<int> favHymNumbers;
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    deleteEnable = false;
    _loading = false;
    StreamingSharedPreferences.instance.then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });

    DBConnect().getFavorites().then((numbers) {
      favHymNumbers = numbers;

      if (favHymNumbers.length > 0) {
        HelperFunctions.getHymsByNumbers(favHymNumbers).then((hyms) {
          favHyms = hyms;
          setState(() {});
        });
      } else {
        print("hyms are null oh");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'Favorite Screen',
      home: Scaffold(
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.favorite),
              SizedBox(
                width: 5,
              ),
              Text('Favorites'),
            ],
          ),
          automaticallyImplyLeading: true,
          centerTitle: true,
        ),
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.green[300],
                      child: ListTile(
                        title: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        trailing: Checkbox(
                          value: deleteEnable,
                          checkColor: Colors.white,
                          // activeColor: Colors.white,
                          onChanged: (value) {
                            setState(() {
                              deleteEnable = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: favHymNumbers != null && favHymNumbers.length > 0
                            ? ListView.builder(
                                itemCount: favHyms != null ? favHyms.length : 0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: !deleteEnable
                                            ? Icon(
                                                Icons.music_note,
                                                color: Colors.green,
                                              )
                                            : Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                        title: Text(favHyms[index]["number"]
                                                .toString() +
                                            " - " +
                                            favHyms[index]["title"]),
                                        onTap: () async {
                                          if (deleteEnable) {
                                            await DBConnect().removeFavorite(
                                                favHyms[index]["number"]);
                                            await HelperFunctions
                                                .removeFavorite(favHyms[index][
                                                    "number"]); //from shareddpref

                                            DBConnect()
                                                .getFavorites()
                                                .then((numbers) {
                                              favHymNumbers = numbers;

                                              HelperFunctions.getHymsByNumbers(
                                                      favHymNumbers)
                                                  .then((hyms) {
                                                setState(() {
                                                  favHyms = hyms;
                                                  print("changed it!");
                                                });
                                              });
                                            });
                                          } else {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HymScreen(
                                                          title: favHyms[index]
                                                              ["title"],
                                                          number: favHyms[index]
                                                              ["number"],
                                                          content:
                                                              favHyms[index]
                                                                  ["verses"],
                                                        )));
                                          }
                                        },
                                      ),
                                      Divider(
                                        color: Colors.green,
                                        thickness: 2,
                                      )
                                    ],
                                  );
                                },
                              )
                            : Center(
                                child: Text("No favorite hyms for now"),
                              ),
                      ),
                    )
                  ],
                ),
              ),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        strokeWidth: 4,
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
