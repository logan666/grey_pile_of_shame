import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/parametric_repository.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/models/unit.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/screens/edit/unit_edit_screen.dart';
import 'package:grey_pile_of_shame/screens/list/miniature_screen.dart';

class UnitScreen extends StatefulWidget {
  final Army army;
  const UnitScreen({super.key, required this.army});

  @override
  _UnitScreenState createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final unitRepository = UnitRepository();
  final armyRepository = ArmyRepository();
  final parametricRepository = ParametricRepository();

  List<Unit> units = [];
  List<Map<String, dynamic>> roles = [];
  Map<int, String> roleNames = {};
  Map<int, String> roleCodes = {};
  Map<int, double> unitProgress = {};

  @override
  void initState() {
    super.initState();
    _loadRoles().then((_) => loadUnits());
  }

  Future<void> _loadRoles() async {
    roles = await parametricRepository.getRoles();
    roleNames = {for (var r in roles) r['id'] as int: r['name'] as String};
    roleCodes = {for (var r in roles) r['id'] as int: r['code'] as String};
  }

  Future<void> loadUnits() async {
    final data = await unitRepository.getUnits(widget.army.id!);

    Map<int, double> progressMap = {};

    for (var unit in data) {
      final stats = await unitRepository.getMiniatureStats(unit.id!);
      final total = stats['total'] ?? 0;
      final finished = stats['finished'] ?? 0;
      progressMap[unit.id!] = total > 0 ? finished / total : 0;
    }

    setState(() {
      units = data;
      unitProgress = progressMap; // siempre recalcular
    });
  }

  Future<void> _openMiniaturesScreen(Unit unit) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MiniatureScreen(unit: unit)),
    );
    await loadUnits();
  }

  Future<void> _openUnitEditor({Unit? unit}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UnitEditScreen(unit: unit, armyId: widget.army.id),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      await loadUnits(); // recargar siempre

      final action = result['action'];
      final name = result['name'];
      String message = '';
      if (action == 'created') {
        message = 'Unidad "$name" creada correctamente';
      } else if (action == 'updated') {
        message = 'Unidad "$name" actualizada correctamente';
      } else if (action == 'deleted') {
        message = 'Unidad "$name" eliminada correctamente';
      }

      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  Future<void> _deleteArmy() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar ejército'),
        content: Text(
          'No hay unidades en "${widget.army.name}". ¿Seguro que quieres borrar este ejército?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirm ?? false) {
      await armyRepository.deleteArmy(widget.army.id!);
      Navigator.pop(context, {
        'action': 'deletedArmy',
        'name': widget.army.name,
      });
    }
  }

  Color getProgressColor(double value) {
    if (value < 0.3) return Colors.red;
    if (value < 0.7) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    // Agrupar unidades por rol
    Map<String, List<Unit>> unitsByRole = {};
    for (var unit in units) {
      final roleName = roleNames[unit.roleId ?? 0] ?? 'Sin rol';
      unitsByRole.putIfAbsent(roleName, () => []);
      unitsByRole[roleName]!.add(unit);
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.army.name)),
      body: units.isEmpty
          ? const Center(child: Text('No hay unidades todavía'))
          : ListView(
              children: unitsByRole.entries.map((entry) {
                final roleName = entry.key;
                final roleUnits = entry.value;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ExpansionTile(
                    leading: Image.asset(
                      'assets/icons/rol/${roleCodes.entries.firstWhere((e) => roleNames[e.key] == roleName, orElse: () => MapEntry(0, 'default')).value}.png',
                      width: 28,
                      height: 28,
                      fit: BoxFit.contain,
                    ),
                    title: Text(
                      roleName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: roleUnits.map((unit) {
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: InkWell(
                          borderRadius: BorderRadius.circular(4),
                          onTap: () => _openMiniaturesScreen(unit),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8,
                            ), // amplia zona vertical
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(unit.name),
                                const SizedBox(height: 6),
                                LinearProgressIndicator(
                                  value: unitProgress[unit.id!] ?? 0,
                                  minHeight: 6,
                                  backgroundColor: Colors.grey[300],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    getProgressColor(
                                      unitProgress[unit.id!] ?? 0,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${((unitProgress[unit.id!] ?? 0) * 100).toInt()}%',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _openUnitEditor(unit: unit),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
      floatingActionButton: Stack(
        children: [
          // Botón azul siempre visible para añadir unidad
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _openUnitEditor(),
              child: const Icon(Icons.add),
            ),
          ),
          // Botón rojo solo si no hay unidades
          if (units.isEmpty)
            Positioned(
              bottom: 90,
              right: 16,
              child: FloatingActionButton(
                backgroundColor: Colors.red,
                onPressed: _deleteArmy,
                child: const Icon(Icons.delete),
              ),
            ),
        ],
      ),
    );
  }
}
