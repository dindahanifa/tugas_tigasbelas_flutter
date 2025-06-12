import 'package:tugas_tigasbelas_flutter/tugas_tigabelas/model/model_user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'ppkd_b_2.db'),
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, username TEXT, email TEXT, phone TEXT, password TEXT)',
        );
      },
    );
  }

  static Future<UserModel?> getEmailandPassword(String email, String password) async {
    final db = await initDB();
    final result = await db.query(
      'users', 
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (result.isNotEmpty) {
      return UserModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  static Future<void> insertUser(UserModel user) async {
    final db = await initDB();
    await db.insert(
      'users', 
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> registerUser({UserModel? data}) async {
    final db = await initDB();

    await db.insert(
      'users',
      {
        'name': data?.name,
        'username': data?.username,
        'email': data?.email,
        'phone': data?.phone,
        'password': data?.password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("User registered successfully");
  }

  static Future<UserModel> login(String email, String password) async {
    final db = await initDB();
    final List<Map<String, dynamic>> data = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (data.isNotEmpty) {
      return UserModel.fromMap(data.first);
    } else {
      throw Exception("Invalid email or password");
    }
  }
}
