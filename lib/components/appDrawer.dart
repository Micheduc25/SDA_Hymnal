import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/provider/profileProvider.dart';
import 'package:sda_hymnal/screens/Help/helpScreen.dart';
import 'package:sda_hymnal/screens/Login/login.dart';
import 'package:sda_hymnal/screens/SignUp/confirmEmail.dart';
import 'package:sda_hymnal/screens/SignUp/signUpScreen.dart';
import 'package:sda_hymnal/screens/favoritesScreen.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/screens/profile/profileScreen.dart';
import 'package:sda_hymnal/screens/wordSearch.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class MyDrawer extends StatefulWidget {
  final MyAppSettings settings;
  MyDrawer({this.settings});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  StreamingSharedPreferences _prefs;
  FirebaseAuth _auth;
  GlobalKey _drawerKey;
  StreamSubscription _connectionState;
  bool connectionAvailable;
  bool _loading;
  @override
  void initState() {
    super.initState();
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
    });
    _auth = FirebaseAuth.instance;
    _drawerKey = GlobalKey();
    connectionAvailable = true;
    _loading = false;

    _connectionState =
        Connectivity().onConnectivityChanged.listen((connectivity) {
      if (connectivity == ConnectivityResult.none) {
        setState(() {
          connectionAvailable = false;
        });
      } else if (connectivity == ConnectivityResult.wifi ||
          connectivity == ConnectivityResult.mobile) {
        setState(() {
          connectionAvailable = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _connectionState.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: _drawerKey,
      child: Stack(
        children: <Widget>[
          Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            padding: EdgeInsets.only(top: 30, left: 10, right: 10),
            color: Colors.green,
            child: Column(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.18,
                        height: MediaQuery.of(context).size.width * 0.18,
                        child: Image.asset("assets/sda_logo.png")),
                    Text(
                      "SDA Hymnal",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30),
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: Text("Home",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: Text("Favorites",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FavoriteScreen()));
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: Text("Search Song",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen()));
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: Text("Your Profile",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () async {
                    if (connectionAvailable) {
                      FirebaseUser currUser = await _auth.currentUser();

                      if (widget.settings.email.getValue() != "" &&
                          widget.settings.password.getValue() != "" &&
                          widget.settings.isEmailVerified.getValue() &&
                          currUser == null) {
                        setState(() {
                          _loading = true;
                        });
                        String result = await AuthProvider.instance().loginUser(
                            widget.settings.email.getValue(),
                            widget.settings.password.getValue());
                        if (result == "user not found") {
                          widget.settings.email.setValue("");
                          widget.settings.password.setValue("");
                          widget.settings.hasAccount.setValue(false);
                          setState(() {
                            _loading = false;
                          });
                          showMyDialogue("No User Found",
                              "No user was found please try again", context,
                              positive: false);
                        } else {
                          FirebaseUser user = await _auth.currentUser();
                          final String uid = user.uid;

                          setState(() {
                            _loading = false;
                          });

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StreamProvider.value(
                                catchError: (context, Object err) {
                                  print(
                                      "an error occured in stream provider : ${err.toString()}");
                                },
                                value: ProfileProvider.instance()
                                    .streamUserProfile(uid),
                                child: ProfileScreen(
                                  userId: uid,
                                  settings: widget.settings,
                                )),
                          ));
                        }
                      } else if (widget.settings.email.getValue() != "" &&
                          widget.settings.password.getValue() != "" &&
                          !widget.settings.isEmailVerified.getValue()) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VerifyEmail(
                                  userName: widget.settings.userName.getValue(),
                                  email: widget.settings.email.getValue(),
                                  mode: widget.settings.updateMode.getValue(),
                                  settings: widget.settings,
                                )));
                      } else if (widget.settings.isEmailVerified.getValue() &&
                          currUser != null) {
                        //  setState(() {
                        //   _loading = false;
                        // });

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StreamProvider.value(
                              catchError: (context, Object err) {
                                print(
                                    "an error occured in stream provider : ${err.toString()}");
                              },
                              value: ProfileProvider.instance()
                                  .streamUserProfile(currUser.uid),
                              child: ProfileScreen(
                                userId: currUser.uid,
                                settings: widget.settings,
                              )),
                        ));
                      } else {
                        if (widget.settings.hasAccount.getValue()) {
                          _prefs != null
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen(
                                      settings: MyAppSettings(_prefs))))
                              : print("");
                        } else {
                          _prefs != null
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      SignUpScreen(MyAppSettings(_prefs))))
                              : print("");
                        }
                      }
                    } else {
                      showMyDialogue(
                          "Check Connection",
                          "Please make sure you are connected to a mobile or wifi network",
                          context,
                          positive: false);
                    }
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.help,
                    size: 40,
                    color: Colors.white,
                  ),
                  title: Text("Help",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HelpScreen()));
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    size: 40,
                    color: Colors.redAccent,
                  ),
                  title: Text("Exit App",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  onTap: () async {
                    await SystemChannels.platform
                        .invokeMapMethod("SystemNavigator.pop");
                  },
                ),
                Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.47,
            left: MediaQuery.of(context).size.width * 0.3,
            child: _loading
                ? SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 7,
                    ))
                : Container(),
          )
        ],
      ),
    );
  }

  void showMyDialogue(String title, String message, BuildContext context,
      {bool positive = true}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[50],
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            titleTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            contentTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            content: Container(
              child: Text(message),
              padding: EdgeInsets.all(10),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          );
        });
  }
}
