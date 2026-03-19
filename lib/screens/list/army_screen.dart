import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'unit_screen.dart';

class ArmiesScreen extends StatefulWidget {
  final Game game;
  const ArmiesScreen({required this.game, super.key});

  @override
  _ArmiesScreenState createState() => _ArmiesScreenState();
}

class _ArmiesScreenState extends State<ArmiesScreen> {
  final armyRepository = ArmyRepository();
  List<Army> armies = [];

  @override
  void initState() {
    super.initState();
    loadArmies();
  }

  Future<void> loadArmies() async {
    final loadedArmies = await armyRepository.getAllArmies();
    setState(() {
      armies = loadedArmies;
    });
  }

  Future<void> addArmy() async {
    final newArmy = Army(
      id: null,
      gameId: widget.game.id!,
      name: 'Nuevo Ejército',
    );
    await armyRepository.insertArmy(newArmy.toMap());
    await loadArmies();
  }

  Future<void> deleteArmy(Army army) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar ejército'),
        content: Text('¿Seguro que quieres borrar "${army.name}"?'),
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
      await armyRepository.deleteArmy(army.id!);
      await loadArmies();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ejército "${army.name}" eliminado correctamente'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.game.name),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: addArmy)],
      ),
      body: armies.isEmpty
          ? const Center(child: Text('No hay ejércitos todavía'))
          : ListView.builder(
              itemCount: armies.length,
              itemBuilder: (context, index) {
                final army = armies[index];

                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.shield,
                    ), // Aquí puedes poner el icono del ejército
                  ),
                  title: Text(army.name),
                  trailing: FutureBuilder<bool>(
                    future: armyRepository.hasUnits(army.id!),
                    builder: (context, snapshot) {
                      final hasUnits = snapshot.data ?? true;

                      // Si tiene unidades, no mostramos el botón de borrar
                      if (hasUnits) return const Icon(Icons.arrow_forward);

                      // Si no tiene unidades, mostramos el botón de borrar
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_forward),
                            onPressed: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UnitScreen(army: army),
                                ),
                              );
                              await loadArmies();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteArmy(army),
                          ),
                        ],
                      );
                    },
                  ),
                  onTap: () async {
                    // Abrir listado de unidades
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => UnitScreen(army: army)),
                    );
                    await loadArmies();
                  },
                );
              },
            ),
    );
  }
}
