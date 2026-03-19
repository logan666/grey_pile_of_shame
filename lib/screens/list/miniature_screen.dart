import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/miniature_repository.dart';
import 'package:grey_pile_of_shame/database/repository/parametric_repository.dart';
import 'package:grey_pile_of_shame/models/unit.dart';
import 'package:grey_pile_of_shame/models/miniature.dart';

class MiniatureScreen extends StatefulWidget {
  final Unit unit;
  const MiniatureScreen({super.key, required this.unit});

  @override
  _MiniatureScreenState createState() => _MiniatureScreenState();
}

class _MiniatureScreenState extends State<MiniatureScreen> {
  final repo = MiniatureRepository();
  final parametricRepository = ParametricRepository();
  List<Map<String, dynamic>> paintingStatuses = [];
  List<Miniature> miniatures = [];

  @override
  void initState() {
    super.initState();
    _initScreen();
    loadMiniatures();
  }

  Future<void> _initScreen() async {
    paintingStatuses = await parametricRepository.getPaintingStatuses();
    await loadMiniatures();
  }

  Future<void> loadMiniatures() async {
    final data = await repo.getMiniatures(widget.unit.id!);
    setState(() => miniatures = data);

    for (var mini in miniatures) {
      if (!paintingStatuses.any((s) => s['id'] == mini.paintingStatus)) {
        print(
          'Miniatura "${mini.description}" tiene estado inválido: ${mini.paintingStatus}',
        );
      }
    }
  }

  void _addMiniature() async {
    final descriptionController = TextEditingController();
    int quantity = 1;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Nueva Miniatura'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Descripción
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Descripción'),
                  ),

                  const SizedBox(height: 16),

                  // Selector cantidad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() => quantity++);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Añadir'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result ?? false) {
      final baseDescription = descriptionController.text.trim();

      for (int i = 0; i < quantity; i++) {
        final description = quantity == 1
            ? baseDescription
            : ('$baseDescription ${i + 1}');

        await repo.insertMiniature(
          Miniature(unitId: widget.unit.id!, description: description),
        );
      }

      await loadMiniatures();
    }
  }

  void _changeStatus(Miniature mini) async {
    // Abrir un diálogo similar al de "Aplicar a todas"
    final selectedStatusId = await showDialog<int>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text('Cambiar estado de "${mini.description}"'),
        children: paintingStatuses.map((status) {
          final color = _hexToColor(status['color'] as String);
          final name = status['name'] as String;
          final id = status['id'] as int;

          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, id),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                const SizedBox(width: 12),
                Text(name),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selectedStatusId != null) {
      mini.paintingStatus = selectedStatusId;
      await repo.updateMiniature(mini);
      await loadMiniatures();
    }
  }

  void _changeAllStatuses() async {
    final newStatusId = await showDialog<int>(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('Aplicar a todas'),
        children: paintingStatuses.map((status) {
          final color = _hexToColor(status['color'] as String);
          final name = status['name'] as String;
          final id = status['id'] as int;

          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, id),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
                const SizedBox(width: 12),
                Text(name),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (newStatusId != null) {
      await repo.updateAllStatuses(widget.unit.id!, newStatusId);
      await loadMiniatures();
    }
  }

  Color _statusColor(int statusId) {
    final status = paintingStatuses.firstWhere(
      (s) => s['id'] == statusId,
      orElse: () => {'color': '#9E9E9E'},
    );

    return _hexToColor(status['color']);
  }

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.unit.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: _changeAllStatuses,
            tooltip: 'Cambiar estado de todas',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: miniatures.length,
        itemBuilder: (context, index) {
          final mini = miniatures[index];
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _statusColor(mini.paintingStatus),
                minimumSize: const Size.fromHeight(60),
              ),
              onPressed: () => _changeStatus(mini),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mini.description,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    paintingStatuses.firstWhere(
                          (s) => s['id'] == mini.paintingStatus,
                        )['name'] ??
                        '',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMiniature,
        child: const Icon(Icons.add),
      ),
    );
  }
}
