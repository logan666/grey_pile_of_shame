import 'package:grey_pile_of_shame/database/database_helper.dart';
import '../../models/game.dart';

class GameDao {
  final dbHelper = DatabaseHelper();

  Future<List<Game>> getGames() async {
    final db = await dbHelper.database;
    final maps = await db.query('games', orderBy: 'name ASC');

    return maps.map((m) => Game.fromMap(m)).toList();
  }

  Future<int> insertGame(Map<String, dynamic> gameMap) async {
    final db = await dbHelper.database;
    return await db.insert('games', gameMap);
  }

  Future<int> deleteGame(int id) async {
    final db = await dbHelper.database;
    return await db.delete('games', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateGame(Game game) async {
    final db = await dbHelper.database;
    await db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
  }
}
