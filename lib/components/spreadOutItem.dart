import 'package:flutter/material.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';

class SpreadItem extends StatefulWidget {
  // final List itemsSample;
  final String title;
  final Widget child;
  final List<Map<String, dynamic>> hyms;
  SpreadItem({Key key, this.title, this.child, this.hyms}) : super(key: key);

  @override
  _SpreadItemState createState() => _SpreadItemState();
}

class _SpreadItemState extends State<SpreadItem> {
  bool _expand;

  @override
  void initState() {
    super.initState();
    _expand = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: _expand ? Colors.green[300] : Colors.transparent,
                  child: ListTile(
                    leading: Icon(
                      !_expand ? Icons.expand_more : Icons.expand_less,
                      color: Colors.green,
                    ),
                    title: Text(
                      widget.title,
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      setState(() {
                        _expand = !_expand;
                      });
                    },
                  ),
                ),
                Divider(
                  color: Colors.green,
                  thickness: 2,
                  height: 4,
                )
              ],
            ),
          ),
          Container(
            height: 200,
            child: !_expand || widget.hyms == null
                ? Container()
                : ListView.builder(
                    itemCount: widget.hyms.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(
                              Icons.music_note,
                              color: Colors.green,
                            ),
                            title: Text(
                                widget.hyms[index]["number"].toString() +
                                    " - " +
                                    widget.hyms[index]["title"]),
                            onTap: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => HymScreen(
                                        title: widget.hyms[index]["title"],
                                        number: widget.hyms[index]["number"],
                                        content: widget.hyms[index]["verses"],
                                      )));
                            },
                          ),
                          Divider(
                            color: Colors.green,
                            thickness: 2,
                          )
                        ],
                      );
                    },
                  ),
          )
          //here up
        ],
      ),
    );
  }
}
