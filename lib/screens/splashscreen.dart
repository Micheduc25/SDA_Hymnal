import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sda_hymnal/screens/homeScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash screen',
      home: Scaffold(
        body: new SplashBody(),
      ),
    );
  }
}

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  bool loading;
  Timer splashTimer;

  @override
  void initState() {
    super.initState();
    splashTimer = Timer(Duration(seconds: 4), endTimer);

    loading = true;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Stack(
          // fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: size.width * 0.4,
                  height: size.width * 0.4,
                  child: Image.asset("assets/sda_logo.png"),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    "SEVENTH DAY ADVENTIST HYMAL",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w900,
                        fontSize: 30),
                  ),
                )
              ],
            ),
            loading
                ? CircularProgressIndicator(
                    backgroundColor: Colors.green,
                    strokeWidth: 7,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void endTimer() {
    setState(() {
      loading = false;
    });

    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}
