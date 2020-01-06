import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/commentsModel.dart';
import 'package:sda_hymnal/models/hymOnlineModel.dart';
import 'package:sda_hymnal/models/userModel.dart';
import 'package:sda_hymnal/provider/profileProvider.dart';
import 'package:sda_hymnal/screens/HymComments/commentReplies.dart';
import 'package:sda_hymnal/screens/HymComments/streamHymComments.dart';
import 'package:sda_hymnal/utils/config.dart';
import 'package:sda_hymnal/utils/timeStream.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

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
  bool _hymLiked;
  bool sent;

  @override
  void initState() {
    super.initState();
    _showEmojiPicker = false;
    now = DateTime.now();
    textInputFocus = FocusNode();
    sent = true;

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
    UserModel userInfo = Provider.of<UserModel>(context);
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
                        NavItem(
                          Icons.thumb_up,
                          "Like" + (_hymLiked == true ? "ed" : ""),
                          () async {
                            if (!thisHym.likers.contains(currUser.uid)) {
                              try {
                                await _firestore
                                    .runTransaction((transaction) async {
                                  final snapshot =
                                      await transaction.get(_hymRef);

                                  await transaction.update(_hymRef, {
                                    Config.likes:
                                        snapshot.data[Config.likes] + 1
                                  });
                                });

                                List<String> tempLikers = thisHym.likers;
                                tempLikers.add(currUser.uid);

                                await _firestore
                                    .collection("hyms")
                                    .document(
                                        "hym_${widget.hymNumber.toString()}")
                                    .updateData({Config.likers: tempLikers});
                                setState(() {
                                  _hymLiked = true;
                                });
                              } catch (e) {
                                if (e is PlatformException) {
                                  print("transaction timeout");
                                }
                              }
                            } else {
                              try {
                                await _firestore
                                    .runTransaction((transaction) async {
                                  final snapshot =
                                      await transaction.get(_hymRef);

                                  try {
                                    await transaction.update(_hymRef, {
                                      Config.likes:
                                          snapshot.data[Config.likes] - 1
                                    });
                                  } catch (e) {
                                    if (e is PlatformException) {
                                      print("transaction occured already");
                                    }
                                  }
                                });
                                List<String> tempLikers = thisHym.likers;
                                tempLikers.remove(currUser.uid);

                                await _firestore
                                    .collection("hyms")
                                    .document(
                                        "hym_${widget.hymNumber.toString()}")
                                    .updateData({Config.likers: tempLikers});

                                setState(() {
                                  _hymLiked = false;
                                });
                              } catch (e) {
                                if (e is PlatformException) {
                                  print("transaction timeout");
                                }
                              }
                            }
                          },
                          color: _hymLiked == true ? Colors.pink : Colors.white,
                        ),
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
                  child: allComments != null &&
                          currUser != null &&
                          userInfo != null
                      ? ListView.builder(
                          reverse: true,
                          itemCount: allComments.length,
                          itemBuilder: (context, index) {
                            int numberOfComments = 0;
                            _firestore
                                .collection("comments")
                                .document(
                                    "hym_${widget.hymNumber.toString()}_comments")
                                .collection("replies")
                                .document(allComments[index].commentId)
                                .collection("replies")
                                .snapshots()
                                .length
                                .then((length) {
                                  numberOfComments = length;
                                print(numberOfComments);
                                setState(() {
                                
                            });
                              });
                              
                            // String senderName = "";

                            // _firestore
                            //     .collection("users")
                            //     .document(allComments[index].sender)
                            //     .get()
                            //     .then((doc) {
                            //   setState(() {
                            //     senderName = doc.data[Config.userName];
                            //   });
                            // });

                            return Align(
                                alignment: Alignment.center,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 20, left: 10, right: 10, top: 10),
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: allComments[index].sender ==
                                              currUser.uid
                                          ? Colors.green[400]
                                          : Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  allComments[index]
                                                      .commentPic),
                                              maxRadius: 25,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  allComments[index].senderName,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                Text(
                                                  _timeAgo(
                                                      allComments[index].date),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          allComments[index].content,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Divider(
                                        color: Colors.white,
                                        thickness: 1.5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            child: Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                            onTap: () async {
                                              //implement share
                                              try {
                                                await Share.share('''
                                                  From SDA_Hymnal, hym ${widget.hymNumber.toString()}\n${allComments[index].senderName},\n\n ${allComments[index].content}''',
                                                    subject:
                                                        "SDA Hym App Comment");
                                              } catch (e) {
                                                print(
                                                    "error occured while sharing   ${e.toString()}");
                                              }
                                            },
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                child: Row(
                                                  children: <Widget>[
                                                    Text(
                                                      "${numberOfComments.toString()}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Icons.comment,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  MultiProvider(
                                                                    providers: [
                                                                      StreamProvider
                                                                          .value(
                                                                        value: StreamHymComments.instance().streamCommentReplies(
                                                                            widget.hymNumber,
                                                                            allComments[index].commentId),
                                                                        catchError:
                                                                            (context,
                                                                                err) {
                                                                          print(
                                                                              "error occured in streaming comment replies");
                                                                        },
                                                                      ),
                                                                      StreamProvider
                                                                          .value(
                                                                        value: StreamHymComments.instance()
                                                                            .streamHymModel(widget.hymNumber),
                                                                      ),
                                                                      StreamProvider
                                                                          .value(
                                                                        value: StreamHymComments.instance()
                                                                            .streamHymComments(widget.hymNumber),
                                                                      ),
                                                                      StreamProvider
                                                                          .value(
                                                                        value: ProfileProvider.instance()
                                                                            .streamUserProfile(allComments[index].sender),
                                                                      )
                                                                    ],
                                                                    child: CommentReplies(
                                                                        commentId:
                                                                            allComments[index].commentId),
                                                                  )));
                                                },
                                              ),
                                              SizedBox(
                                                width: 40,
                                              ),
                                              InkWell(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        allComments[index]
                                                            .likes
                                                            .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Icon(
                                                        Icons.thumb_up,
                                                        color: Colors.white,
                                                      )
                                                    ],
                                                  ),
                                                  onTap: () async {
                                                    DocumentReference
                                                        commentRef = _firestore
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                "hym_${thisHym.number.toString()}_comments")
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                allComments[
                                                                        index]
                                                                    .commentId);
                                                    if (!allComments[index]
                                                        .likers
                                                        .contains(
                                                            currUser.uid)) {
                                                      try {
                                                        await _firestore
                                                            .runTransaction(
                                                                (transaction) async {
                                                          final snapshot =
                                                              await transaction
                                                                  .get(
                                                                      commentRef);

                                                          await transaction
                                                              .update(
                                                                  commentRef, {
                                                            Config
                                                                .likes: snapshot
                                                                        .data[
                                                                    Config
                                                                        .likes] +
                                                                1
                                                          });
                                                        });

                                                        List<String>
                                                            tempLikers =
                                                            allComments[index]
                                                                .likers;
                                                        tempLikers
                                                            .add(currUser.uid);

                                                        await _firestore
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                "hym_${widget.hymNumber.toString()}_comments")
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                allComments[
                                                                        index]
                                                                    .commentId)
                                                            .updateData({
                                                          Config.likers:
                                                              tempLikers
                                                        });
                                                      } catch (e) {
                                                        if (e
                                                            is PlatformException) {
                                                          print(
                                                              "platform exception at transaction");
                                                        }
                                                      }
                                                    } else {
                                                      try {
                                                        await _firestore
                                                            .runTransaction(
                                                                (transaction) async {
                                                          final snapshot =
                                                              await transaction
                                                                  .get(
                                                                      commentRef);

                                                          await transaction
                                                              .update(
                                                                  commentRef, {
                                                            Config
                                                                .likes: snapshot
                                                                        .data[
                                                                    Config
                                                                        .likes] -
                                                                1
                                                          });
                                                        });

                                                        List<String>
                                                            tempLikers =
                                                            allComments[index]
                                                                .likers;
                                                        tempLikers.remove(
                                                            currUser.uid);

                                                        await _firestore
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                "hym_${widget.hymNumber.toString()}_comments")
                                                            .collection(
                                                                "comments")
                                                            .document(
                                                                allComments[
                                                                        index]
                                                                    .commentId)
                                                            .updateData({
                                                          Config.likers:
                                                              tempLikers
                                                        });
                                                      } catch (e) {
                                                        if (e
                                                            is PlatformException) {
                                                          print(
                                                              "platform exception at transaction");
                                                        }
                                                      }
                                                    }
                                                  })
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
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
                                    ),
                                  ),
                                ),
                                sent
                                    ? InkWell(
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
                                          setState(() {
                                            sent = false;
                                          });
                                          String commentHolder =
                                              commentController.text;
                                          commentController.clear();
                                          String profilePicUrl =
                                              await _userStorageReference
                                                  .child(currUser.uid)
                                                  .child("profilePic")
                                                  .getDownloadURL();

                                          if (commentHolder != "") {
                                            await _firestore
                                                .collection("comments")
                                                .document(
                                                    "hym_${widget.hymNumber}_comments")
                                                .collection("comments")
                                                .document(
                                                    "comment_${allComments.length + 1}")
                                                .setData({
                                              Config.content: commentHolder,
                                              Config.sender: currUser.uid,
                                              Config.likes: 0,
                                              Config.date: DateTime.now(),
                                              Config.commentPic: profilePicUrl,
                                              Config.senderName:
                                                  userInfo.userName,
                                              Config.commentsId:
                                                  "comment_${allComments.length + 1}"
                                            });
                                            setState(() {
                                              sent = true;
                                            });
                                          }
                                        },
                                      )
                                    : Padding(
                                        padding: EdgeInsets.all(5),
                                        child: CircularProgressIndicator(
                                          backgroundColor: Colors.white,
                                        ))
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
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
  NavItem(this.icon, this.title, this.action, {this.color: Colors.white});
  final IconData icon;
  final String title;
  final Function action;
  final Color color;

  @override
  State<NavItem> createState() {
    return _NavItemState();
  }
}

class _NavItemState extends State<NavItem> {
  String _title;
  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          children: <Widget>[
            Icon(widget.icon, color: widget.color
                //!_liked ? Colors.white : Colors.pink,
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
        widget.action();
      },
    );
  }
}
