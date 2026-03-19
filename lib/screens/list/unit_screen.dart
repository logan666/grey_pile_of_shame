import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/models/unit.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/screens/edit/unit_edit_screen.dart';

class UnitScreen extends StatefulWidget {
  final Army army;
  const UnitScreen({super.key, required this.army});

  @override
  _UnitScreenState createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final unitRepository = UnitRepository();
  final armyRepository = ArmyRepository();
  List<Unit> units = [];

  @override
  void initState() {
    super.initState();
    loadUnits();
  }

  Future<void> loadUnits() async {
    final data = await unitRepository.getUnits(widget.army.id!);
    setState(() {
      units = data;
    });
  }

  Future<void> _openUnitEditor({Unit? unit}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UnitEditScreen(unit: unit, armyId: widget.army.id),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      final action = result['action'];
      final name = result['name'];
      await loadUnits();

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
      await armyRepository.deleteArmy(
        widget.army.id!,
      ); // Asumiendo que tu repo tiene este método
      Navigator.pop(context, {
        'action': 'deletedArmy',
        'name': widget.army.name,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.army.name)),
      body: units.isEmpty
          ? const Center(child: Text('No hay unidades todavía'))
          : ListView.builder(
              itemCount: units.length,
              itemBuilder: (context, index) {
                final unit = units[index];
                return ListTile(
                  title: Text(unit.name),
                  onTap: () => _openUnitEditor(unit: unit),
                );
              },
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
