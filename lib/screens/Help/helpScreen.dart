import 'package:flutter/material.dart';
import 'package:sda_hymnal/screens/Help/helpPages/page1.dart';
import 'package:sda_hymnal/screens/Help/helpPages/page2.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';

import 'helpPages/page3.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'Help Screen',
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HelpScreen()));
          },
          backgroundColor: Colors.green,
          child: Text(
            "Index",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
            child: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          title: Text('Help'),
        ),
        body: Center(child: HelpScreenHome()),
      ),
    );
  }
}

class HelpScreenHome extends StatefulWidget {
  @override
  _HelpScreenHomeState createState() => _HelpScreenHomeState();
}

class _HelpScreenHomeState extends State<HelpScreenHome> {
  PageController _controller;
  @override
  void initState() {
    _controller = new PageController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      children: <Widget>[
        HelpIntro(
          controller: _controller,
        ),
        Page1(),
        Page2(),
        Page3()
      ],
    );
  }
}

class IndexItem extends StatelessWidget {
  IndexItem({this.label, this.page, this.controller});
  final String label;
  final int page;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.jumpToPage(page);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.6), offset: Offset(0, 4))
            ]),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }
}

class HelpIntro extends StatelessWidget {
  HelpIntro({this.controller});
  final PageController controller;

  @override
  build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            IndexItem(
              label: "Getting Started, open and play hyms...",
              page: 1,
              controller: controller,
            ),
            SizedBox(
              height: 20,
            ),
            IndexItem(
              label: "Commenting Hyms...",
              page: 2,
              controller: controller,
            ),
            SizedBox(
              height: 20,
            ),
            IndexItem(
              label: "Searching Hyms...",
              page: 3,
              controller: controller,
            ),
          ],
        ));
  }
}
