import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/models/userModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sda_hymnal/utils/config.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({this.userId});
  final String userId;

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

  StorageReference ref;

  @override
  void initState() {
    super.initState();
    _imageLoading = false;
    _preview = false;
    ref = FirebaseStorage.instance
        .ref()
        .child("users")
        .child("${widget.userId}")
        .child("profilePic");

    _firestore = Firestore.instance;
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
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: MyDrawer(),
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
                                setState(() {
                                  _preview = true;
                                });
                              },
                              child: CircleAvatar(
                                backgroundImage: userdata != null
                                    ? userdata.profilePicUrl == null
                                        ? _imageUrl != null
                                            ? NetworkImage(_imageUrl)
                                            : null
                                        : NetworkImage(userdata.profilePicUrl)
                                    : null,
                                backgroundColor: Colors.green,
                                minRadius: 50,
                                maxRadius: 50,
                                child: userdata != null
                                    ? userdata.profilePicUrl == null
                                        ? _imageUrl == null && userdata != null
                                            ? Text(
                                                userdata.userName[0]
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 30),
                                              )
                                            : Container()
                                        : Container()
                                    : null,
                              ),
                            ),
                            _imageLoading
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.green,
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
                            await uploadTask.onComplete;

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
                          }
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  userdata != null
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
                  SizedBox(
                    height: 25,
                  ),
                  userdata != null
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
                ],
              ),
              _preview
                  ? Container(
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
                                    icon:
                                        Icon(Icons.close, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        _preview = false;
                                      });
                                    },
                                  )),
                              Container(
                                width: constraints.maxWidth * 0.9,
                                height: constraints.maxHeight * 0.85,
                                child:
                                    Image.network(_imageUrl, fit: BoxFit.cover),
                              ),
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
    );
  }
}
