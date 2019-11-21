import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextController;
  bool _loading;
  List<Map<String, dynamic>> hyms;
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
      setState(() {});
    });

    searchTextController = TextEditingController();
    _loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
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
      title: 'Search Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search by Title"),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("Enter the title of the hym you are looking for"),
                ),
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      autofocus: true,
                      decoration: InputDecoration(
                          hintText: "Title",
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey[300]))),
                      onChanged: (value) async {
                        await HelperFunctions.getHymsByTitle(value)
                            .then((songs) {
                          setState(() {
                            hyms = songs;
                            // print(hyms.toString());
                          });
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 10)),
                  RaisedButton(
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Cancel",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Icon(
                            Icons.clear,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      onPressed: () {
                        if (searchTextController.text.isNotEmpty) {
                          searchTextController.clear();
                          setState(() {
                            hyms = null;
                          });
                        }
                      })
                ]),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                hyms != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: hyms.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: <Widget>[
                                ListTile(
                                  leading: Icon(
                                    Icons.music_note,
                                    color: Colors.green,
                                  ),
                                  title: Text(hyms[index]["number"].toString() +
                                      " - " +
                                      hyms[index]["title"]),
                                  onTap: () async {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => HymScreen(
                                                  title: hyms[index]["title"],
                                                  number: hyms[index]["number"],
                                                  content: hyms[index]
                                                      ["verses"],
                                                )));
                                  },
                                ),
                                Divider(
                                  color: Colors.green,
                                  thickness: 2,
                                )
                              ],
                            );
                          },
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
