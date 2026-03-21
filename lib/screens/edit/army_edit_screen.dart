import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/models/game.dart';

class ArmyEditScreen extends StatefulWidget {
  const ArmyEditScreen({super.key});

  @override
  _ArmyEditScreenState createState() => _ArmyEditScreenState();
}

class _ArmyEditScreenState extends State<ArmyEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Game? selectedGame;

  final gameRepository = GameRepository();
  final armyRepository = ArmyRepository();
  List<Game> games = [];

  @override
  void initState() {
    super.initState();
    loadGames();
  }

  Future<void> loadGames() async {
    final loadedGames = await gameRepository.getGames();
    setState(() {
      games = loadedGames;
      if (games.isNotEmpty) selectedGame = games[0];
    });
  }

  void saveArmy() async {
    /*if (_formKey.currentState!.validate() && selectedGame != null) {
      final armyMap = {
        'name': _nameController.text,
        'game_id': selectedGame!.id,
      };
      await armyRepository.insertArmy(armyMap);
      Navigator.pop(context, true);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Ejército')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del ejército',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'El nombre no puede estar vacío'
                    : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<Game>(
                value: selectedGame,
                items: games
                    .map(
                      (game) =>
                          DropdownMenuItem(value: game, child: Text(game.name)),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGame = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Juego asociado'),
                validator: (value) =>
                    value == null ? 'Selecciona un juego' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: saveArmy, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
