// import 'dart:io';

import 'dart:io';

import 'package:maico_land/model/entities/news.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  DataBaseHelper._privateConstructor();
  static final DataBaseHelper instance = DataBaseHelper._privateConstructor();

  static Database? _database; //

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'maicoland.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    drop table news

''');
    await db.execute('''
      CREATE TABLE news(
        id TEXT PRIMARY KEY , 
        title TEXT,
        content TEXT,
        createdDate TEXT,
        updatedDate TEXT,
        type INTEGER,
        viewed INTEGER,
        saved INTEGER,
        isPrivated INTERGER,
        createdBy TEXT,
        images TEXT,
        hashTags TEXT,
        likes TEXT,
      )
''');
  }

  Future<List<News>> getNews() async {
    Database db = await instance.database;
    var news = await db.query('news', orderBy: 'createdDate');
    List<News> newsList =
        news.isNotEmpty ? news.map((c) => News.fromJson(c)).toList() : [];
    return newsList;
  }

  Future<int> add(News news) async {
    Database db = await instance.database;
    await db.execute('''
    drop table news

''');
    await db.execute('''
      CREATE TABLE news(
        id TEXT PRIMARY KEY , 
        title TEXT,
        content TEXT,
        createdDate TEXT,
        updatedDate TEXT,
        type INTEGER,
        viewed INTEGER,
        saved INTEGER,
        isPrivated INTERGER,
        createdBy TEXT,
        images TEXT,
        hashTags TEXT,
        likes TEXT,
      )
''');

    return await db.insert('news', news.toJson());
  }

  Future<int> update(News news) async {
    Database db = await instance.database;
    return await db
        .update('news', news.toJson(), where: 'id=?', whereArgs: [news.id]);
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('news', where: 'id=?', whereArgs: [id]);
  }
}
