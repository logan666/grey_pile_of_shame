import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/miniature_repository.dart';
import 'package:grey_pile_of_shame/database/repository/paint_status_repository.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'package:grey_pile_of_shame/models/paint_status.dart';
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
  final paintRepository = PaintingStatusRepository();
  List<PaintingStatus> paintingStatuses = [];
  List<Miniature> miniatures = [];
  final armyRepository = ArmyRepository();
  String? armyImage;

  @override
  void initState() {
    super.initState();
    _initScreen();
    loadMiniatures();
    _loadArmyImage();
  }

  Future<void> _loadArmyImage() async {
    final army = await armyRepository.getArmyById(widget.unit.armyId!);

    setState(() {
      armyImage = army?.image;
    });
  }

  Future<void> _initScreen() async {
    paintingStatuses = await paintRepository.getAll();
    await loadMiniatures();
  }

  Future<void> loadMiniatures() async {
    final data = await repo.getMiniatures(widget.unit.id!);
    setState(() => miniatures = data);

    for (var mini in miniatures) {
      if (!paintingStatuses.any((s) => s.id == mini.paintingStatus)) {
        mini.paintingStatus = paintingStatuses.first.id!;
      }
    }
  }

  void _addMiniature() async {
    final descriptionController = TextEditingController(text: widget.unit.name);
    int quantity = 1;

    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.newMiniatureTitle),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Descripción
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.descriptionLabel,
                    ),
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
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(AppLocalizations.of(context)!.add),
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

        final defaultStatusId = paintingStatuses.isNotEmpty
            ? paintingStatuses.first.id as int
            : 1;

        await repo.insertMiniature(
          Miniature(
            unitId: widget.unit.id!,
            description: description,
            paintingStatus: defaultStatusId,
          ),
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
        title: Text(mini.description),
        children: [
          ...paintingStatuses.map((status) {
            final color = _hexToColor(status.color as String);
            final name = status.name as String;
            final id = status.id as int;

            return SimpleDialogOption(
              onPressed: () => Navigator.pop(context, id),
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(name, style: const TextStyle(color: Colors.black)),
                ],
              ),
            );
          }),

          const SizedBox(height: 16),

          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, -99), // código especial
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (selectedStatusId != null) {
      if (selectedStatusId == -99) {
        await repo.deleteMiniature(mini.id!);
      } else {
        mini.paintingStatus = selectedStatusId;
        await repo.updateMiniature(mini);
      }

      await loadMiniatures();
    }
  }

  void _changeAllStatuses() async {
    final newStatusId = await showDialog<int>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(AppLocalizations.of(context)!.changeAllStatusesTooltip),
        children: paintingStatuses.map((status) {
          final color = _hexToColor(status.color as String);
          final name = status.name as String;
          final id = status.id as int;

          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, id),
            child: Row(
              children: [
                // Cambiamos a un círculo
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle, // <-- círculo
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ), // borde negro
                  ),
                ),
                const SizedBox(width: 12),
                Text(name, style: const TextStyle(color: Colors.black)),
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

  Color _hexToColor(String hex) {
    final buffer = StringBuffer();
    if (hex.length == 7) buffer.write('ff');
    buffer.write(hex.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  bool _isFinishedStatus(int statusId) {
    final status = paintingStatuses.firstWhere((s) => s.id == statusId);
    return status.name.toLowerCase() == 'terminado';
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
            tooltip: AppLocalizations.of(context)!.changeAllStatusesTooltip,
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: miniatures.length,
        itemBuilder: (context, index) {
          final mini = miniatures[index];

          final status = paintingStatuses.firstWhere(
            (s) => s.id == mini.paintingStatus,
            orElse: () => PaintingStatus(
              id: 0,
              name: AppLocalizations.of(context)!.unknownStatus,
              orden: 999,
              color: '#9E9E9E',
            ),
          );
          final statusColor = _hexToColor(status.color);
          final statusName = status.name;

          return GestureDetector(
            onTap: () => _changeStatus(mini), // acción al pulsar
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  // Imagen a la derecha usando DecorationImage
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 220,
                      height: 90,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/armys/${armyImage ?? "space_marines.png"}',
                          ),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(1),
                            BlendMode.dstATop,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Círculo de color
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: statusColor,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                        ),
                        if (_isFinishedStatus(status.id!))
                          const Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.white,
                          ),
                      ],
                    ),
                  ),

                  // Texto
                  Positioned(
                    bottom: 8,
                    left: 12,
                    right: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mini.description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          statusName,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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
