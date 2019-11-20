import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/models/commentsModel.dart';
import 'package:sda_hymnal/utils/config.dart';

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

  @override
  void initState() {
    super.initState();
    _firestore = Firestore.instance;
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
  Widget build(BuildContext context) {
    List<CommentModel> allComments = Provider.of<List<CommentModel>>(context);
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
        body: Center(
          child: Container(
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
                                "X likes", //replace X later
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),

                          Text(
                            "Y comments",
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
                          NavItem(Icons.thumb_up, "Like", () {
                            print("liked!");
                            //implement like
                          }),
                          NavItem(Icons.add_comment, "Comment", () {
                            this.setState(() {
                              _showTextInput = !_showTextInput;
                            });
                          })
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: allComments != null && currUser != null
                        ? ListView.builder(
                            itemCount: allComments.length,
                            itemBuilder: (context, index) {
                              return Align(
                                  alignment: allComments[index].sender ==
                                          currUser.email
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: allComments[index].sender ==
                                              currUser.email
                                          ? Colors.green[400]
                                          : Colors.blueAccent,
                                      borderRadius: _bubbleBorder(
                                          allComments[index].sender),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 5),
                                          child: Text(
                                            allComments[index].content,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        Text("time ago here")
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
                    ? Container(
                        color: Colors.green,
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: LayoutBuilder(
                          builder: (context, contraints) => Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
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
                                    prefixIcon: InkWell(
                                      child: Icon(Icons.face),
                                      onTap: () {
                                        //switch to emojis
                                      },
                                    ),
                                    suffixIcon: InkWell(
                                      child: Icon(Icons.photo_camera),
                                      onTap: () {
                                        //add image
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
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
                                onTap: () {
                                  //send comment
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _bubbleBorder(String sender) {
    if (sender == currUser.email) {
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

  String _timeAgo(DateTime postTime) {
    Duration diff = DateTime.now().difference(postTime);

    int minutes = diff.inMinutes;
    if (minutes < 60) {
      return "${minutes.toString()} minutes ago";
    } else if (minutes < 1440) {
      return "${(minutes / 60).floor().toString()} hours ago";
    } else if (minutes < 10080) {
      return "${(minutes / (60 * 24 * 7)).floor().toString()} days ago";
    } else {
      //continue this tomorrow
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
