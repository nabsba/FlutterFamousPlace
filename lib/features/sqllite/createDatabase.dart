// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('famousPlaces.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    // // Delete the existing database file
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      // onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Enable foreign keys
    await db.execute('PRAGMA foreign_keys = ON;');

    // Create userinfos table
    await db.execute('''
    CREATE TABLE userinfos (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      photoURL TEXT NOT NULL,
      userId TEXT NOT NULL
    );
  ''');

    // Create Role table
    await db.execute('''
    CREATE TABLE Role (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      roleName TEXT UNIQUE NOT NULL DEFAULT 'client',
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  ''');

    // Create User table
    await db.execute('''
    CREATE TABLE User (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      name TEXT,
      email TEXT UNIQUE NOT NULL,
      image TEXT,
      roleId TEXT NOT NULL,
      language TEXT,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      userAuthentificationId TEXT,
      isUserBlocked INTEGER CHECK (isUserBlocked IN (0, 1)),
      updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (roleId) REFERENCES Role (id) ON DELETE CASCADE
    );
  ''');

    // Create Country table
    await db.execute('''
    CREATE TABLE Country (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT UNIQUE NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  ''');

    // Create City table
    await db.execute('''
    CREATE TABLE City (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      countryId INTEGER NOT NULL,
      FOREIGN KEY (countryId) REFERENCES Country (id) ON DELETE CASCADE
    );
  ''');

    // Create Address table
    await db.execute('''
    CREATE TABLE Address (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      number INTEGER NOT NULL,
      street TEXT NOT NULL,
      postcode TEXT NOT NULL,
      cityId INTEGER NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      updatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (cityId) REFERENCES City (id) ON DELETE CASCADE
    );
  ''');

    // Create Place table
    await db.execute('''
    CREATE TABLE Place (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      popularity INTEGER DEFAULT 0,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      addressId TEXT NOT NULL,
      image TEXT,
      price TEXT,
      hoursTravel TEXT,
      FOREIGN KEY (addressId) REFERENCES Address (id) ON DELETE CASCADE
    );
  ''');

    // Create PlaceOnUser join table
    await db.execute('''
    CREATE TABLE PlaceOnUser (
      userId TEXT NOT NULL,
      placeId TEXT NOT NULL,
      PRIMARY KEY (userId, placeId),
      FOREIGN KEY (userId) REFERENCES User (id) ON DELETE CASCADE,
      FOREIGN KEY (placeId) REFERENCES Place (id) ON DELETE CASCADE
    );
  ''');

    // Create PlaceDetail table
    await db.execute('''
    CREATE TABLE PlaceDetail (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      name TEXT NOT NULL,
      description TEXT NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      placeId TEXT NOT NULL,
      languageId INTEGER NOT NULL,
      FOREIGN KEY (placeId) REFERENCES Place (id) ON DELETE CASCADE
    );
  ''');

    // Create Language table
    await db.execute('''
    CREATE TABLE Language (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT UNIQUE NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP
    );
  ''');

    // Create Booking table
    await db.execute('''
    CREATE TABLE Booking (
      id TEXT PRIMARY KEY DEFAULT (lower(hex(randomblob(16)))),
      dateStart DATETIME NOT NULL,
      dateEnd DATETIME NOT NULL,
      createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
      availableFrom DATETIME NOT NULL,
      notAvailableEnd DATETIME NOT NULL,
      placeId TEXT NOT NULL,
      FOREIGN KEY (placeId) REFERENCES Place (id) ON DELETE CASCADE
    );
  ''');

    // Add indexing for foreign keys
    await db.execute('CREATE INDEX idx_user_roleId ON User(roleId);');
    await db.execute('CREATE INDEX idx_place_addressId ON Place(addressId);');
    await db.execute('CREATE INDEX idx_address_cityId ON Address(cityId);');
    await db.execute('CREATE INDEX idx_city_countryId ON City(countryId);');
    await db.execute('CREATE INDEX idx_booking_placeId ON Booking(placeId);');
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
