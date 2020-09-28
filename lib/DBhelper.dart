import 'dart:async';
import 'package:path/path.dart';
import 'package:quizapp/admin.dart';
import 'package:sqflite/sqflite.dart';

import 'player.dart';
import 'questions.dart';

class DBHelper {
  static DBHelper _dbHelper;
  static Database _db;

  DBHelper._createInstance();
  factory DBHelper() {
    if (_dbHelper == null) {
      _dbHelper = DBHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> initializeDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'proto2.db'),
      onCreate: (db, version) {
        String table1 = """CREATE TABLE player(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR NOT NULL,
            score INTEGER NOT NULL
          )""";
        String table2 = """CREATE TABLE questions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question VARCHAR NOT NULL,
            choice1 VARCHAR NOT NULL,
            choice2 VARCHAR NOT NULL,
            choice3 VARCHAR NOT NULL,
            choice4 VARCHAR NOT NULL,
            ans VARCHAR NOT NULL
          )""";
        String table3 = """CREATE TABLE admin(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR NOT NULL,
            password INTEGER NOT NULL
          )""";
        String q = """INSERT INTO admin(name, password) VALUES('admin', 'admin')""";
        db.execute(table1);
        db.execute(table2);
        db.execute(table3);
        db.execute(q);
      },
      version: 1,
    );
  }

  Future<Database> getDatabase() async {
    if (_db == null) {
      _db = await initializeDatabase();
    }
    return _db;
  }

  Future<List<Questions>> getQuestions() async {
    var db = await this.getDatabase();
    var list = await db.query('questions');
    List<Questions> userList = [];
    for (var data in list) {
      userList.add(Questions.fromDB(data));
    }
    return userList;
  }

  Future<List<Player>> getPlayer() async {
    var db = await this.getDatabase();
    var list = await db.query('player');
    List<Player> userList = [];
    for (var data in list) {
      userList.add(Player.fromDB(data));
    }
    return userList;
  }

  Future<List<Admin>> getAdmin() async {
    var db = await this.getDatabase();
    var list = await db.query('admin');
    List<Admin> userList = [];
    for (var data in list) {
      userList.add(Admin.fromDB(data));
    }
    return userList;
  }

  Future<int> addQuestion(Questions user) async {
    var db = await this.getDatabase();
    return await db.insert('questions', user.toMap());
  }

  Future<int> addPlayer(Player player) async {
    var db = await this.getDatabase();
    return await db.insert('player', player.toMap());
  }

  Future<int> deleteQuestion(int id) async {
    var db = await this.getDatabase();
    return await db.delete('question', where: 'id = ?', whereArgs: [id]);
  }
}