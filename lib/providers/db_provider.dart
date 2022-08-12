import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

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
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
       ''');
    });
  }

  Future<int?> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // Verificar la base de datos
    final db = await database;

    final res = await db?.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' )
  ''');

    return res;
  }

  Future<int?> nuevoScan(ScanModel nuevoScan) async {
    // Verificar la base de datos
    final db = await database;

    final res = await db?.insert('Scans', nuevoScan.toJson());
    print(res);
    return res;
  }

  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db?.query('Scans', where: 'id = ?', whereArgs: [id]);

    return ScanModel.fromJson(res!.first);
  }

  Future<List<ScanModel?>> getTodosLosScans() async {
    final db = await database;
    final res = await db?.query('Scans');

    return res!.map((s) => ScanModel.fromJson(s)).toList();
  }

  Future<List<ScanModel?>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db?.rawQuery('''
        SELECT * FROM Scans WHERE tipo = '$tipo'
      ''');

    return res!.map((s) => ScanModel.fromJson(s)).toList();
  }

  Future<int?> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    // Si no se especifica el Where, actualiza todos los datos. Así se actualiza el id que tenga ese scan
    final res = await db?.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }

  Future<int?> deleteScan(int id) async {
    final db = await database;
    // Si no se especifica el Where, se borra todo
    final res = await db?.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Borrar todo, hecho de una manera más compleja
  Future<int?> deleteAllScans() async {
    final db = await database;
    final res = await db?.rawDelete('''
        DELETE FROM Scans
        ''');
    return res;
  }
}
