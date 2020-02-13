import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/models/userModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sda_hymnal/provider/_authProvider.dart';
import 'package:sda_hymnal/screens/Login/login.dart';
import 'package:sda_hymnal/screens/SignUp/confirmEmail.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';
import 'package:sda_hymnal/utils/config.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:sda_hymnal/utils/validator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.userId, this.settings});
  final String userId;
  final MyAppSettings settings;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _imageLoading;
  String _imageUrl;
  File _imageFile;
  bool _preview;
  String _extension;
  Firestore _firestore;
  bool _emailVerified;
  FirebaseUser currUser;
  StreamingSharedPreferences _prefs;
  bool _loading;
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool updating;
  StorageReference ref;

  FirebaseAuth _auth;
  StreamSubscription _authState;
  bool _loggedIn;

  @override
  void initState() {
    super.initState();
    _imageLoading = false;
    _preview = false;
    _emailVerified = false;
    _auth = FirebaseAuth.instance;
    _loggedIn = true;
    _loading = false;
    _scaffoldKey = GlobalKey();
    updating = false;

    _authState = _auth.onAuthStateChanged.listen((user) {
      if (user == null) {
        setState(() {
          _loggedIn = false;
        });
      } else {
        setState(() {
          _loggedIn = true;
        });
      }
    });
    StreamingSharedPreferences.instance.then((prefs) {
      _prefs = prefs;
      setState(() {});
    });
    ref = FirebaseStorage.instance
        .ref()
        .child("users")
        .child("${widget.userId}")
        .child("profilePic");
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        currUser = user;
      });
    });

    _firestore = Firestore.instance;
  }

  @override
  void dispose() {
    _authState.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userdata = Provider.of<UserModel>(context);
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: "Profile Screen",
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "logOut",
                  child: ListTile(
                    leading: Icon(
                      Icons.exit_to_app,
                      color: Colors.blueAccent,
                    ),
                    title: Text("Log Out"),
                  ),
                ),
                PopupMenuItem(
                    value: "delete",
                    child: ListTile(
                      leading: Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                      title: Text("Delete Account"),
                    ))
              ];
            }, onSelected: (String value) async {
              if (value == "delete") {
                // String result =
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Account?"),
                        content: Text(
                            "Are you really sure you want to delete your account?"),
                        actions: <Widget>[
                          FlatButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          FlatButton(
                              child: Text("Yes"),
                              onPressed: () async {
                                Navigator.of(context).pop(); //close the dialog

                                setState(() {
                                  _loading = true; //start progressindicator
                                });

                                await AuthProvider
                                        .instance() //try to delete account
                                    .deleteUser()
                                    .then((result) async {
                                  if (result == "delete success") {
                                    await widget.settings.email.setValue("");
                                    await widget.settings.password.setValue("");
                                    await widget.settings.hasAccount
                                        .setValue(false);

                                    setState(() {
                                      _loading = false;
                                    });

                                    print("successfully deleted account");

                                    Navigator.of(_scaffoldKey.currentContext)
                                        .pushReplacement(MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                  } else if (result == "login timeout") {
                                    if (widget.settings.email.getValue() !=
                                            "" &&
                                        widget.settings.password.getValue() !=
                                            "") {
                                      await AuthProvider.instance().loginUser(
                                          widget.settings.email.getValue(),
                                          widget.settings.password.getValue());

                                      FirebaseUser user =
                                          await _auth.currentUser();
                                      final String uid = user.uid;

                                      Navigator.of(_scaffoldKey.currentContext)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileScreen(userId: uid)));
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => LoginScreen(
                                                  settings: widget.settings)));
                                    }
                                  } else {
                                    setState(() {
                                      _loading = false;
                                    });
                                    showMyDialogue(
                                        "Error Deleting Account",
                                        "Sorry we encountered an error deleting the account",
                                        context,
                                        positive: false);
                                  }
                                });
                              })
                        ],
                      );
                    });
              } else if (value == 'logOut') {
                await widget.settings.email.setValue("");
                await widget.settings.password.setValue("");
                await _auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            })
          ],
        ),
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        body: Container(
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                if (userdata != null &&
                                    userdata.profilePicUrl != null) {
                                  setState(() {
                                    _preview = true;
                                  });
                                }
                              },
                              child: Hero(
                                tag: "profile",
                                child: CircleAvatar(
                                  backgroundImage: userdata != null
                                      ? userdata.profilePicUrl != null
                                          ? NetworkImage(userdata.profilePicUrl)
                                          : null
                                      : null,
                                  backgroundColor: Colors.green,
                                  minRadius: 50,
                                  maxRadius: 50,
                                  child: userdata != null
                                      ? userdata.profilePicUrl == null
                                          ? Text(
                                              userdata.userName[0]
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 30),
                                            )
                                          : Container()
                                      : null,
                                ),
                              ),
                            ),
                            _imageLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )
                                : Container()
                          ],
                        ),
                      ),
                      InkWell(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            Text(
                              "Edit Profile Picture",
                              style: TextStyle(
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        onTap: () async {
                          File temp = await ImagePicker.pickImage(
                              source: ImageSource.gallery, imageQuality: 88);

                          if (temp != null) {
                            setState(() {
                              _imageLoading = true;
                              _imageFile = temp;
                              _extension =
                                  _imageFile.path.split("/").last.split(".")[1];

                              print(_extension);
                            });

                            StorageUploadTask uploadTask =
                                ref.putFile(_imageFile);
                            await uploadTask.onComplete.then((uploadTask) {
                              ref.getDownloadURL().then((url) {
                                _imageUrl = url.toString();

                                _firestore
                                    .collection("users")
                                    .document("${widget.userId}")
                                    .updateData({
                                  Config.profilePicUrl: _imageUrl
                                }).then((_) {
                                  setState(() {
                                    _imageLoading = false;
                                  });
                                });
                              });
                            }).timeout(Duration(minutes: 1), onTimeout: () {
                              showMyDialogue(
                                  "Could not Upload Image",
                                  "Sorry we were unable to upload your profile image, please check your internet connection and try again",
                                  context,
                                  positive: false);
                              setState(() {
                                _imageLoading = false;
                              });
                              return;
                            });
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    child: userdata != null
                        ? Text.rich(
                            TextSpan(
                                text: "UserName:",
                                style: TextStyle(fontSize: 20),
                                children: [
                                  TextSpan(
                                      text: " ${userdata.userName}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ]),
                          )
                        : Text(
                            "UserName:",
                            style: TextStyle(fontSize: 20),
                          ),
                    onTap: () => _showEditPopUp(
                        Config.userName, context, userdata, widget.settings),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    child: userdata != null &&
                            currUser != null &&
                            currUser.isEmailVerified
                        ? Text.rich(
                            TextSpan(
                                text: "Email:",
                                style: TextStyle(fontSize: 20),
                                children: [
                                  TextSpan(
                                      text: " ${userdata.email}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                ]),
                          )
                        : Text(
                            "Email:",
                            style: TextStyle(fontSize: 20),
                          ),
                    onTap: () => _showEditPopUp(
                        Config.email, context, userdata, widget.settings),
                  ),
                ],
              ),
              _preview
                  ? Hero(
                      tag: "profile",
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.black54),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Column(
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      icon: Icon(Icons.close,
                                          color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _preview = false;
                                        });
                                      },
                                    )),
                                Container(
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxHeight * 0.85,
                                  child: Image.network(
                                      _imageUrl != null
                                          ? _imageUrl
                                          : userdata.profilePicUrl,
                                      fit: BoxFit.cover),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  : Container(),
              _loading
                  ? Center(
                      child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        strokeWidth: 7,
                        backgroundColor: Colors.white,
                      ),
                    ))
                  : Container()
            ],
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

  _showEditPopUp(String field, BuildContext context, UserModel userdata,
      MyAppSettings settings) {
    TextEditingController myController = TextEditingController();
    GlobalKey<FormState> key = GlobalKey();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Edit $field",
                  textAlign: TextAlign.center,
                ),
                !updating
                    ? InkWell(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20,
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      )
                    : Container()
              ],
            ),
            children: <Widget>[
              Form(
                key: key,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autofocus: true,
                        textAlign: TextAlign.center,
                        controller: myController,
                        validator: (value) {
                          return field == Config.userName
                              ? Validator.textValidator(value)
                              : Validator.emailValidator(value);
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                                borderRadius: BorderRadius.circular(10)),
                            contentPadding: EdgeInsets.all(10),
                            hintText: "New $field"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      !updating
                          ? RaisedButton(
                              child: Text(
                                "Update Info",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 30),
                              color: Colors.green,
                              onPressed: () async {
                                if (key.currentState.validate()) {
                                  setState(() {
                                    updating = true;
                                  });
                                  if (field == Config.userName) {
                                    await _firestore
                                        .collection("users")
                                        .document("${widget.userId}")
                                        .updateData({
                                      Config.userName: myController.text
                                    }).catchError((Object err) {
                                      showMyDialogue(
                                          "Update Error",
                                          "Sorry an error occured while updating your username",
                                          context,
                                          positive: false);
                                    });

                                    //for each of those comments we update the sender name

                                    //we do same with the replies
                                    // await _firestore
                                    //     .collection("comments")
                                    //     .snapshots()
                                    //     .forEach((snapshot) {
                                    //   snapshot.documents.forEach((hymdoc) {
                                    //     hymdoc.reference
                                    //         .collection("replies")
                                    //         .snapshots()
                                    //         .forEach((rSnapshot) {
                                    //       rSnapshot.documents.forEach((replyDoc) {

                                    //       });
                                    //     });
                                    //   });
                                    // });

                                    await widget.settings.userName
                                        .setValue(myController.text);

                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  } else {
                                    String status =
                                        await AuthProvider.instance()
                                            .editEmail(myController.text);

                                    if (status == "email sent") {
                                      if (settings.email.getValue() != "" ||
                                          settings.password.getValue() != "") {
                                        settings.email
                                            .setValue(myController.text);
                                      }
                                      settings.updateMode.setValue("update");
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => VerifyEmail(
                                                    userName: userdata.userName,
                                                    email: myController.text,
                                                    mode: "update",
                                                    settings: settings,
                                                  )));
                                    } else if (status == "login timeout") {
                                      if (settings.email.getValue() != "" &&
                                          settings.password.getValue() != "") {
                                        await AuthProvider.instance().loginUser(
                                            settings.email.getValue(),
                                            settings.password.getValue());

                                        FirebaseUser user =
                                            await _auth.currentUser();
                                        final String uid = user.uid;

                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProfileScreen(
                                                        userId: uid)));
                                      } else {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginScreen(
                                                        settings: settings)));
                                      }
                                    } else {
                                      Navigator.of(context).pop();
                                      showMyDialogue(
                                          "Email Update Error",
                                          "An error occured while trying to update your email, please make sure the email is correct or try to login again",
                                          context,
                                          positive: false);
                                    }
                                  }
                                  setState(() {
                                    updating = false;
                                  });
                                }
                              },
                            )
                          : CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            )
                    ],
                  ),
                ),
              )
            ],
          );
        });
  }
}
