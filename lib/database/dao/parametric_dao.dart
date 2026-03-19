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
      await db.insert('roles', {
        'name': 'Señor de la guerra',
        'orden': 1,
        'code': 'LORD',
      });
      await db.insert('roles', {
        'name': 'Cuartel General',
        'orden': 2,
        'code': 'HQ',
      });
      await db.insert('roles', {'name': 'Linea', 'orden': 3, 'code': 'TROOPS'});
      await db.insert('roles', {
        'name': 'Ataque rápido',
        'orden': 4,
        'code': 'FAST',
      });
      await db.insert('roles', {'name': 'Elite', 'orden': 5, 'code': 'ELITE'});
      await db.insert('roles', {
        'name': 'Transporte Asignado',
        'orden': 6,
        'code': 'TRANS',
      });
      await db.insert('roles', {
        'name': 'Apoyo Pesado',
        'orden': 7,
        'code': 'HEAVY',
      });
      await db.insert('roles', {
        'name': 'Voladores',
        'orden': 8,
        'code': 'FLY',
      });
      await db.insert('roles', {
        'name': 'Fortificación',
        'orden': 9,
        'code': 'FORT',
      });
    }

    final statusEmpty = await isTableEmpty('painting_status');

    if (statusEmpty) {
      await db.insert('painting_status', {
        'name': 'Sin montar',
        'orden': 1,
        'color': '#9E9E9E',
      });
      await db.insert('painting_status', {
        'name': 'Montado',
        'orden': 2,
        'color': '#2196F3',
      });
      await db.insert('painting_status', {
        'name': 'Imprimado',
        'orden': 3,
        'color': '#FF9800',
      });
      await db.insert('painting_status', {
        'name': 'Base',
        'orden': 4,
        'color': '#9C27B0',
      });
      await db.insert('painting_status', {
        'name': 'Detalles',
        'orden': 5,
        'color': '#FFC107',
      });
      await db.insert('painting_status', {
        'name': 'Table Top',
        'orden': 6,
        'color': '#9E9E9E',
      });
      await db.insert('painting_status', {
        'name': 'Terminado',
        'orden': 7,
        'color': '#4CAF50',
      });
    }
  }
}
