import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

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
    final path = join(await getDatabasesPath(), 'grey_pile_of_shame8.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        logo TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE armies (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        game_id INTEGER NOT NULL,
        visible INTEGER NOT NULL DEFAULT 0,
        image TEXT,
        logo TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE army_categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        game_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        icon TEXT,
        FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE
      );
    ''');

    await db.execute('''
      CREATE TABLE units (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        army_id INTEGER NOT NULL,
        role_id INTEGER NOT NULL,
        points INTEGER NOT NULL DEFAULT 0,
        price REAL NOT NULL DEFAULT 0.0,
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
          orden INTEGER NOT NULL,
          color TEXT NOT NULL
          
      );
    ''');

    await db.execute('''
      CREATE TABLE miniatures (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        unit_id INTEGER NOT NULL,
        description TEXT,
        painting_status INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE
      );
    ''');

    _insertInitialDataFromJson(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    /*if (oldVersion < 2) {
      try {
        await db.execute(
          'ALTER TABLE units ADD COLUMN miniatures INTEGER NOT NULL DEFAULT 1',
        );
      } catch (e) {
        print('miniatures ya existe');
      }
    }*/
  }

  Future<void> _insertInitialDataFromJson(Database db) async {
    final jsonString = await rootBundle.loadString(
      'assets/json/initial_data.json',
    );
    final Map<String, dynamic> data = json.decode(jsonString);
    final Map<String, int> gameIds = {};

    // Insertar juegos
    for (var game in data['games']) {
      final id = await db.insert('games', {
        'name': game['name'],
        'logo': game['logo'],
      });
      gameIds[game['name']] = id;
    }

    // Insertar ejércitos
    for (var army in data['armies']) {
      final gameId = gameIds[army['game']];
      if (gameId != null) {
        await db.insert('armies', {
          'name': army['name'],
          'game_id': gameId,
          'visible': (army['visible'] ?? 1),
        });
      }
    }

    // Insertar categorías
    for (var cat in data['categories']) {
      final gameId = gameIds[cat['game']];
      if (gameId != null) {
        await db.insert('army_categories', {
          'game_id': gameId,
          'name': cat['name'],
          'icon': cat['icon'],
        });
      }
    }
  }
}
