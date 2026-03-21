import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/screens/settings/army_settings.dart';
import 'package:grey_pile_of_shame/screens/settings/category_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: const Text('Ejércitos'),
            subtitle: const Text('Mostrar u ocultar ejércitos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ArmiesSettingsPage()),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Categorías'),
            subtitle: const Text('Gestionar categorías de unidades'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CategorySettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
