import 'dart:async';
import 'package:sda_hymnal/models/hym.dart';
import 'package:sda_hymnal/utils/hymString.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ConnectDB {
  Future<Database> database =
      openDatabase(join(getDatabasesPath().toString(), 'hymnal_database.db'),

          //when database is created freshly
          onCreate: (db, version) async {
    await db.execute(
        '''CREATE TABLE favorites (id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
        number INTEGER NOT NULL);''');

    await db.execute(
        '''CREATE TABLE local_hyms (id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
         name VARCHAR(20) NOT NULL);''');

    print("Table to be created... in OnCreate");
    await db.execute(
        '''CREATE TABLE hyms(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, number INTEGER, title VARCHAR(20)
             NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL, category VARCHAR(20),
              music_file VARCHAR(20) NOT NULL);''');
  },

          //when database is reopened
          onOpen: (db) async {
    // try {
    //   await db.execute("DROP TABLE hyms");
    //   await db.execute("DROP TABLE local_hyms");
    // } catch (e) {
    //   print("table no exist");
    // }

    // await db.execute(
    //     '''CREATE TABLE local_hyms (id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
    //     name VARCHAR(20) NOT NULL);''').catchError((err){
    //       print("pass here");
    //     });

    // await db.execute(
    //     '''CREATE TABLE hyms(id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, number INTEGER, title VARCHAR(20)
    //          NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL, category VARCHAR(20),
    //           music_file VARCHAR(20) NOT NULL);''').catchError((err){
    //             print("pass on this too");
    //           });
  }, version: 1);

  Future<void> setHyms() async {
    Database db = await database;

    List<Hym> allHyms = AllHyms().createAllHyms();

    for (Hym hym in allHyms) {
      await db.insert('hyms', hym.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }
}
