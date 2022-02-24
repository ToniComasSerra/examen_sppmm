import 'dart:io';

import 'package:examen_sppmm/models/models.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if(_database == null) _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Despesa(
            id INTEGER PRIMARY KEY,
            titol TEXT,
            quantitat TEXT
          )
        ''');
      }
    );
  }

  Future<int> insert(Despesa nou) async {
    final db = await database;
    final res = await db.insert('Despesa', nou.toMap());
    return res;
  }

  Future<List<Despesa>> getAll() async {
    final db = await database;
    final res = await db.query('Despesa');
    return res.isNotEmpty ? res.map((e) => Despesa.fromMap(e)).toList():[];
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = db.delete('Despesa');
    return res;
  }

  Future<int> delete(int id) async {
    final db = await database;
    final res = db.delete('Despesa', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}