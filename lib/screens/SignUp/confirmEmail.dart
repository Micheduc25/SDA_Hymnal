import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/provider/profileProvider.dart';
import 'package:sda_hymnal/screens/SignUp/signUpScreen.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/screens/profile/profileScreen.dart';

class VerifyEmail extends StatefulWidget {
  VerifyEmail({this.userName, this.email});
  final String userName;
  final String email;
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  FirebaseAuth _auth;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _loading = false;
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
      title: "verify email",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Verify your Email"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("After Verifying your email press the button below"),
                SizedBox(
                  height: 30,
                ),
                !_loading
                    ? RaisedButton(
                        child: Text(
                          " I have verified my Email",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        onPressed: () async {
                          FirebaseUser user = await _auth.currentUser();

                          String userId = user.uid;

                          print(userId);

                          await user.reload();

                          user = await _auth.currentUser();

                          userId = user.uid;

                          if (user.isEmailVerified) {
                            await AuthProvider.instance().saveUser(
                                widget.userName, widget.email, userId);

                            setState(() {
                              _loading = false;
                            });

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => StreamProvider.value(
                                      value: ProfileProvider.instance()
                                          .streamUserProfile(userId),
                                      child: ProfileScreen(userId: userId),
                                    )));
                          } else {
                            setState(() {
                              _loading = false;
                            });
                            showMyDialogue(
                                "Email not Verified",
                                "The email has not yet been verified, please verify and try again",
                                context,
                                positive: false);
                          }
                        },
                      )
                    : CircularProgressIndicator(
                        backgroundColor: Colors.green,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void showMyDialogue(String title, String message, BuildContext context,
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
