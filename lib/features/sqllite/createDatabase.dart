// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('userinfos.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      // onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const userTable = '''
      CREATE TABLE userinfos (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        photoURL TEXT NOT NULL,
        userId TEXT NOT NULL
      )
    ''';

    await db.execute(userTable);
  }

  // Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
  //   if (oldVersion < 2) {
  //     // Rename the old table
  //     await db.execute('ALTER TABLE userinfos RENAME TO userinfos_old');

  //     // Create the new table with the updated schema
  //     const newUserTable = '''
  //     CREATE TABLE userinfos (
  //       id TEXT PRIMARY KEY,
  //       name TEXT NOT NULL,
  //       photoURL TEXT NOT NULL,
  //       userId TEXT NOT NULL
  //     )
  //   ''';
  //     await db.execute(newUserTable);

  //     // Copy data from the old table to the new table
  //     await db.execute('''
  //     INSERT INTO userinfos (id, name, photoURL, userId)
  //     SELECT id, name, photoURL, userId FROM userinfos_old
  //   ''');

  //     // Drop the old table
  //     await db.execute('DROP TABLE userinfos_old');
  //   }
  // }

  Future<int> deleteAllUsers() async {
    final db = await database;
    return await db.delete('userinfos');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
