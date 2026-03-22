import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/screens/settings/settings_screen.dart';
import 'package:grey_pile_of_shame/screens/list/unit_screen.dart';
import 'package:grey_pile_of_shame/utils/icon_mapping.dart';
import 'package:grey_pile_of_shame/utils/progress_bar.dart';
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
  final unitRepository = UnitRepository();
  List<Game> games = [];
  Map<int, List<Army>> armiesByGame = {};
  Map<int, Map<String, int>> armyProgress = {};
  bool isFabOpen = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final loadedGames = await gameRepository.getGames();

    Map<int, List<Army>> map = {};
    Map<int, Map<String, int>> progressMap = {};

    for (var game in loadedGames) {
      if (game.id == null) continue;

      final armies = await armyRepository.getVisibleArmiesByGame(game.id!);

      if (armies.isNotEmpty) {
        map[game.id!] = armies;

        for (var army in armies) {
          final units = await unitRepository.getUnits(army.id!);

          int totalFinished = 0;
          int totalMiniatures = 0;

          for (var unit in units) {
            final stats = await unitRepository.getMiniatureStats(unit.id!);
            totalFinished += stats['finished'] ?? 0;
            totalMiniatures += stats['total'] ?? 0;
          }

          progressMap[army.id!] = {
            'finished': totalFinished,
            'total': totalMiniatures,
          };
        }
      }
    }

    final filteredGames = loadedGames
        .where((g) => map.containsKey(g.id!))
        .toList();

    setState(() {
      games = filteredGames;
      armiesByGame = map;
      armyProgress = progressMap;
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
                      padding: const EdgeInsets.only(
                        left: 40,
                        bottom: 10,
                        right: 16,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UnitScreen(army: army),
                            ),
                          ).then((_) => loadData());
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Imagen del ejército desde el mapping
                                if (armyImageMapping.containsKey(army.name))
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.asset(
                                      'assets/images/logos/${armyLogoMapping[army.name]}',
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.fitWidth,
                                    ),
                                  )
                                else
                                  const SizedBox(
                                    width: 40,
                                    height: 40,
                                  ), // espacio si no hay imagen

                                const SizedBox(width: 8),

                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    army.name,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 6),

                            // Barra de progreso
                            Builder(
                              builder: (_) {
                                final finished =
                                    armyProgress[army.id]?['finished'] ?? 0;
                                final total =
                                    armyProgress[army.id]?['total'] ?? 0;
                                final progress = total > 0
                                    ? finished / total
                                    : 0.0;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    LinearProgressIndicator(
                                      value: progress,
                                      minHeight: 6,
                                      backgroundColor: Colors.grey[300],
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        getProgressColor(progress),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Spacer(),
                                        Text(
                                          '$finished de $total (${(progress * 100).toInt()}%)',
                                          style: const TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
    );
  }
}
