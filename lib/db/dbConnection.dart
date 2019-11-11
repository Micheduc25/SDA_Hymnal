import 'dart:async';

import 'package:path/path.dart';
import 'package:sda_hymnal/models/favorite_model.dart';
import 'package:sda_hymnal/models/hym.dart';
import 'package:sda_hymnal/models/hymVerses.dart';
import 'package:sqflite/sqflite.dart';

class DBConnect {
// Open the database and store the reference.
  Future<Database> database;
  DBConnect() {
    this.database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.

      join(getDatabasesPath().toString(), 'hymnal_database.db'),
      onOpen: (db) {
        // print("Creating table favorites ");
        
        // return db.execute(
        //     '''CREATE TABLE favorites (id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
        // number INTEGER NOT NULL);''');

        // return db.execute(
        //     "CREATE TABLE hyms(id INTEGER PRIMARY KEY, number INTEGER, title VARCHAR(20) NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL);");
      },

      onCreate: (db, version) {
        // print("The db is " + db.toString());
        // // Run the CREATE TABLE statement on the database.
        // db.execute(
        //     '''CREATE TABLE favorites (id INTEGER NOT NULL  PRIMARY KEY AUTOINCREMENT,
        // number INTEGER NOT NULL);''');
        // print("Table to be created...");
        // return db.execute(
        //     "CREATE TABLE hyms(id INTEGER PRIMARY KEY, number INTEGER, title VARCHAR(20) NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL);");
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

// Define a function that inserts hym into the database
  Future<bool> insertHym(Hym hym) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the hym into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    try {
      await db.insert(
        'hyms',
        hym.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

     
      return true;
    } catch (e) {
      print("An error occured while adding the table :  " + e.toString());
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getHyms() async {
    final Database db = await database;

    try {
      final List<Map<String, dynamic>> hyms =
          await db.rawQuery("SELECT number,title,author,verses,category, music_file FROM hyms");
      // print(hyms.toString());
      print("successful retrieval   ");

      // db.close();
      return hyms;
    } catch (e) {
      print("an error occured while retrieving data " + e.toString());
      db.close();
      return null;
    }
  }

  Future<Map<String, dynamic>> getHym(int hymNumber) async {
    List<Map<String, dynamic>> allHyms;
    Map<String, dynamic> thehym;

    await getHyms().then((hyms) {
      allHyms = hyms;
    });

    try {
      thehym = allHyms.singleWhere((hym) {
        if (hym['number'] == hymNumber) {
          return true;
        } else
          return false;
      });

      return thehym;
    } catch (e) {
      return null;
    }
  }

  Future<Map<String, dynamic>> getHymByTitle(String hymTitle) async {
    List<Map<String, dynamic>> allHyms;
    Map<String, dynamic> thehym;

    await getHyms().then((hyms) {
      allHyms = hyms;
    });

    try {
      thehym = allHyms.singleWhere((hym) {
        if (hym['title'] == hymTitle) {
          return true;
        } else
          return false;
      });

      return thehym;
    } catch (e) {
      return null;
    }
  }

  addFavorite(int number) async {
    Database db = await database;

    Favorite fav = new Favorite(hymNumber: number);

    db.insert("favorites", fav.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    db.close();
  }

  Future<List<int>> getFavorites() async {
    Database db = await database;

    List<Map<String, dynamic>> favorites = await db.query("favorites");
    if (favorites != null) {
      List<int> finalList = [];

      favorites.forEach((fav) {
        finalList.add(fav['number']);
      });

      db.close();
      return finalList;
    } else {
      db.close();
      return null;
    }
  }

  Future<void> removeFavorite(int number) async {
    Database db = await database;

    try {
      db.delete("favorites", where: "favorites.number=${number.toString()}");
      print("successfuly removed favorite");
    } catch (e) {
      print("error while deleting" + e.toString());
    }

    db.close();
  }

}

// Create a hym and add it to the hym table.
