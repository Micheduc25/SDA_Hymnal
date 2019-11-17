import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/db/dbConnection.dart';
import 'package:sda_hymnal/provider/musicBarProvider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';

enum SongMode { remote, local } //enums define a list of named constants

class MusicBar extends StatefulWidget {
  MusicBar({this.hymNumber});
  final int hymNumber;
  @override
  _MusicBarState createState() => _MusicBarState();
}

class _MusicBarState extends State<MusicBar> {
  AudioPlayer _audioPlayer;
  AudioPlayerState _playState;
  Duration _duration;
  Duration _position;
  StorageReference _storage;
  String songUrl;
  bool _musicDownloaded;
  SongMode _songMode;
  String _localSongPath;
  bool _downloading;

  StreamSubscription _errorSubscribtion;
  StreamSubscription _positionSubscription;
  StreamSubscription _onCompleteSubscription;
  StreamSubscription _durationSubscription;
  StreamSubscription _playerStateSubscription;

  @override
  void initState() {
    super.initState();

    initAudioPlayer();
    _musicDownloaded = false;
    songUrl = "";
    _downloading = false;

    _songMode = SongMode.remote;

    HelperFunctions.isLocalFile("hym_${widget.hymNumber.toString()}.mp3")
        .then((isLocal) {
      if (isLocal) {
        getApplicationDocumentsDirectory().then((dir) {
          setState(() {
            _localSongPath = dir.path + "/hym_${widget.hymNumber}.mp3";
            print("local path set");
            _songMode = SongMode.local;
            _musicDownloaded = true;
          });
        });
      }
    });

    try {
      _storage = FirebaseStorage.instance
          .ref()
          .child("songs")
          .child("hym_${widget.hymNumber.toString()}.mp3");
    } catch (er) {
      print("error setting up reference +${er.toString()}");
    }

    try {
      _storage.getDownloadURL().then((url) {
        songUrl = url.toString();
      }).timeout(Duration(seconds: 40), onTimeout: () {
        print("connection timed out... please check network");
      }).catchError((err) {
        if (err is PlatformException) {
          print("platformexception 1 has occured");
          return;
        }
        return;
      });
    } catch (err) {
      if (err is PlatformException) {
        print("platform exception occured");
      }
    }

    _playState = AudioPlayerState.STOPPED;
  }

  @override
  void dispose() {
    _errorSubscribtion?.cancel();
    _onCompleteSubscription?.cancel();
    _playerStateSubscription?.cancel();
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MusicBarProvider>(
          builder: (context) => MusicBarProvider(),
        )
      ],
      child: Container(
        constraints: BoxConstraints(
            maxHeight: 120,
            minHeight: 40,
            maxWidth: double.infinity,
            minWidth: double.infinity),
        color: Colors.green,
        padding: EdgeInsets.all(10),
        child: Consumer<MusicBarProvider>(
          builder: (context, data, child) => Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  SliderTheme(
                    data: SliderThemeData(
                        activeTrackColor: Colors.blueAccent,
                        thumbColor: Colors.white,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 13),
                        inactiveTrackColor: Colors.white),
                    child: Slider(
                      //slider position is by default between 0 and 1

                      onChanged: (v) {
                        final pos = v * _duration.inMilliseconds;
                        _audioPlayer.seek(Duration(milliseconds: pos.round()));
                      },
                      value: (_position != null &&
                              _duration != null &&
                              _position.inMilliseconds > 0 &&
                              _position.inMilliseconds <
                                  _duration.inMilliseconds)
                          ? _position.inMilliseconds /
                              _duration
                                  .inMilliseconds //which is between 0 and 1
                          : 0.0,
                    ),
                  )
                ],
              ),
              Container(
                // padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _musicBarWidgets()),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _musicBarWidgets() {
    List<Widget> widgets = [
      new MusicBarItem(
        icon: Icons.play_arrow,
        color: _playState == AudioPlayerState.PLAYING
            ? Colors.blueAccent
            : Colors.white,
        onClick: () async {
          if (_playState == AudioPlayerState.PAUSED) {
            _audioPlayer.resume().then((int val) {
              if (val == 1) {
                setState(() {
                  _playState = AudioPlayerState.PLAYING;
                });
              }
            });
          } else if (_playState == AudioPlayerState.STOPPED) {
            try {
              final playPosition = (_position != null &&
                      _duration != null &&
                      _position.inMilliseconds > 0 &&
                      _position.inMilliseconds < _duration.inMilliseconds)
                  ? _position
                  : null;

              if (_songMode == SongMode.remote) {
                try {
                  await _audioPlayer
                      .play(songUrl, position: playPosition)
                      .then((int val) {
                    if (val == 1) {
                      setState(() {
                        _playState = AudioPlayerState.PLAYING;
                        print("state is playing");
                      });
                    }
                  }).catchError((Object err) {
                    showMyDialogue(
                        "Unable to Play Song",
                        '''Sorry we were not able to play this song,please check your internet connection''',
                        context,
                        positive: false);
                    return err;
                  }).timeout(Duration(minutes: 2), onTimeout: () {
                    showMyDialogue(
                        "Timeout",
                        '''Sorry your internet connection is not the best, please verify your connection and try again''',
                        context,
                        positive: false);
                    setState(() {
                      _playState = AudioPlayerState.STOPPED;
                      print("stopped play due to timeout");
                    });
                  });
                } catch (e) {
                  if (e is PlatformException) {
                    showMyDialogue(
                        "Unable to Play Song",
                        '''Sorry we were not able to play this song,please check your internet connection''',
                        context,
                        positive: false);
                  }
                }
              } else {
                _audioPlayer
                    .play(_localSongPath, isLocal: true, position: playPosition)
                    .then((int val) {
                  if (val == 1) {
                    setState(() {
                      _playState = AudioPlayerState.PLAYING;
                    });
                  }
                });
              }
            } catch (e) {
              print(
                  "unable to play the song : verify if hym ${widget.hymNumber.toString()} exists");
            }
          }
        },
      ),
      new MusicBarItem(
        icon: Icons.pause,
        color: _playState == AudioPlayerState.PAUSED
            ? Colors.blueAccent
            : Colors.white,
        onClick: () async {
          if (_playState == AudioPlayerState.PLAYING) {
            await _audioPlayer.pause().then((int val) {
              if (val == 1) {
                setState(() {
                  _playState = AudioPlayerState.PAUSED;
                });
              }
            });
          }
        },
      ),
      new MusicBarItem(
        icon: Icons.stop,
        color: _playState == AudioPlayerState.STOPPED
            ? Colors.blueAccent
            : Colors.white,
        onClick: () {
          if (_playState == AudioPlayerState.PAUSED ||
              _playState == AudioPlayerState.PLAYING) {
            _audioPlayer.stop().then((int val) {
              if (val == 1) {
                setState(() {
                  _playState = AudioPlayerState.STOPPED;
                  _position = Duration();
                });
              }
            });
          }
        },
      ),
    ];

    if (!_musicDownloaded) {
      widgets.add(!_downloading
          ? Tooltip(
              message: "Download Melody from cloud",
              child: InkWell(
                child: Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                  size: 40,
                ),
                onTap: () async {
                  setState(() {
                    _downloading = true;
                  });

                  final dir = await getApplicationDocumentsDirectory()
                      .catchError((dir) {
                    print("Could not get application working directory");
                    return dir;
                  });

                  String path = dir.path;

                  File songFile =
                      new File('$path/hym_${widget.hymNumber.toString()}.mp3');
                  // print(songFile.path);

                  try {
                    //download happens here
                    var downloadUrl = await _storage
                        .getDownloadURL()
                        .catchError((Object err) {
                      print("error getting download url");
                      return err;
                    }).timeout(Duration(minutes: 1), onTimeout: () {
                      setState(() {
                        _downloading = false;
                        showMyDialogue(
                            "Timeout",
                            "The connection has timed out. Please check your internet connection and try again",
                            context,
                            positive: false);
                      });
                    });

                    if (_downloading) {
                      final bytes = await readBytes(downloadUrl)
                          .timeout(Duration(minutes: 1), onTimeout: () {
                        setState(() {
                          _downloading = false;
                          showMyDialogue(
                              "Timeout",
                              "The connection has timed out. Please check your internet connection and try again",
                              context,
                              positive: false);
                        });
                        return;
                      }); //we get the bytes of the file  from the download url

                      if (_downloading) {
                        await songFile.writeAsBytes(bytes);
                      }
                    } //we write these bytes into the file we created
                  } catch (e) {
                    showMyDialogue(
                        "Download Error",
                        "An error occured during downloading try again please",
                        context,
                        positive: false);

                    setState(() {
                      _downloading = false;
                    });
                  }

                  //check if created file exists in our local storage
                  if (_downloading) {
                    if (await songFile.exists()) {
                      await DBConnect().addLocalFile(
                          "hym_${widget.hymNumber.toString()}.mp3");
                      showMyDialogue(
                          "Download Successful",
                          "The download was successful, now you can play the hym locally",
                          context);
                      setState(() {
                        _musicDownloaded = true;
                        _songMode = SongMode.local;
                        _localSongPath = songFile.path;
                        _downloading = false;
                      });
                    } else {
                      showMyDialogue(
                          "Download Error",
                          "An error occured during downloading try again please",
                          context,
                          positive: false);
                    }
                  }
                },
              ),
            )
          : CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 4,
            ));
    }

    return widgets;
  }

  initAudioPlayer() {
    _audioPlayer = new AudioPlayer();

    _errorSubscribtion = _audioPlayer.onPlayerError.listen((msg) {
      print("an error occured $msg");
    });

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _onCompleteSubscription = _audioPlayer.onPlayerCompletion.listen((_) {
      setState(() {
        _playState = AudioPlayerState.STOPPED;
        _position = Duration();
      });
    });

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _playState = state;
      });
    }).onError((Object err) {
      print("error with player state subscription");
      return err;
    });
  }

  showMyDialogue(String title, String message, BuildContext context,
      {bool positive = true}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green[50],
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            titleTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            contentTextStyle:
                TextStyle(color: positive ? Colors.green : Colors.red),
            content: Container(
              child: Text(message),
              padding: EdgeInsets.all(10),
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          );
        });
  }
}

class MusicBarItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onClick;
  const MusicBarItem({Key key, this.icon, this.onClick, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(
          icon,
          color: this.color ?? Colors.white,
          size: 40,
        ),
      ),
      onTap: onClick,
    );
  }
}
