import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/components/homeSelect.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'homepage',
      home: Scaffold(
        drawer: Drawer(
          child: MyDrawer(),
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
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Choice(
                            image: "search.png",
                            onClick: () {
                              print("search clicked");
                            },
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Choice(
                            image: "a_z.png",
                            onClick: () {
                              print("search clicked");
                            },
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Choice(
                            image: "favorite.png",
                            onClick: () {
                              print("search clicked");
                            },
                          ),
                        ),
                        FittedBox(
                            fit: BoxFit.cover,
                            child: Choice(
                              image: "theme.png",
                              onClick: () {
                                print("search clicked");
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                Text("Praise God with all Instruments...")
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
