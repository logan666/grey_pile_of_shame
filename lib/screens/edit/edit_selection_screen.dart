// lib/screens/edit_selection_screen.dart
import 'package:flutter/material.dart';
import 'game_edit_screen.dart';
import 'army_edit_screen.dart';
import 'unit_edit_screen.dart';

class EditSelectionScreen extends StatelessWidget {
  const EditSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear Nuevo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Juego'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GameEditScreen()),
                ).then((value) {
                  if (value == true) {
                    // aquí podrías recargar si hiciera falta
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Ejército'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ArmyEditScreen()),
                );
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: const Text('Unidad'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const UnitEditScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
