import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/provider/profileProvider.dart';
import 'package:sda_hymnal/screens/Login/login.dart';
import 'package:sda_hymnal/screens/SignUp/signUpScreen.dart';
import 'package:sda_hymnal/screens/favoritesScreen.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/screens/profile/profileScreen.dart';
import 'package:sda_hymnal/screens/wordSearch.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyDrawer extends StatefulWidget {
  final MyAppSettings settings;
  MyDrawer({this.settings});
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  StreamingSharedPreferences _prefs;
  FirebaseAuth _auth;
  @override
  void initState() {
    super.initState();
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
    });
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FavoriteScreen()));
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
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SearchScreen()));
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
                if (widget.settings.email.getValue() != "" &&
                    widget.settings.password.getValue() != "") {
                  String result = await AuthProvider.instance().loginUser(
                      widget.settings.email.getValue(),
                      widget.settings.password.getValue());
                  if (result == "user not found") {
                    widget.settings.email.setValue("");
                    widget.settings.password.setValue("");
                    widget.settings.hasAccount.setValue(false);
                    print("user not found");
                  } else {
                    FirebaseUser user = await _auth.currentUser();
                    final String uid = user.uid;

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StreamProvider.value(
                          catchError: (context, Object err) {
                            print("an error occured in stream provider");
                          },
                          value:
                              ProfileProvider.instance().streamUserProfile(uid),
                          child: ProfileScreen(
                            userId: uid,
                            settings: widget.settings,
                          )),
                    ));
                  }
                } else {
                  if (widget.settings.hasAccount.getValue()) {
                    _prefs != null
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                LoginScreen(settings: MyAppSettings(_prefs))))
                        : print("");
                  } else {
                    _prefs != null
                        ? Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SignUpScreen(MyAppSettings(_prefs))))
                        : print("");
                  }
                }
              },
            ),
            Divider(
              color: Colors.white,
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }
}
