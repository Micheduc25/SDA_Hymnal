import 'package:flutter/material.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          Divider(
            color: Colors.white,
            thickness: 2,
          )
        ],
      ),
    );
  }
}
