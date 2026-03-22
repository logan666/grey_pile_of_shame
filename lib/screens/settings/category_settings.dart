import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/database/repository/army_category_repository.dart';
import 'package:grey_pile_of_shame/database/repository/game_repository.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'package:grey_pile_of_shame/models/army_category.dart';
import 'package:grey_pile_of_shame/models/game.dart';
import 'package:grey_pile_of_shame/utils/icon_mapping.dart';

class CategorySettingsScreen extends StatefulWidget {
  const CategorySettingsScreen({super.key});

  @override
  State<CategorySettingsScreen> createState() => _CategorySettingsScreenState();
}

class _CategorySettingsScreenState extends State<CategorySettingsScreen> {
  final GameRepository gameRepo = GameRepository();
  final ArmyCategoryRepository catRepo = ArmyCategoryRepository();

  Map<int, List<ArmyCategory>> categoriesByGame = {};
  List<Game> games = [];
  Set<int> expandedGames = {}; // ids de juegos expandibles

  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final gms = await gameRepo.getGames();
    Map<int, List<ArmyCategory>> cats = {};
    for (var g in gms) {
      cats[g.id!] = await catRepo.getCategoriesByGame(g.id!);
    }
    setState(() {
      games = gms;
      categoriesByGame = cats;
      loading = false;
    });
  }

  void _addCategory(int gameId) {
    String newName = '';
    String? newIcon;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.newCategory),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryNameLabel,
              ),
              onChanged: (v) => newName = v,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryIconLabel,
              ),
              onChanged: (v) => newIcon = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              if (newName.trim().isEmpty) return;
              final cat = ArmyCategory(
                gameId: gameId,
                name: newName,
                icon: newIcon,
              );
              await catRepo.addCategory(cat);
              await _loadData();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.add),
          ),
        ],
      ),
    );
  }

  void _editCategory(ArmyCategory cat) {
    String updatedName = cat.name;
    String? updatedIcon = cat.icon;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.editCategory),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryNameLabel,
              ),
              controller: TextEditingController(text: updatedName),
              onChanged: (v) => updatedName = v,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.categoryIconLabel,
              ),
              controller: TextEditingController(text: updatedIcon),
              onChanged: (v) => updatedIcon = v,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              if (updatedName.trim().isEmpty) return;
              final updatedCat = ArmyCategory(
                id: cat.id,
                gameId: cat.gameId,
                name: updatedName,
                icon: updatedIcon,
              );
              await catRepo.updateCategory(updatedCat);
              await _loadData();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  void _deleteCategory(ArmyCategory cat) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteCategoryTitle),
        content: Text(
          AppLocalizations.of(context)!.deleteCategoryContent(cat.name),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              await catRepo.deleteCategory(cat.id!);
              await _loadData();
              Navigator.pop(context);
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return Center(child: CircularProgressIndicator());

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.categorySettingsTitle),
      ),
      body: ListView(
        children: games.map((game) {
          final cats = categoriesByGame[game.id] ?? [];
          final isExpanded = expandedGames.contains(game.id);
          return ExpansionTile(
            key: PageStorageKey(game.id),
            title: Text(
              game.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: isExpanded,
            onExpansionChanged: (val) {
              setState(() {
                if (val)
                  expandedGames.add(game.id!);
                else
                  expandedGames.remove(game.id);
              });
            },
            children: [
              ...cats.map(
                (cat) => ListTile(
                  leading: cat.icon != null && iconMapping.containsKey(cat.icon)
                      ? Icon(iconMapping[cat.icon])
                      : null,
                  title: Text(cat.name),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editCategory(cat),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteCategory(cat),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.add),
                title: Text(AppLocalizations.of(context)!.newCategory),
                onTap: () => _addCategory(game.id!),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
