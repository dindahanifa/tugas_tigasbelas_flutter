import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_resep.dart';
import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_user.dart';

class DbhelperResep {
  static Future<Database> db() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'resep.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE resep(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            judul TEXT,
            deskripsi TEXT,
            gambar TEXT,
            bahan TEXT,
            langkah TEXT,
            kategori TEXT,
            isFavorit TEXT
          )
          ''',
        );
      },
      version: 1,
    );
  }

  static Future<void> insertResep(Resep resep) async {
    final dbClient = await db();
    await dbClient.insert(
      'resep',
      resep.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Resep>> getAllResep() async {
    final dbClient = await db();
    final List<Map<String, dynamic>> maps = await dbClient.query('resep');

    return List.generate(
      maps.length,
      (i) => Resep.fromMap(maps[i]),
    );
  }

  static Future<void> updateResep(Resep resep) async {
    final dbClient = await db();
    await dbClient.update(
      'resep',
      resep.toMap(),
      where: 'id = ?',
      whereArgs: [resep.id],
    );
  }

  static Future<void> deleteResep(int id) async {
    final dbClient = await db();
    await dbClient.delete(
      'resep',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
