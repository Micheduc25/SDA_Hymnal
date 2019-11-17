import 'package:flutter/material.dart';
import 'package:sda_hymnal/components/appDrawer.dart';
import 'package:sda_hymnal/screens/hymScreen.dart';
import 'package:sda_hymnal/utils/helperFunctions.dart';
import 'package:sda_hymnal/utils/preferences/preferences.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class CategorySearchScreen extends StatefulWidget {
  @override
  _CategorySearchScreenState createState() => _CategorySearchScreenState();
}

class _CategorySearchScreenState extends State<CategorySearchScreen> {
  Map<String, List<Map<String, dynamic>>> hyms;
  Map<String, List<Widget>> allEntries;
  List<String> allKeys;
  bool _loading;
  StreamingSharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loading = true;
    StreamingSharedPreferences.instance.then((prefs) {
      setState(() {
        _prefs = prefs;
      });
    });

    HelperFunctions.getAllHymsByCategory().then((hymsList) {
      setState(() {
        hyms = hymsList;
        allEntries = hymEntries(hyms, context);
        allKeys = allEntries.keys.toList();
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryIconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(color: Colors.white, fontSize: 20)))),
      title: 'category search screen',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search by Theme'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        drawer: Drawer(
          child: _prefs != null
              ? MyDrawer(settings: MyAppSettings(_prefs))
              : Drawer(),
        ),
        body: Stack(
          children: <Widget>[
            !_loading
                ? ListView.builder(
                    itemCount: allEntries.length,
                    itemBuilder: (BuildContext context, int index) => Column(
                          children: <Widget>[
                            ExpansionTile(
                              leading: Icon(Icons.library_music),
                              title: Text(
                                allKeys[index].toUpperCase(),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              children: allEntries[allKeys[index]],
                            ),
                            Divider(
                              color: Colors.grey,
                            )
                          ],
                        ))
                : Container(),
            _loading
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Colors.green,
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}

Map<String, List<Widget>> hymEntries(
    Map<String, List<Map<String, dynamic>>> rawHyms, BuildContext context) {
  Map<String, List<Widget>> currChildrenMap = {};

  rawHyms.forEach((category, hyms) {
    List<Widget> currChildren = [];

    hyms.forEach((hym) {
      currChildren.add(ListTile(
        leading: Icon(
          Icons.music_note,
          color: Colors.green,
        ),
        title: Text(hym["number"].toString() + " - " + hym["title"]),
        onTap: () async {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => HymScreen(
                    title: hym["title"],
                    number: hym["number"],
                    content: hym["verses"],
                  )));
        },
      ));
    });

    currChildrenMap[category] = currChildren;
  });

  return currChildrenMap;
}
