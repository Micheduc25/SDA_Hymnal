import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/models/commentsModel.dart';
import 'package:sda_hymnal/models/hymOnlineModel.dart';
import 'package:sda_hymnal/models/replyModel.dart';
import 'package:sda_hymnal/models/userModel.dart';
import 'package:sda_hymnal/utils/config.dart';

class CommentReplies extends StatefulWidget {
  CommentReplies({this.hymNumber, this.commentId});
  final int hymNumber;
  final String commentId;
  @override
  _CommentRepliesState createState() => _CommentRepliesState();
}

class _CommentRepliesState extends State<CommentReplies> {
  Firestore _firestore;
  FirebaseUser curUser;
  // FocusNode textInputFocus;
  TextEditingController commentController;
  DateTime now;
  StorageReference _userStorageReference;
  bool sent;

  @override
  void initState() {
    _firestore = Firestore.instance;
    sent = true;
    // textInputFocus = new FocusNode(canRequestFocus: true);
    FirebaseAuth.instance.currentUser().then((user) {
      curUser = user;
      setState(() {});
    });
    _userStorageReference = FirebaseStorage.instance.ref().child("users");
    commentController = new TextEditingController();
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<CommentModel> commentInfo = Provider.of<List<CommentModel>>(context);
    CommentModel thisComment;

    if (commentInfo != null) {
      thisComment = commentInfo.where((comment) {
        if (comment.commentId == widget.commentId) {
          return true;
        } else {
          return false;
        }
      }).toList()[0];
    }

    UserModel commentorProfile = Provider.of<UserModel>(context);

    OnlineHym hymInfo = Provider.of<OnlineHym>(context);
    List<ReplyModel> allReplies = Provider.of<List<ReplyModel>>(context);
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white, size: 30),
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'Comment Replies',
      home: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              child: Icon(
                Icons.navigate_before,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            title: commentInfo != null && hymInfo != null
                ? Text(
                    "Replies to ${thisComment != null ? thisComment.senderName.split(" ")[0] : ""}'s comment on hym ${hymInfo.number.toString()}")
                : Text("Replies"),
          ),
          bottomSheet: Container(
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: LayoutBuilder(
                  builder: (context, contraints) => Row(children: <Widget>[
                        Expanded(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            // focusNode: textInputFocus,
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
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                  borderRadius: BorderRadius.circular(20)),
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
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.green,
                                  ),
                                ),
                                onTap: () async {
                                  //send reply
                                  String replyHolder = commentController.text;
                                  commentController.clear();
                                  setState(() {
                                    sent = false;
                                  });
                                  print(replyHolder);
                                  String profilePicUrl =
                                      await _userStorageReference
                                          .child(curUser.uid)
                                          .child("profilePic")
                                          .getDownloadURL();

                                  if (replyHolder != "") {
                                    await _firestore
                                        .collection("comments")
                                        .document(
                                            "hym_${hymInfo.number.toString()}_comments")
                                        .collection("replies")
                                        .document(thisComment.commentId)
                                        .collection("replies")
                                        .document(
                                            "reply_${allReplies.length + 1}")
                                        .setData({
                                      Config.content: replyHolder,
                                      Config.sender: curUser.uid,
                                      Config.likes: 0,
                                      Config.replyId:
                                          "reply_${allReplies.length + 1}",
                                      Config.date: DateTime.now(),
                                      Config.commentPic: profilePicUrl,
                                      Config.senderName:
                                          commentorProfile.userName,
                                    });
                                    setState(() {
                                      sent = true;
                                    });
                                  }
                                })
                            : Padding(
                                padding: EdgeInsets.all(5),
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.white,
                                ),
                              )
                      ]) //semi here
                  )),
          body: commentInfo != null &&
                  hymInfo != null &&
                  commentorProfile != null
              ? Container(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.8,
                      minWidth: MediaQuery.of(context).size.width),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green,
                          ),
                          padding: EdgeInsets.only(top: 8, bottom: 8, right: 3),
                          margin: EdgeInsets.only(left: 40, right: 30, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Transform.translate(
                                offset: Offset(-25, 0),
                                child: Container(
                                  height: 120,
                                  width: 110,
                                  foregroundDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              commentorProfile.profilePicUrl))),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      thisComment.senderName,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      "date",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Flexible(
                                      child: Container(
                                        child: Text(
                                          thisComment.content,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: allReplies != null &&
                                hymInfo != null &&
                                commentInfo != null
                            ? ListView.builder(
                                itemCount: allReplies.length,
                                itemBuilder: (context, index) {
                                  return Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: 20,
                                            left: 10,
                                            right: 10,
                                            top: 10),
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            color: Colors.blueAccent,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            allReplies[index]
                                                                .commentPic),
                                                    maxRadius: 25,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        allReplies[index]
                                                            .senderName,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 17),
                                                      ),
                                                      Text(
                                                        _timeAgo(
                                                            allReplies[index]
                                                                .date),
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
                                              padding:
                                                  EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                allReplies[index].content,
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Divider(
                                              color: Colors.white,
                                              thickness: 1.5,
                                            ),
                                          ],
                                        ),
                                      ));
                                },
                              )
                            : Container(),
                      ),
                    ],
                  ))
              : CircularProgressIndicator(
                  backgroundColor: Colors.white,
                )),
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
