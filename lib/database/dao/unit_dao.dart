import 'package:grey_pile_of_shame/database/database_helper.dart';
import '../../models/unit.dart';

class UnitDao {
  final dbHelper = DatabaseHelper();

  Future<int> insertUnit(Map<String, dynamic> unitMap) async {
    final db = await dbHelper.database;
    return await db.insert('units', unitMap);
  }

  Future<List<Unit>> getUnits(int armyId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'units',
      where: 'army_id = ?',
      whereArgs: [armyId],
    );

    return maps.map((m) => Unit.fromMap(m)).toList();
  }

  Future<int> updateUnit(int id, Map<String, dynamic> unit) async {
    final db = await dbHelper.database;
    return await db.update('units', unit, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUnit(int id) async {
    final db = await dbHelper.database;
    return await db.delete('units', where: 'id = ?', whereArgs: [id]);
  }
}
