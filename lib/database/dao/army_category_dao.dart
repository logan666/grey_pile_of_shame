import 'package:grey_pile_of_shame/database/database_helper.dart';
import '../../models/army_category.dart';

class ArmyCategoryDao {
  final dbHelper = DatabaseHelper();

  // Obtener todas las categorías de un juego
  Future<List<ArmyCategory>> getCategoriesByGame(int gameId) async {
    final db = await dbHelper.database;

    final maps = await db.query(
      'army_categories',
      where: 'game_id = ?',
      whereArgs: [gameId],
      orderBy: 'name ASC',
    );

    return maps.map((m) => ArmyCategory.fromMap(m)).toList();
  }

  // Obtener todas las categorías
  Future<List<ArmyCategory>> getAllCategories() async {
    final db = await dbHelper.database;

    final maps = await db.query('army_categories', orderBy: 'name ASC');

    return maps.map((m) => ArmyCategory.fromMap(m)).toList();
  }

  // Insertar categoría
  Future<int> insertCategory(ArmyCategory category) async {
    final db = await dbHelper.database;
    return await db.insert('army_categories', category.toMap());
  }

  // Actualizar categoría
  Future<void> updateCategory(ArmyCategory category) async {
    final db = await dbHelper.database;
    await db.update(
      'army_categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  // Borrar categoría
  Future<int> deleteCategory(int id) async {
    final db = await dbHelper.database;
    return await db.delete('army_categories', where: 'id = ?', whereArgs: [id]);
  }
}
