import 'package:flutter/material.dart';
import 'package:sda_hymnal/constants/hymsexample.dart';
import 'package:sda_hymnal/db/dbConnection.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool added;
  Future<bool> shalladd;
  Widget hymview;
  int i;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    added = false;
    print(added);
    hymview = Container();
    i = 1;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("advent Hym"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Add Item to DB"),
                  onPressed: () {
                    shalladd = DBConnect().insertHym(HymExample.hym2);
                    shalladd.then((value) {
                      setState(() {
                        added = value;
                      });
                    });

                    HymsUI().then((widget) {
                      setState(() {
                        hymview = widget;
                      });
                    });
                  },
                ),
                added
                    ? hymview
                    : Container(
                        child: Text("hello"),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Widget> HymsUI() async {
    List<Map<String, dynamic>> allHyms;
    List<Widget> widgets = [];

    await DBConnect().getHym().then((hyms) {
      allHyms = hyms;
    });

    allHyms.forEach((hym) {
      widgets.add(Column(
        children: <Widget>[
          Text("${hym['number']} : ${hym['title']}  by ${hym['author']}"),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: LayoutBuilder(
                builder: (context, constraints) => Container(
                    color: Colors.blueAccent.withOpacity(0.5),
                    width: constraints.maxWidth * 0.7,
                    child: Text(" ${hym['verses']}"))),
          )
        ],
      ));
      // setState(() {
      //   i++;
      // });
    });

    return Container(
      height: 400,
      child: ListView(
        children: widgets,
      ),
    );
  }
}
