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

  Future<Map<String, int>> getMiniatureStats(int unitId) async {
    final db = await DatabaseHelper().database;

    final totalResult = await db.rawQuery(
      'SELECT COUNT(*) as total FROM miniatures WHERE unit_id = ?',
      [unitId],
    );

    final finishedResult = await db.rawQuery(
      'SELECT COUNT(*) as finished FROM miniatures WHERE unit_id = ? AND painting_status = ?',
      [unitId, 7], // 7 = terminada
    );

    final total = (totalResult.first['total'] ?? 0) is int
        ? totalResult.first['total'] as int
        : (totalResult.first['total'] as num).toInt();

    final finished = (finishedResult.first['finished'] ?? 0) is int
        ? finishedResult.first['finished'] as int
        : (finishedResult.first['finished'] as num).toInt();

    return {'total': total, 'finished': finished};
  }
}
