import '../../models/army_category.dart';
import '../dao/army_category_dao.dart';

class ArmyCategoryRepository {
  final _dao = ArmyCategoryDao();

  // Obtener todas las categorías de un juego
  Future<List<ArmyCategory>> getCategoriesByGame(int gameId) async {
    return await _dao.getCategoriesByGame(gameId);
  }

  // Obtener todas las categorías de todos los juegos
  Future<List<ArmyCategory>> getAllCategories() async {
    return await _dao.getAllCategories();
  }

  // Insertar una nueva categoría
  Future<int> addCategory(ArmyCategory category) async {
    return await _dao.insertCategory(category);
  }

  // Actualizar categoría existente
  Future<void> updateCategory(ArmyCategory category) async {
    await _dao.updateCategory(category);
  }

  // Borrar categoría por id
  Future<int> deleteCategory(int id) async {
    return await _dao.deleteCategory(id);
  }
}
