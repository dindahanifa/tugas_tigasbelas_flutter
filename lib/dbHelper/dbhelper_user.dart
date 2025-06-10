import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tugas_tigasbelas_flutter/model/user_model.dart';

class DBHelperUser {
  static Database? _database;

  // Singleton database instance
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'user_database.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            email TEXT PRIMARY KEY,
            password TEXT,
            name TEXT,
            phone TEXT,
            username TEXT
          )
        ''');
      },
    );
  }

  // Fungsi untuk menyimpan data user ke database (register)
  static Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fungsi untuk mengambil data user dari database (login)
  static Future<UserModel?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
