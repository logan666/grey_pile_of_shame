import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'package:grey_pile_of_shame/screens/edit/game_edit_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final gameRepository = GameRepository();
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
    });
  }

  void _showAddGameDialog() {
    bool isValid = false;
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Crear Nuevo Sistema de Juego'),
              content: TextField(
                controller: controller,
                autofocus: true,
                maxLength: 50,
                decoration: const InputDecoration(
                  labelText: 'Nombre del juego',
                ),
                onChanged: (value) {
                  setState(() {
                    isValid = value.trim().isNotEmpty;
                  });
                },
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: isValid
                      ? () async {
                          await gameRepository.insertGame({
                            'name': controller.text.trim(),
                          });

                          Navigator.pop(dialogContext);

                          await loadGames();

                          ScaffoldMessenger.of(this.context).showSnackBar(
                            const SnackBar(
                              content: Text('Juego guardado correctamente'),
                            ),
                          );
                        }
                      : null,
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grey Pile of Shame'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddGameDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return ListTile(
            title: Text(game.name),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GameEditScreen()),
              ).then((_) {
                loadGames();
              });
            },
          );
        },
      ),
    );
  }
}
