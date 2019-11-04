import 'package:flutter/material.dart';

class Choice extends StatelessWidget {
  final String image;
  final Function onClick;

  Choice({this.image, this.onClick});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.green),
        child: FlatButton(
          child: Image.asset("assets/${this.image}"),
          onPressed: this.onClick,
        ));
  }
}
