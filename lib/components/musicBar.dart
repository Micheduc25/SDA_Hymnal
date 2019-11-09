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
 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MusicBarProvider>(builder: (context)=>MusicBarProvider(),)
      ],
      
      
      
          child: Container(
        constraints: BoxConstraints(maxHeight: 100,minHeight: 40,
        maxWidth: double.infinity, minWidth: double.infinity),
        color: Colors.green,
        padding: EdgeInsets.all(10),
        child: Consumer<MusicBarProvider>(
                  builder:(context,data,child)=> Column(
            children: <Widget>[
            
              
              LayoutBuilder(
                          builder:(context,constraints){ 
                            
                            return
                            new ProgressBar(position: data.getProgressPosition,onDrag: (details){

                  data.setProrgessPosition=data.getProgressPosition<=constraints.maxWidth-10
                  &&data.getProgressPosition>=0?data.getProgressPosition+details.delta.dx:data.getProgressPosition+0;
                },);
                }
              ),

              Container(
                // padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  new MusicBarItem(icon: Icons.play_arrow, onClick: (){
                      data.playSong();
                    },),
                    new MusicBarItem(icon: Icons.pause, onClick: (){},),
                    new MusicBarItem(icon: Icons.stop, onClick: (){},)
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
  final Function onClick;
  const MusicBarItem({
    Key key,this.icon, this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(icon, color: Colors.white, size: 40,),
      onTap: onClick,
    );
  }
}

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    Key key, this.position,this.onDrag
  }) : super(key: key);

  final double position;
  final void Function(DragUpdateDetails) onDrag;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  Color cursorColor;
  @override
  void initState() {
    cursorColor=Colors.white;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:30 ,
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
                left: widget.position,
                child: GestureDetector(
                  child:
                  
                  Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                  color: cursorColor,
                ),

                onHorizontalDragStart: (details){
                setState(() {
                  cursorColor=Colors.blueAccent;
                });
              },

              onHorizontalDragEnd: (details){
                setState(() {
                  cursorColor=Colors.black;
                });
              },
              onHorizontalDragUpdate: this.widget.onDrag
              ),

              
            )
          ],
        ),
      ),
    );
  }
}