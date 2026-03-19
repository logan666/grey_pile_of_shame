import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'package:grey_pile_of_shame/screens/list/unit_screen.dart';
import '../../models/army.dart';
import '../edit/edit_selection_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gameRepository = GameRepository();
  final armyRepository = ArmyRepository();
  final unitRepository = UnitRepository();
  List<Game> games = [];
  Map<int, List<Army>> armiesByGame = {};

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final loadedGames = await gameRepository.getGames();

    Map<int, List<Army>> map = {};

    for (var game in loadedGames) {
      if (game.id == null) continue;

      final armies = await armyRepository.getArmiesByGame(game.id!);
      map[game.id!] = armies;
    }

    setState(() {
      games = loadedGames;
      armiesByGame = map;
    });
  }

  Future<void> deleteGame(int id) async {
    await gameRepository.deleteGame(id);
    await loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grey Pile of Shame')),
      body: games.isEmpty
          ? const Center(child: Text('No hay juegos todavía'))
          : ListView(
              children: games.map((game) {
                final armies = armiesByGame[game.id] ?? [];

                return ExpansionTile(
                  key: Key(game.id.toString()),

                  leading: armies.isEmpty
                      ? IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Eliminar juego'),
                                content: Text(
                                  '¿Seguro que quieres borrar "${game.name}"?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Eliminar'),
                                  ),
                                ],
                              ),
                            );

                            if (confirm ?? false) {
                              await deleteGame(game.id!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${game.name} eliminado'),
                                ),
                              );
                              await loadData();
                            }
                          },
                        )
                      : null,
                  title: Text(
                    game.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: armies.map((army) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 6),
                      child: ListTile(
                        leading: const Icon(Icons.shield, size: 18),
                        title: Text(army.name),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UnitScreen(army: army),
                            ),
                          ).then((_) => loadData()); // refresca al volver
                        },
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const EditSelectionScreen()),
          ).then((_) => loadData());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
