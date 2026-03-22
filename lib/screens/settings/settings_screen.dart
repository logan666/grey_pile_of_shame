import 'package:flutter/material.dart';
import 'package:grey_pile_of_shame/l10n/app_localizations.dart';
import 'package:grey_pile_of_shame/screens/settings/army_settings.dart';
import 'package:grey_pile_of_shame/screens/settings/category_settings.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settingsTitle)),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.shield),
            title: Text(AppLocalizations.of(context)!.armiesTitle),
            subtitle: Text(AppLocalizations.of(context)!.armiesSubtitle),
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
            title: Text(AppLocalizations.of(context)!.categoriesTitle),
            subtitle: Text(AppLocalizations.of(context)!.categoriesSubtitle),
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
