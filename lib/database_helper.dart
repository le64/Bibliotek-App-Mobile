// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
  String path = join(await getDatabasesPath(), 'books.db');
  try {
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  } catch (e) {
    print('Erreur lors de l\'ouverture de la base de données : $e');
    throw 'Erreur lors de l\'ouverture de la base de données';
  }
}

Future _onCreate(Database db, int version) async {
  try {
    await db.execute(
      'CREATE TABLE books(id INTEGER PRIMARY KEY, title TEXT, author TEXT)',
    );
  } catch (e) {
    print('Erreur lors de la création de la table : $e');
    throw 'Erreur lors de la création de la table';
  }
}


  Future<List<Map<String, dynamic>>> getBooks() async {
    Database db = await database;
    return await db.query('books');
  }

  Future<int> insertBook(Map<String, dynamic> book) async {
    Database db = await database;
    return await db.insert('books', book);
  }

  Future<int> deleteBook(int id) async {
    Database db = await database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }
}
