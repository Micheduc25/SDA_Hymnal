import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sda_hymnal/provider/musicBarProvider.dart';

class MusicBar extends StatefulWidget {
  MusicBar({this.hymNumber});
  final int hymNumber;
  @override
  _MusicBarState createState() => _MusicBarState();
}

class _MusicBarState extends State<MusicBar> {
  AudioCache audioCache;
  AudioPlayer finalPlayer;
  AudioPlayerState _playState;

  @override
  void initState() {
    super.initState();
    audioCache = new AudioCache();

    _playState = AudioPlayerState.STOPPED;
  }

  @override
  void dispose() {
    super.dispose();

    try {
      finalPlayer.stop();
      //  finalPlayer.dispose();
    } catch (e) {
      print("dispose no work  :  " + e.toString());
    }
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
            maxHeight: 70,
            minHeight: 40,
            maxWidth: double.infinity,
            minWidth: double.infinity),
        color: Colors.green,
        padding: EdgeInsets.all(10),
        child: Consumer<MusicBarProvider>(
          builder: (context, data, child) => Column(
            children: <Widget>[
              // LayoutBuilder(
              //   builder:(context,constraints){

              //     return

              //     _playState!=AudioPlayerState.STOPPED? FutureBuilder(
              //     future:finalPlayer.getCurrentPosition() ,
              //     builder:(context,AsyncSnapshot<int> positionSnapshot){

              //       if(positionSnapshot.connectionState==ConnectionState.done){

              //          return ProgressBar(position: positionSnapshot.data ,onDrag: (details){

              //         data.setProrgessPosition=data.getProgressPosition<=constraints.maxWidth-10
              //         &&data.getProgressPosition>=0?data.getProgressPosition+details.delta.dx:data.getProgressPosition+0;
              //       },);

              //   }
              //   return Container();

              //   }
              //               ):Container();
              //   }
              // ),

              Container(
                // padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new MusicBarItem(
                      icon: Icons.play_arrow,
                      color: _playState == AudioPlayerState.PLAYING
                          ? Colors.blueAccent
                          : Colors.white,
                      onClick: () {
                        if (_playState == AudioPlayerState.PAUSED) {
                          finalPlayer.resume().then((int val) {
                            setState(() {
                              _playState = AudioPlayerState.PLAYING;
                            });
                          });
                        } else if (_playState == AudioPlayerState.STOPPED) {
                          try {
                            setState(() {
                              _playState = AudioPlayerState.PLAYING;
                              audioCache
                                  .play(
                                      "hym_${widget.hymNumber.toString()}.mp3")
                                  .then((player) {
                                setState(() {
                                  finalPlayer = player;
                                });
                              });
                            });
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
                          await finalPlayer.pause().then((int val) {
                            setState(() {
                              _playState = AudioPlayerState.PAUSED;
                            });
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
                          finalPlayer.stop().then((int val) {
                            setState(() {
                              _playState = AudioPlayerState.STOPPED;
                            });
                          });
                        }
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key key, this.position, this.onDrag}) : super(key: key);

  final int position;
  final void Function(DragUpdateDetails) onDrag;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  Color cursorColor;
  @override
  void initState() {
    cursorColor = Colors.white;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: double.infinity,
      child: Container(
        // decoration: BoxDecoration(
        //   border: Border.all(color: cursorColor)

        // ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: 2,
              color: Colors.black,
              width: double.infinity,
            ),
            Positioned(
              left: widget.position * 1.0,
              child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                    color: cursorColor,
                  ),
                  onHorizontalDragStart: (details) {
                    setState(() {
                      cursorColor = Colors.blueAccent;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      cursorColor = Colors.black;
                    });
                  },
                  onHorizontalDragUpdate: this.widget.onDrag),
            )
          ],
        ),
      ),
    );
  }
}
