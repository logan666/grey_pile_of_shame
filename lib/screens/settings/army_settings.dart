import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/utils/icon_mapping.dart';

class ArmiesSettingsPage extends StatefulWidget {
  const ArmiesSettingsPage({super.key});

  @override
  _ArmiesSettingsPageState createState() => _ArmiesSettingsPageState();
}

class _ArmiesSettingsPageState extends State<ArmiesSettingsPage> {
  List<Game> games = [];
  Map<int, List<Army>> gameArmies = {};
  Map<int, bool> expandedGames = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final loadedGames = await GameRepository().getGames();
    final Map<int, List<Army>> armiesByGame = {};

    for (var game in loadedGames) {
      final armies = await ArmyRepository().getArmiesByGame(game.id!);
      armiesByGame[game.id!] = armies;
    }

    setState(() {
      games = loadedGames;
      gameArmies = armiesByGame;
      expandedGames = {for (var g in loadedGames) g.id!: false};
    });
  }

  // --- VISIBILIDAD ---
  Future<void> _toggleVisible(Army army, bool value) async {
    final updatedArmy = Army(
      id: army.id,
      gameId: army.gameId,
      name: army.name,
      visible: value,
    );

    await ArmyRepository().updateArmy(updatedArmy);

    setState(() {
      final list = gameArmies[army.gameId!]!;
      final index = list.indexWhere((a) => a.id == army.id);
      list[index] = updatedArmy;
    });
  }

  // --- CREAR / EDITAR JUEGO ---
  Future<void> _showGameDialog({Game? game}) async {
    final nameController = TextEditingController(text: game?.name ?? '');

    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(game == null ? 'Nuevo juego' : 'Editar juego'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(hintText: 'Nombre del juego'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, nameController.text),
            child: Text(game == null ? 'Agregar' : 'Guardar'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      if (game == null) {
        // CREAR
        final id = await GameRepository().insertGame(
          Game(name: result).toMap(),
        );
        final newGame = Game(id: id, name: result);
        setState(() {
          games.add(newGame);
          gameArmies[newGame.id!] = [];
          expandedGames[newGame.id!] = false;
        });
      } else {
        // EDITAR
        final updatedGame = Game(id: game.id, name: result);
        await GameRepository().updateGame(updatedGame);
        setState(() {
          final index = games.indexWhere((g) => g.id == game.id);
          games[index] = updatedGame;
        });
      }
    }
  }

  // --- BORRAR JUEGO ---
  Future<void> _deleteGame(Game game) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar borrado'),
        content: Text(
          '¿Deseas borrar el juego "${game.name}" y todos sus ejércitos?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await GameRepository().deleteGame(game.id!);
      setState(() {
        games.removeWhere((g) => g.id == game.id);
        gameArmies.remove(game.id!);
        expandedGames.remove(game.id!);
      });
    }
  }

  // --- CREAR / EDITAR EJÉRCITO ---
  Future<void> _showArmyDialog(int gameId, {Army? army}) async {
    final nameController = TextEditingController(text: army?.name ?? '');

    String? selectedImage = army?.image ?? armyImageMapping.values.first;
    String? selectedLogo = army?.image ?? armyImageMapping.values.first;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(army == null ? 'Nuevo ejército' : 'Editar ejército'),

              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Nombre del ejército',
                    ),
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: selectedImage,

                    decoration: const InputDecoration(
                      labelText: 'Estilo visual',
                    ),

                    items: armyImageMapping.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.value,

                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/armys/${entry.value}',
                              width: 40,
                              height: 40,
                            ),

                            const SizedBox(width: 12),

                            Text(entry.key),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedImage = value;
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  DropdownButtonFormField<String>(
                    value: selectedLogo,

                    decoration: const InputDecoration(labelText: 'Logo'),

                    items: armyImageMapping.entries.map((entry) {
                      return DropdownMenuItem(
                        value: entry.value,

                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/logos/${entry.value}',
                              width: 40,
                              height: 40,
                            ),

                            const SizedBox(width: 12),

                            Text(entry.key),
                          ],
                        ),
                      );
                    }).toList(),

                    onChanged: (value) {
                      setState(() {
                        selectedLogo = value;
                      });
                    },
                  ),
                ],
              ),

              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),

                ElevatedButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(army == null ? 'Agregar' : 'Guardar'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result ?? false) {
      if (army == null) {
        final id = await ArmyRepository().insertArmy(
          Army(
            name: nameController.text,
            gameId: gameId,
            visible: true,
            image: selectedImage,
            logo: selectedLogo,
          ),
        );

        final newArmy = Army(
          id: id,
          name: nameController.text,
          gameId: gameId,
          visible: true,
          image: selectedImage,
          logo: selectedLogo,
        );

        setState(() {
          gameArmies[gameId]!.add(newArmy);
        });
      } else {
        final updatedArmy = Army(
          id: army.id,
          name: nameController.text,
          gameId: army.gameId,
          visible: army.visible,
          image: selectedImage,
          logo: selectedLogo,
        );

        await ArmyRepository().updateArmy(updatedArmy);

        setState(() {
          final list = gameArmies[army.gameId!]!;

          final index = list.indexWhere((a) => a.id == army.id);

          list[index] = updatedArmy;
        });
      }
    }
  }

  // --- BORRAR EJÉRCITO ---
  Future<void> _deleteArmy(Army army) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar borrado'),
        content: Text('¿Deseas borrar el ejército "${army.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await ArmyRepository().deleteArmy(army.id!);
      setState(() {
        gameArmies[army.gameId!]!.removeWhere((a) => a.id == army.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juegos y Ejércitos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showGameDialog(),
          ),
        ],
      ),
      body: ListView(
        children: games.map((game) {
          final armies = gameArmies[game.id!] ?? [];
          final isExpanded = expandedGames[game.id!] ?? false;

          return ExpansionTile(
            key: ValueKey(game.id),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(game.name),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 20),
                      onPressed: () => _showGameDialog(game: game),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 20),
                      onPressed: () => _deleteGame(game),
                    ),
                  ],
                ),
              ],
            ),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                expandedGames[game.id!] = expanded;
              });
            },
            children: [
              ...armies.map((army) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(army.name),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20),
                            onPressed: () =>
                                _showArmyDialog(game.id!, army: army),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20),
                            onPressed: () => _deleteArmy(army),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: army.visible,
                    onChanged: (value) => _toggleVisible(army, value),
                    activeThumbColor: Colors.green,
                    activeTrackColor: Colors.green.shade200,
                  ),
                );
              }).toList(),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Agregar ejército'),
                onTap: () => _showArmyDialog(game.id!),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
