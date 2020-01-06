import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/components/homeSelect.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/alphabeticSearch.dart';
import 'package:sda_hymnal/screens/categorySearch.dart';
import 'package:sda_hymnal/screens/favoritesScreen.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/screens/wordSearch.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    StreamingSharedPreferences.instance.then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });
    super.initState();
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
      debugShowCheckedModeBanner: false,
      title: 'homepage',
      home: Scaffold(
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text("SDA Hymal"),
        ),
        body: HomeScreenBody(),
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  @override
  _HomeScreenBodyState createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  TextEditingController numberController;
  bool _loading;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
    _loading = false;
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text("Enter a Number"),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),
                    Row(children: [
                      Expanded(
                        child: TextField(
                          controller: numberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "#",
                              filled: true,
                              fillColor: Colors.grey[300],
                              contentPadding: EdgeInsets.all(10),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide:
                                      BorderSide(color: Colors.grey[300]))),
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
                                "Go",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                              Icon(
                                Icons.navigate_next,
                                size: 25,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (numberController.text.isNotEmpty) {
                              setState(() {
                                _loading = true;
                              });

                              await DBConnect()
                                  .getHym(int.parse(numberController.text))
                                  .then((hym) {
                                setState(() {
                                  _loading = false;
                                });
                                if (hym == null) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 4),
                                    content: Text(
                                        "The Hym given does not exist please try again"),
                                  ));
                                } else {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return HymScreen(
                                        title: hym['title'],
                                        number: hym['number'],
                                        content: hym['verses']);
                                  }));
                                }
                              });
                            }
                          })
                    ]),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    // constraints: BoxConstraints(
                    //   minHeight: MediaQuery.of(context).size.height * 0.60,
                    //   maxHeight: MediaQuery.of(context).size.height,
                    // ),
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView(
                      // physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: <Widget>[
                        FittedBox(
                          fit: size.width > size.height
                              ? BoxFit.contain
                              : BoxFit.cover,
                          child: Choice(
                            image: "search.png",
                            onClick: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchScreen()));
                            },
                          ),
                        ),
                        FittedBox(
                          fit: size.width > size.height
                              ? BoxFit.contain
                              : BoxFit.cover,
                          child: Choice(
                            image: "a_z.png",
                            onClick: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      AlphabeticSearchScreen()));
                            },
                          ),
                        ),
                        FittedBox(
                          fit: size.width > size.height
                              ? BoxFit.contain
                              : BoxFit.cover,
                          child: Choice(
                            image: "favorite.png",
                            onClick: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FavoriteScreen()));
                            },
                          ),
                        ),
                        FittedBox(
                            fit: size.width > size.height
                                ? BoxFit.contain
                                : BoxFit.cover,
                            child: Choice(
                              image: "theme.png",
                              onClick: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CategorySearchScreen()));
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                Text("Praise God with Hyms...")
              ],
            ),
            Center(
                child: _loading
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        strokeWidth: 5,
                      )
                    : Container())
          ],
        ),
      ),
    );
  }
}
