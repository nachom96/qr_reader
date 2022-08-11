import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;

  // El ._ significa constructor privado
  static final DBProvider db = DBProvider._();
  DBProvider._();

  // Es async porque la lectura con la base de datos no es síncrona
  Future<Database?> get database async {
    _database ??= await initDB();

    return _database;
  }

  Future<Database?> initDB() async {
    // Path de donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDB.db');
    print(path);

    // Crear base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){ },
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
       ''');
      }
      );
  }
}
