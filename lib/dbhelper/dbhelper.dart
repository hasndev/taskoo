import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqlite_api.dart';

class Databasehelper {
  static final _databasename = "taskoo.db";
  static final _dtatbaseversion = 1;
  static final table = "tasks";
  static final columID = "id";
  static final columnTitle = "title";
  static final columnDesc = "desc";

  static Database? _database;

  Databasehelper._privateConstructor();
  static final Databasehelper instance = Databasehelper._privateConstructor();

  Future<Database?> get databse async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentsdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsdirectory.path, _databasename);
    return await openDatabase(path,
        version: _dtatbaseversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table(
    $columID INTEGER PRIMARY KEY,
    $columnTitle TEXT NOT NULL,
    $columnDesc TEXT NOT NULL
    );
    ''');
  }

  Future<int?> insert(Map<String, dynamic> todo) async {
    Database? db = await instance.databse;
    return await db?.insert(table, todo);
  }

  Future<int?> deleteTodo(int id) async {
    Database? db = await instance.databse;
    return await db?.delete(table, where: "id=?", whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>?> queryAll() async {
    Database? db = await instance.databse;
    return await db?.query(table);
  }
}
