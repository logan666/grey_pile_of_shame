import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/screens/edit/army_edit_screen.dart'
    show ArmyEditScreen;
import 'package:grey_pile_of_shame/screens/edit/game_edit_screen.dart';
import 'package:grey_pile_of_shame/screens/settings/settings_screen.dart';
import 'package:grey_pile_of_shame/screens/list/unit_screen.dart';
import '../../models/army.dart';
import '../../models/game.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gameRepository = GameRepository();
  final armyRepository = ArmyRepository();
  List<Game> games = [];
  Map<int, List<Army>> armiesByGame = {};
  bool isFabOpen = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    // Traer todos los juegos visibles
    final loadedGames = await gameRepository.getGames();

    Map<int, List<Army>> map = {};

    for (var game in loadedGames) {
      if (game.id == null) continue;

      // Traer solo ejércitos visibles de este juego
      final armies = await armyRepository.getVisibleArmiesByGame(game.id!);

      if (armies.isNotEmpty) {
        map[game.id!] = armies;
      }
    }

    // Filtrar juegos que tengan al menos un ejército visible
    final filteredGames = loadedGames
        .where((g) => map.containsKey(g.id!))
        .toList();

    setState(() {
      games = filteredGames;
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
      appBar: AppBar(
        title: const Text('Grey Pile of Shame'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ).then((_) => loadData()); // refresca al volver
            },
          ),
        ],
      ),
      body: games.isEmpty
          ? const Center(child: Text('No hay juegos con ejércitos visibles'))
          : ListView(
              children: games.map((game) {
                final armies = armiesByGame[game.id] ?? [];

                return ExpansionTile(
                  key: Key(game.id.toString()),
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
                          ).then((_) => loadData());
                        },
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
    );
  }
}
