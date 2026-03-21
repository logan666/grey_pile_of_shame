import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';

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
    // Cargar juegos visibles
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ejércitos')),
      body: ListView(
        children: games.map((game) {
          final armies = gameArmies[game.id!] ?? [];
          final isExpanded = expandedGames[game.id!] ?? false;

          return ExpansionTile(
            key: ValueKey(game.id),
            title: Text(game.name),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                expandedGames[game.id!] = expanded;
              });
            },
            children: armies.map((army) {
              return ListTile(
                title: Text(army.name),
                trailing: Switch(
                  value: army.visible,
                  onChanged: (value) => _toggleVisible(army, value),
                  activeThumbColor: Colors.green,
                  activeTrackColor: Colors.green.shade200,
                ),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}
