import 'dart:async';

import 'package:flutter/material.dart';

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
    splashTimer = Timer(Duration(seconds: 3), endTimer);

    loading = true;
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SizedBox(
              width: size.width * 0.4,
              height: size.width * 0.4,
              child: Image.asset("assets/sda_logo.png"),
            ),
            loading
                ? CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  void endTimer() {
    setState((){
      loading=false;

    });

    Navigator.of(context).push
  }
}
