import 'package:grey_pile_of_shame/database/database_helper.dart';
import 'package:grey_pile_of_shame/models/paint_status.dart';

class PaintingStatusDao {
  final dbHelper = DatabaseHelper();

  Future<List<PaintingStatus>> getAll() async {
    final db = await dbHelper.database;

    final result = await db.query('painting_status', orderBy: 'orden ASC');

    return result.map((e) => PaintingStatus.fromMap(e)).toList();
  }

  Future<int> insert(PaintingStatus status) async {
    final db = await dbHelper.database;

    return await db.insert('painting_status', status.toMap());
  }

  Future<int> update(PaintingStatus status) async {
    final db = await dbHelper.database;

    return await db.update(
      'painting_status',
      status.toMap(),
      where: 'id = ?',
      whereArgs: [status.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await dbHelper.database;

    return await db.delete('painting_status', where: 'id = ?', whereArgs: [id]);
  }
}
