import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/screens/wordSearch.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class NumberSearchScreen extends StatefulWidget {
  @override
  _NumberSearchScreenState createState() => _NumberSearchScreenState();
}

class _NumberSearchScreenState extends State<NumberSearchScreen> {
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
      title: 'Number Search Screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Search by Number"),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: <Widget>[
             PopupMenuButton(
                
                elevation: 4,
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                itemBuilder:(context)=> [
                  PopupMenuItem (
                      value: "word",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.sort_by_alpha,
                            color: Colors.green,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text("Search by Title")
                        ],
                      ))
                ],
                onSelected: (val) {
                  if (val == "word") {
                     Navigator.of(context).push(
                      MaterialPageRoute(builder: (context){
                        return SearchScreen();
                      })
                    );
                  }
                })
          ],
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
                  child: Text("Enter the number of the hym you are looking for"),
                ),
                Row(children: [
                  Expanded(
                    child: TextField(
                      controller: searchTextController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "Number",
                          filled: true,
                          fillColor: Colors.grey[300],
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.grey[300]))),
                      onChanged: (value) async {

                        if(searchTextController.text.isNotEmpty){
                        await HelperFunctions.filterHymsByNumber(int.parse(value)).then((fHyms){
                            setState(() {

                              
                               hyms = fHyms;
                            });
                           
                        });
                        
                        }
                        else{

                          var thehyms = await DBConnect().getHyms();
                          setState(() {
                            hyms = thehyms;
                          });
                        }

                            
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
                          
                        }
                        setState(() {
                            hyms = null;
                          });
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
