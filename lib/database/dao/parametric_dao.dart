import 'package:grey_pile_of_shame/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class ParametricDao {
  final dbHelper = DatabaseHelper();

  // =========================
  // ROLES DE BATALLA
  // =========================
  Future<List<Map<String, dynamic>>> getRoles() async {
    final db = await dbHelper.database;

    return await db.query('roles', orderBy: 'name ASC');
  }

  // =========================
  // ESTADOS DE PINTADO
  // =========================
  Future<List<Map<String, dynamic>>> getPaintingStatuses() async {
    final db = await dbHelper.database;

    return await db.query('painting_status', orderBy: 'id ASC');
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
      await db.insert('roles', {'name': 'Cuartel general'});
      await db.insert('roles', {'name': 'Línea'});
      await db.insert('roles', {'name': 'Élite'});
      await db.insert('roles', {'name': 'Ataque rápido'});
      await db.insert('roles', {'name': 'Apoyo pesado'});
    }

    final statusEmpty = await isTableEmpty('painting_status');

    if (statusEmpty) {
      await db.insert('painting_status', {'name': 'Sin montar'});
      await db.insert('painting_status', {'name': 'Montado'});
      await db.insert('painting_status', {'name': 'Imprimado'});
      await db.insert('painting_status', {'name': 'Base'});
      await db.insert('painting_status', {'name': 'Detalles'});
      await db.insert('painting_status', {'name': 'Table Top'});
      await db.insert('painting_status', {'name': 'Terminado'});
    }
  }
}
