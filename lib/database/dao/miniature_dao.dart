import 'package:grey_pile_of_shame/database/database_helper.dart';
import 'package:grey_pile_of_shame/models/miniature.dart';

class MiniatureDao {
  final dbHelper = DatabaseHelper();

  Future<List<Miniature>> getMiniatures(int unitId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      'miniatures',
      where: 'unit_id = ?',
      whereArgs: [unitId],
      orderBy: 'id ASC',
    );
    return maps.map((m) => Miniature.fromMap(m)).toList();
  }

  Future<int> insertMiniature(Miniature mini) async {
    final db = await dbHelper.database;
    return await db.insert('miniatures', mini.toMap());
  }

  Future<int> updateMiniature(Miniature mini) async {
    final db = await dbHelper.database;
    return await db.update(
      'miniatures',
      mini.toMap(),
      where: 'id = ?',
      whereArgs: [mini.id],
    );
  }

  Future<int> deleteMiniature(int id) async {
    final db = await dbHelper.database;
    return await db.delete('miniatures', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateAllStatuses(int unitId, int status) async {
    final db = await dbHelper.database;
    return await db.update(
      'miniatures',
      {'painting_status': status},
      where: 'unit_id = ?',
      whereArgs: [unitId],
    );
  }
}
