import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/commentsModel.dart';
import 'package:sda_hymnal/models/hymOnlineModel.dart';
import 'package:sda_hymnal/utils/config.dart';
import 'package:sda_hymnal/utils/timeStream.dart';
import 'package:flutter/services.dart';

class HymComments extends StatefulWidget {
  HymComments({this.hymNumber});
  final int hymNumber;

  @override
  _HymCommentsState createState() => _HymCommentsState();
}

class _HymCommentsState extends State<HymComments> {
  List<Map<String, dynamic>> allHyms;
  Firestore _firestore;
  TextEditingController commentController;
  bool _showTextInput;
  FirebaseUser currUser;
  DateTime now;
  StreamSubscription _nowTime;
  DocumentReference _hymRef;
  bool _showEmojiPicker;
  List<String> recommendedEmojis;
  FocusNode textInputFocus;
  StorageReference _userStorageReference;

  @override
  void initState() {
    super.initState();
    _showEmojiPicker = false;
    now = DateTime.now();
    textInputFocus = FocusNode();

    recommendedEmojis = [];
    _firestore = Firestore.instance;
    _hymRef = _firestore
        .collection("hyms")
        .document("hym_${widget.hymNumber.toString()}");

    _userStorageReference = FirebaseStorage.instance.ref().child("users");

    _nowTime = TimeStream.getCurrentTime().listen((time) {
      setState(() {
        now = time;
      });
    });
    commentController = TextEditingController();
    _showTextInput = false;
    FirebaseAuth.instance.currentUser().then((user) {
      if (user != null) {
        setState(() {
          currUser = user;
        });
      }
    });
  }

  @override
  void dispose() {
    commentController?.dispose();
    _nowTime?.cancel();
    textInputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<CommentModel> allComments =
        Provider.of<List<CommentModel>>(context)?.reversed?.toList();
    OnlineHym thisHym = Provider.of<OnlineHym>(context);
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'Hym comments',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hym ${widget.hymNumber} Comments'),
          centerTitle: true,
          leading: InkWell(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          // constraints: BoxConstraints(
          //     minHeight: MediaQuery.of(context).size.height * 0.885,
          //     maxHeight: MediaQuery.of(context).size.height * 0.885),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: Colors.green,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.thumb_up,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              thisHym != null
                                  ? "${thisHym.likes.toString()} likes"
                                  : "",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),

                        Text(
                          allComments != null
                              ? "${allComments.length.toString()} comments"
                              : "",
                          style: TextStyle(color: Colors.white),
                        ) //replace y later
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        NavItem(Icons.thumb_up, "Like", () async {
                          await _firestore.runTransaction((transaction) async {
                            final snapshot = await transaction.get(_hymRef);

                            await transaction.update(_hymRef, {
                              Config.likes: snapshot.data[Config.likes] + 1
                            });
                          });
                        }),
                        NavItem(Icons.add_comment, "Comment", () {
                          this.setState(() {
                            _showTextInput = !_showTextInput;
                          });
                          if (_showTextInput)
                            FocusScope.of(context).requestFocus(textInputFocus);
                          else
                            FocusScope.of(context).unfocus();
                        })
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: allComments != null && currUser != null
                      ? ListView.builder(
                          reverse: true,
                          itemCount: allComments.length,
                          itemBuilder: (context, index) {
                            return Align(
                                alignment:
                                    allComments[index].sender == currUser.uid
                                        ? Alignment.topRight
                                        : Alignment.topLeft,
                                child: Row(
                                  textDirection:
                                      allComments[index].sender == currUser.uid
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    CircleAvatar(
                                      maxRadius: 26,
                                      backgroundImage: NetworkImage(
                                          allComments[index].commentPic),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: 20,
                                          left: 10,
                                          right: 10,
                                          top: 10),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: allComments[index].sender ==
                                                currUser.uid
                                            ? Colors.green[400]
                                            : Colors.blueAccent,
                                        borderRadius: _bubbleBorder(
                                            allComments[index].sender),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            allComments[index].sender ==
                                                    currUser.uid
                                                ? CrossAxisAlignment.end
                                                : CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10, top: 5),
                                            child: Text(
                                              allComments[index].content,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Text(
                                            _timeAgo(allComments[index].date),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ));
                          },
                        )
                      : Center(
                          child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 7,
                          ),
                        ))),
              _showTextInput
                  ? Column(
                      children: <Widget>[
                        Container(
                          color: Colors.green,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          child: LayoutBuilder(
                            builder: (context, contraints) => Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextField(
                                    textInputAction: TextInputAction.done,
                                    focusNode: textInputFocus,
                                    cursorColor: Colors.green,
                                    controller: commentController,
                                    minLines: 1,
                                    maxLines: 7,
                                    scrollController: null,
                                    decoration: InputDecoration(
                                      hintText: "Type Here",
                                      filled: true,
                                      fillColor: Colors.white,
                                      disabledBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      border: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 10),
                                      // prefixIcon: InkWell(
                                      //   child: Icon(!_showEmojiPicker
                                      //       ? Icons.face
                                      //       : Icons.keyboard),
                                      //   onTap: () {
                                      //     //switch to emojis

                                      //     setState(() {
                                      //       _showEmojiPicker =
                                      //           !_showEmojiPicker;
                                      //     });
                                      //   },
                                      // ),
                                      // suffixIcon: InkWell(
                                      //   child: Icon(Icons.photo_camera),
                                      //   onTap: () async {
                                      //     //add image

                                      //     File postImageFile =
                                      //         await ImagePicker.pickImage(
                                      //             source: ImageSource.gallery,
                                      //             imageQuality: 70);

                                      //     StorageUploadTask upload =
                                      //         _storageReference
                                      //             .putFile(postImageFile);
                                      //     await upload.onComplete
                                      //         .then((snapshot) async {
                                      //       String url = await _storageReference
                                      //           .getDownloadURL();

                                      //     });
                                      //   },
                                      // ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.green,
                                    ),
                                  ),
                                  onTap: () async {
                                    //send comment
                                    String profilePicUrl =
                                        await _userStorageReference
                                            .child(currUser.uid)
                                            .child("profilePic")
                                            .getDownloadURL();
                                    if (commentController.text != "") {
                                      await _firestore
                                          .collection("comments")
                                          .document(
                                              "hym_${widget.hymNumber}_comments")
                                          .collection("comments")
                                          .add({
                                        Config.content: commentController.text,
                                        Config.sender: currUser.uid,
                                        Config.likes: 0,
                                        Config.date: DateTime.now(),
                                        Config.commentPic: profilePicUrl
                                      });

                                      commentController.clear();
                                    }
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        // _showEmojiPicker && _showTextInput
                        //     ? EmojiPicker(
                        //         bgColor: Colors.green,
                        //         indicatorColor: Colors.white,
                        //         recommendKeywords: recommendedEmojis,
                        //         onEmojiSelected: (emoji, category) {
                        //           print(
                        //               emoji.name + " " + category.toString());
                        //           commentController.text += emoji.emoji;
                        //           setState(() {
                        //             recommendedEmojis.add(emoji.name);
                        //           });
                        //         },
                        //       )
                        //     : Container()
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius _bubbleBorder(String sender) {
    if (sender == currUser.uid) {
      return BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20));
    } else {
      return BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20));
    }
  }

  String _timeAgo(Timestamp postTime) {
    DateTime convertedPostTime = postTime.toDate();
    Duration diff = now.difference(convertedPostTime);

    int minutes = diff.inMinutes;

    if (minutes == 0) {
      return 'some seconds ago';
    } else if (minutes < 60) {
      return "${minutes.toString()} minute${minutes > 1 ? 's' : ''} ago";
    } else if (minutes < 1440) {
      return "${(minutes / 60).floor().toString()} hour${minutes > (60 * 2) - 1 ? 's' : ''} ago";
    } else if (minutes < 10080) {
      return "${(minutes / (60 * 24 * 7)).floor().toString()} day${minutes > (1440 * 2) - 1 ? 's' : ''} ago";
    } else if (minutes < 40320) {
      return "${(minutes / (60 * 24 * 7 * 4)).floor().toString()} week${minutes > (10080 * 2) - 1 ? 's' : ""}";
    } else if (minutes < 524160) {
      return "${(DateTime.now().month - convertedPostTime.month).toString()} month${minutes > (40320 * 2) - 1 ? 's' : ""}";
    } else {
      return "${(DateTime.now().year - convertedPostTime.year).toString()} year${minutes > (524160 * 2) - 1 ? 's' : ""}";
    }
  }
}

class NavItem extends StatefulWidget {
  NavItem(this.icon, this.title, this.action);
  final IconData icon;
  final String title;
  final Function action;

  @override
  State<NavItem> createState() {
    return _NavItemState();
  }
}

class _NavItemState extends State<NavItem> {
  bool _liked;
  String _title;
  @override
  void initState() {
    super.initState();
    _liked = false;
    _title = widget.title;
  }

  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon,
              color: !_liked ? Colors.white : Colors.pink,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              _title,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
      onTap: () {
        if (widget.title == "Like") {
          setState(() {
            _liked = !_liked;

            if (_liked) {
              _title = _title + "d";
            } else {
              _title = widget.title;
            }
          });
          widget.action();
        } else {
          widget.action();
        }
      },
    );
  }
}
