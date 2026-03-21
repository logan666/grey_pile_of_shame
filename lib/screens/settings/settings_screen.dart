import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/screens/edit/game_edit_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.videogame_asset),
            title: const Text('Editar juegos'),
            subtitle: const Text('Cambiar nombre o eliminar juegos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GameEditScreen()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            subtitle: const Text('Gestionar categorías de unidades'),
            onTap: () {
              // futura pantalla de categorías
            },
          ),
        ],
      ),
    );
  }
}
