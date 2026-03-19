import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';

class GameEditScreen extends StatefulWidget {
  const GameEditScreen({super.key});

  @override
  _GameEditScreenState createState() => _GameEditScreenState();
}

class _GameEditScreenState extends State<GameEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final gameRepository = GameRepository();
  final _nameFocus = FocusNode();
  bool _canSave = false;

  void saveGame() async {
    if (_formKey.currentState!.validate()) {
      final id = await gameRepository.insertGame({
        'name': _nameController.text.trim(),
      });

      print("INSERT RESULT ID: $id");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Juego guardado correctamente')),
      );

      await Future.delayed(const Duration(milliseconds: 500));

      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  void initState() {
    super.initState();

    // Pedir foco al montar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _nameFocus.requestFocus();

      setState(() {
        _canSave = _nameController.text.trim().isNotEmpty;
      });
    });

    // Listener para habilitar/deshabilitar botón
    _nameController.addListener(() {
      final hasText = _nameController.text.trim().isNotEmpty;
      if (hasText != _canSave) {
        setState(() {
          _canSave = hasText;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Sistema de Juego')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                focusNode: _nameFocus,
                decoration: const InputDecoration(
                  labelText: 'Nombre del sistema de juego',
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'El nombre no puede estar vacío'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: saveGame, child: const Text('Guardar')),
            ],
          ),
        ),
      ),
    );
  }
}
