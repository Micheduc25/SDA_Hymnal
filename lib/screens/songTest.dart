import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SongTest extends StatefulWidget {
  @override
  _SongTestState createState() => _SongTestState();
}

class _SongTestState extends State<SongTest> {

  StorageReference ref;
  AudioPlayer myplayer;

  @override
  void initState() {
    
    super.initState();
    myplayer= AudioPlayer();

    ref=FirebaseStorage.instance.ref().child("songs").child("hym_1.mp3");
   ref.getDownloadURL().then((value){
     myplayer.play(value.toString());
   });
  } 
  

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: "Song test",
      home: Scaffold(

        appBar: AppBar(title: Text("Song Test"), centerTitle: true,),
        body: Container(

          child: Center(
            child: RawMaterialButton(
              child: Text("Play Song"),
              onPressed: (){},
            ),
          ),
        ),
      ),
    );
  }
}