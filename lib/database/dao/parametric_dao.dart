import 'package:grey_pile_of_shame/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ParametricDao {
  final dbHelper = DatabaseHelper();

  // =========================
  // ROLES DE BATALLA
  // =========================
  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await dbHelper.database;

    return await db.query('roles', orderBy: 'orden ASC');
  }

  // =========================
  // ESTADOS DE PINTADO
  // =========================
  Future<List<Map<String, dynamic>>> getPaintingStatuses() async {
    final db = await dbHelper.database;

    return await db.query('painting_status', orderBy: 'orden ASC');
  }

  Future<bool> isTableEmpty(String tableName) async {
    final db = await dbHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM $tableName',
    );

    final count = Sqflite.firstIntValue(result) ?? 0;

    return count == 0;
  }

  // =========================
  // OPCIONAL: insertar datos iniciales
  // =========================

  Future<void> insertDefaultDataIfNeeded() async {
    final db = await dbHelper.database;
    final rolesEmpty = await isTableEmpty('roles');

    if (rolesEmpty) {
      await db.insert('roles', {'name': 'Cuartel general', 'orden': 1});
      await db.insert('roles', {'name': 'Línea', 'orden': 2});
      await db.insert('roles', {'name': 'Élite', 'orden': 3});
      await db.insert('roles', {'name': 'Ataque rápido', 'orden': 4});
      await db.insert('roles', {'name': 'Apoyo pesado', 'orden': 5});
    }

    final statusEmpty = await isTableEmpty('painting_status');

    if (statusEmpty) {
      await db.insert('painting_status', {'name': 'Sin montar', 'orden': 0});
      await db.insert('painting_status', {'name': 'Montado', 'orden': 1});
      await db.insert('painting_status', {'name': 'Imprimado', 'orden': 2});
      await db.insert('painting_status', {'name': 'Base', 'orden': 3});
      await db.insert('painting_status', {'name': 'Detalles', 'orden': 4});
      await db.insert('painting_status', {'name': 'Table Top', 'orden': 5});
      await db.insert('painting_status', {'name': 'Terminado', 'orden': 6});
    }
  }
}
