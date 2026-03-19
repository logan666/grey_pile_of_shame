import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'grey_pile_of_shame.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE armies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        game_id INTEGER NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE units (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        miniatures INTEGER NOT NULL DEFAULT 1,
        army_id INTEGER NOT NULL,
        role_id INTEGER NOT NULL,
        points INTEGER NOT NULL DEFAULT 0,
        price REAL NOT NULL DEFAULT 0.0,
        painting_status_id INTEGER NOT NULL DEFAULT 0,
        painting_difficulty INTEGER NOT NULL DEFAULT 1,
        finished_at TEXT,
        purchased_at TEXT,
        notes TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE roles (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          orden INTEGER NOT NULL,
          code TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE painting_status (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          orden INTEGER NOT NULL
      );
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      try {
        await db.execute(
          'ALTER TABLE units ADD COLUMN miniatures INTEGER NOT NULL DEFAULT 1',
        );
      } catch (e) {
        print('miniatures ya existe');
      }
    }

    if (oldVersion < 3) {
      try {
        await db.execute(
          'ALTER TABLE roles ADD COLUMN orden INTEGER DEFAULT 0;',
        );

        await db.execute(
          'ALTER TABLE painting_status ADD COLUMN orden INTEGER DEFAULT 0',
        );

        await db.execute('ALTER TABLE roles ADD COLUMN code TEXT');
      } catch (e) {
        print('orden ya existe');
      }
    }
  }
}
