// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class MusicBarProvider with ChangeNotifier{

  double _progressPosition=0.0;
  double _constraintWidth=0.0;

  AudioPlayer _audioPlayer= new AudioPlayer();
  AudioCache _audioCache = new AudioCache();

  set setConstraintWidth(double value){
    _constraintWidth=value;
    // notifyListeners();
  }

  get getConstraintWidth=>_constraintWidth;

  set setProrgessPosition(value){
    this._progressPosition=value;
    notifyListeners();
  }

  get getProgressPosition=>this._progressPosition;

 void  playSong()async{

  //  File songFile = await  _audioCache.load("music/hym1.mp3");
  AudioPlayer anotherPlayer;

    try{
    await _audioCache.play("music/hym1.mp3").then((value){
        anotherPlayer=value;
    });
    }
    catch(e){
      print("We were unable to load the song :"+e.toString());
    }
  //  await _audioPlayer.play("http://sdahymnals.com/Hymnal/mp3/001%20%E2%80%93%20Praise%20to%20the%20Lord.mp3");

  }
}