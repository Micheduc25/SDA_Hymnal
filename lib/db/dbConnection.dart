import 'dart:async';

import 'package:path/path.dart';
import 'package:sda_hymnal/models/hym.dart';
import 'package:sda_hymnal/models/hymVerses.dart';
import 'package:sqflite/sqflite.dart';

class DBConnect {
// Open the database and store the reference.

  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.

    join(getDatabasesPath().toString(), 'hymnal_database.db'),
    onOpen: (db) {
      print("The db is " + db.toString());
      // Run the CREATE TABLE statement on the database.

      // return db.execute(
      //     "CREATE TABLE hyms(id INTEGER PRIMARY KEY, number INTEGER, title VARCHAR(20) NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL);");
    },

    onCreate: (db, version) {
      print("The db is " + db.toString());
      // Run the CREATE TABLE statement on the database.
      print("Table to be created...");
      return db.execute(
          "CREATE TABLE hyms(id INTEGER PRIMARY KEY, number INTEGER, title VARCHAR(20) NOT NULL, author VARCHAR(30), no_verses INTEGER, verses TEXT NOT NULL);");
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

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

      print("successfully inserted hym");

      return true;
    } catch (e) {
      print("An error occured while adding the table :  " + e.toString());
      return false;
    }
  }

  Future<List<Map<String, dynamic>>> getHym() async {
    final Database db = await database;

    try {
      final List<Map<String, dynamic>> hyms =
          await db.rawQuery("SELECT number,title,author,verses FROM hyms");
      print(hyms.toString());

      return hyms;
    } catch (e) {
      print("an error occured while retrieving data " + e.toString());
      return null;
    }
  }
}

// Create a hym and add it to the hym table.
