import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_category_repository.dart';
import 'package:grey_pile_of_shame/database/repository/army_repository.dart';
import 'package:grey_pile_of_shame/database/repository/parametric_repository.dart';
import 'package:grey_pile_of_shame/database/repository/unit_repository.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'package:grey_pile_of_shame/models/army_category.dart';
import 'package:grey_pile_of_shame/models/unit.dart';
import 'package:grey_pile_of_shame/models/army.dart';
import 'package:grey_pile_of_shame/screens/edit/unit_edit_screen.dart';
import 'package:grey_pile_of_shame/screens/list/miniature_screen.dart';
import 'package:grey_pile_of_shame/utils/icon_mapping.dart';
import 'package:grey_pile_of_shame/utils/progress_bar.dart';

class UnitScreen extends StatefulWidget {
  final Army army;
  const UnitScreen({super.key, required this.army});

  @override
  _UnitScreenState createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UnitScreen> {
  final unitRepository = UnitRepository();
  final armyRepository = ArmyRepository();
  final categoryRepository = ArmyCategoryRepository();
  final parametricRepository = ParametricRepository();

  List<Unit> units = [];

  List<ArmyCategory> categories = [];
  Map<int, String> categoryNames = {};
  Map<int, String> categoryIcons = {};

  Map<int, Map<String, int>> unitProgress = {}; // finished + total

  @override
  void initState() {
    super.initState();
    _loadCategories().then((_) => loadUnits());
  }

  Future<void> _loadCategories() async {
    categories = await categoryRepository.getCategoriesByGame(
      widget.army.gameId!,
    );

    categoryNames = {for (var c in categories) c.id!: c.name};
    categoryIcons = {for (var c in categories) c.id!: c.icon ?? 'default'};
  }

  Future<void> loadUnits() async {
    final data = await unitRepository.getUnits(widget.army.id!);

    Map<int, Map<String, int>> progressMap = {};

    for (var unit in data) {
      final stats = await unitRepository.getMiniatureStats(unit.id!);
      final total = stats['total'] ?? 0;
      final finished = stats['finished'] ?? 0;
      progressMap[unit.id!] = {'finished': finished, 'total': total};
    }

    setState(() {
      units = data;
      unitProgress = progressMap;
    });
  }

  Future<void> _openMiniaturesScreen(Unit unit) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MiniatureScreen(unit: unit)),
    );
    await loadUnits();
  }

  double getArmyProgress() {
    int totalFinished = 0;
    int totalUnits = 0;
    unitProgress.forEach((_, stats) {
      totalFinished += stats['finished'] ?? 0;
      totalUnits += stats['total'] ?? 0;
    });
    return totalUnits > 0 ? totalFinished / totalUnits : 0.0;
  }

  Future<void> _openUnitEditor({Unit? unit}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UnitEditScreen(unit: unit, armyId: widget.army.id),
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      await loadUnits();

      final action = result['action'];
      final name = result['name'];
      String message = '';
      if (action == 'created') {
        message = AppLocalizations.of(context)!.unitCreated(name);
      } else if (action == 'updated') {
        message = AppLocalizations.of(context)!.unitUpdated(name);
      } else if (action == 'deleted') {
        message = AppLocalizations.of(context)!.unitDeleted(name);
      }

      if (message.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<ArmyCategory, List<Unit>> unitsByCategory = {};
    for (var unit in units) {
      final category = categories.firstWhere(
        (c) => c.id == unit.roleId, // roleId ahora apunta a categoryId
        orElse: () => ArmyCategory(
          id: 0,
          gameId: widget.army.gameId!,
          name: AppLocalizations.of(context)!.uncategorized,
          icon: 'default',
        ),
      );
      unitsByCategory.putIfAbsent(category, () => []);
      unitsByCategory[category]!.add(unit);
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            if (armyImageMapping.containsKey(widget.army.name))
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/logos/${armyImageMapping[widget.army.name]}',
                  width: 28,
                  height: 28,
                  fit: BoxFit.contain,
                ),
              )
            else
              const SizedBox(width: 28, height: 28),

            const SizedBox(width: 8),

            Text(widget.army.name),
          ],
        ),
      ),
      body: units.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.noUnitsYet))
          : Column(
              children: [
                // Barra total del ejército
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      LinearProgressIndicator(
                        value: getArmyProgress(),
                        minHeight: 8,
                        backgroundColor: Colors.grey[300],
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getProgressColor(getArmyProgress()),
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Totales alineados a la derecha
                      Padding(
                        padding: const EdgeInsets.only(right: 4),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              '${unitProgress.values.fold<int>(0, (sum, e) => sum + (e['finished'] ?? 0))} '
                              '${AppLocalizations.of(context)!.ofTotal} '
                              '${unitProgress.values.fold<int>(0, (sum, e) => sum + (e['total'] ?? 0))} '
                              '(${(getArmyProgress() * 100).toInt()}%)',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                // Lista de unidades por rol
                Expanded(
                  child: ListView(
                    children: unitsByCategory.entries.map((entry) {
                      final category = entry.key;
                      final categoryUnits = entry.value;
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ExpansionTile(
                          leading: Icon(
                            iconMapping[category.icon ?? 'default'] ??
                                Icons.shield,
                            size: 28,
                            color: Colors.blueGrey, // opcional
                          ),
                          title: Text(
                            category.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          children: categoryUnits.map((unit) {
                            final finished =
                                unitProgress[unit.id!]?['finished'] ?? 0;
                            final total = unitProgress[unit.id!]?['total'] ?? 0;
                            final progress = total > 0 ? finished / total : 0.0;
                            return ListTile(
                              leading: const Icon(Icons.person),
                              title: InkWell(
                                borderRadius: BorderRadius.circular(4),
                                onTap: () => _openMiniaturesScreen(unit),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(unit.name),
                                      const SizedBox(height: 6),
                                      LinearProgressIndicator(
                                        value: progress,
                                        minHeight: 6,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              getProgressColor(progress),
                                            ),
                                      ),
                                      const SizedBox(height: 4),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            const Spacer(),
                                            Text(
                                              '$finished ${AppLocalizations.of(context)!.ofTotal} $total (${(progress * 100).toInt()}%)',
                                              style: const TextStyle(
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _openUnitEditor(unit: unit),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
      floatingActionButton: Stack(
        children: [
          // Botón azul siempre visible para añadir unidad
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => _openUnitEditor(),
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
