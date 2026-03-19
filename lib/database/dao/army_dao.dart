import 'package:grey_pile_of_shame/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../../models/army.dart';

class ArmyDao {
  final dbHelper = DatabaseHelper();

  Future<List<Army>> getArmiesByGame(int gameId) async {
    final db = await dbHelper.database;

    final maps = await db.query(
      'armies',
      where: 'game_id = ?',
      whereArgs: [gameId],
      orderBy: 'name ASC',
    );

    return maps.map((m) => Army.fromMap(m)).toList();
  }

  Future<List<Army>> getAllArmies() async {
    final db = await dbHelper.database;
    final maps = await db.query('armies', orderBy: 'name ASC');

    return maps.map((m) => Army.fromMap(m)).toList();
  }

  Future<int> insertArmy(Map<String, dynamic> armyMap) async {
    final db = await dbHelper.database;
    return await db.insert('armies', armyMap);
  }

  Future<int> updateArmy(int id, Map<String, dynamic> values) async {
    final db = await dbHelper.database;
    return await db.update('armies', values, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteArmy(int id) async {
    final db = await dbHelper.database;
    await db.delete('units', where: 'army_id = ?', whereArgs: [id]);

    return await db.delete('armies', where: 'id = ?', whereArgs: [id]);
  }

  Future<bool> hasUnits(int armyId) async {
    final db = await dbHelper.database;
    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM units WHERE army_id = ?',
      [armyId],
    );

    final count = Sqflite.firstIntValue(result) ?? 0;
    return count > 0;
  }
}
