import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/components/musicBar.dart';
import 'package:sda_hymnal/components/notificationDialog.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/screens/HymComments/hymComments.dart';
import 'package:sda_hymnal/screens/HymComments/streamHymComments.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class HymScreen extends StatefulWidget {
  final String title;
  final int number;
  final String content;

  HymScreen({this.title, this.number, this.content});

  @override
  _HymScreenState createState() => _HymScreenState();
}

class _HymScreenState extends State<HymScreen> {
  TextEditingController numberController;
  bool _loading;
  double globalFontRatio;
  FirebaseAuth _auth;
  // Color favColor;
  bool isAFavorite;
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    numberController = TextEditingController();
    _loading = false;
    globalFontRatio = 1;
    isAFavorite = false;
    _auth = FirebaseAuth.instance;
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
      setState(() {});
    });

//since isFAvorite is async it will be executed after initState
    isFavorite(widget.number).then((value) {
      // print("favorite is $value");

      setState(() {
        isAFavorite = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    numberController.dispose();
  }

//the sharedpreferences enable us to remember if a hym is favorite or not and based on its value we can set the color
//of the favorite icon
  setFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(number.toString(), number);
  }

  removeFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(number.toString());
  }

  Future<bool> isFavorite(number) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(number.toString())) {
      return true;
    } else {
      return false;
    }
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
      title: 'Hym Screen',
      home: Scaffold(
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        appBar: AppBar(
          title: Text("Hym " + widget.number.toString()),
          centerTitle: true,
          automaticallyImplyLeading: true,
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.comment,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Comments",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              onPressed: () async {
                FirebaseUser currentUser = await _auth.currentUser();

                if (currentUser != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StreamProvider.value(
                            value: StreamHymComments.instance()
                                .streamHymComments(widget.number),
                            catchError: (context, err) {
                              print("an error occured $err");
                            },
                            child: HymComments(
                              hymNumber: widget.number,
                            ),
                          ))); //change this to the comments screen for this particular hym
                  print(currentUser.uid.toString());
                } else {
                  NotificationDialog.showMyDialogue(
                      "Login", "Please login and try again", context,
                      positive: false);
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    color: Colors.green,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        NavigateButton(
                            icon: Icons.arrow_back,
                            tooltip: "previous",
                            onClick: () async {
                              loadHym(widget.number - 1);
                            }),
                        NavigateButton(
                          tooltip: "zoom out",
                          icon: Icons.zoom_out,
                          onClick: () {
                            //decrease font size
                            if (globalFontRatio > 1) {
                              setState(() {
                                globalFontRatio -= 0.2;
                              });
                            }
                          },
                        ),
                        NavigateButton(
                          icon: Icons.favorite,
                          tooltip: "add to favorites",
                          color: isAFavorite ? Colors.pink[600] : Colors.white,
                          onClick: () async {
                            setState(() {
                              _loading = true;
                            });
                            if (!isAFavorite) {
                              //add to favorite
                              await DBConnect().addFavorite(widget.number);
                              setState(() {
                                isAFavorite = true;
                              });

                              await setFavorite(widget.number);

                              setState(() {
                                _loading = false;
                              });
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return SimpleDialog(
                                      title: Text(
                                        "Added Favorite",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      children: <Widget>[
                                        Text(
                                          "Hym ${widget.number.toString()} was succesfully added to favorites",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              await DBConnect().removeFavorite(widget.number);
                              setState(() {
                                isAFavorite = false;
                              });

                              await removeFavorite(widget.number);

                              setState(() {
                                _loading = false;
                              });
                            }
                          },
                        ),
                        NavigateButton(
                          icon: Icons.zoom_in,
                          tooltip: "zoom in",
                          onClick: () {
                            //increase font size
                            if (globalFontRatio < 2) {
                              setState(() {
                                globalFontRatio += 0.2;
                              });
                            }
                          },
                        ),
                        NavigateButton(
                            icon: Icons.arrow_forward,
                            tooltip: "next",
                            onClick: () async {
                              //go to next hym
                              loadHym(widget.number + 1);
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        //numerical search bar here
                        children: [
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
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]))),
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
                                        fontSize: 18 * globalFontRatio,
                                        color: Colors.white),
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
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return SimpleDialog(
                                              title: Text(
                                                "Hym not Found",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              children: <Widget>[
                                                Text(
                                                  "Sorry Hym ${numberController.text} was not found",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            );
                                          });
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
                              },
                            )
                          ]),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(children: [
                              Text(
                                "${widget.number} - ${widget.title}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22 * globalFontRatio,
                                    fontWeight: FontWeight.w900),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                              ),
                              Text(
                                widget.content,
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 17 * globalFontRatio),
                              )
                            ]),
                          )
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 90),
                  )
                ],
              ),
              _loading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.green,
                        strokeWidth: 5,
                      ),
                    )
                  : Container()
            ],
          )),
        ),
        bottomSheet: MusicBar(hymNumber: widget.number),
      ),
    );
  }

  loadHym(int number) async {
    setState(() {
      _loading = true;
    });

    await DBConnect().getHym(number).then((hym) {
      setState(() {
        _loading = false;
      });
      if (hym == null) {
        showDialog(
            context: context,
            builder: (context) {
              return SimpleDialog(
                title: Text(
                  "Hym not Found",
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Text(
                    "Sorry Hym ${number.toString()} was not found",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              );
            });
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return HymScreen(
              title: hym['title'],
              number: hym['number'],
              content: hym['verses']);
        }));
      }
    });
  }
}

class NavigateButton extends StatelessWidget {
  final IconData icon;
  final Function onClick;
  final Color color;
  final String tooltip;

  NavigateButton({this.icon, this.onClick, this.color, this.tooltip});
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Tooltip(
        decoration: BoxDecoration(color: Colors.green.withOpacity(.85)),
        message: this.tooltip ?? "",
        child: FlatButton(
            child: Icon(
              this.icon,
              color: this.color ?? Colors.white,
            ),
            color: Colors.green,
            // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
            // padding: EdgeInsets.all(15),
            onPressed: this.onClick),
      ),
    );
  }
}
